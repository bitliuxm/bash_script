#!/bin/bash
FILE_LOG="log.txt"
DIR_REPO=".repo"
BRANCH=$1
BOARD=$2
INIT_URL="gitadmin@gitsrv01.spreadtrum.com:android/platform/manifest.git"
TOOLS_URL="gitadmin@gitsrv01.spreadtrum.com:tools/newrepo.git"

#check log file
if [ -f ${FILE_LOG} ]; then
    rm ${FILE_LOG}
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: WARNING "${FILE_LOG}" is exist, remove it!" 2>&1 | tee -a ${FILE_LOG}
fi

#check repo dir
if [ -d ${DIR_REPO} ]; then
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: ERROR "${DIR_REPO}" is exist!" 2>&1 | tee -a ${FILE_LOG}
    #exit -1
fi


# check branch
if [ "${BRANCH}" = "" ]; then
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: branch is NULL, please input your branch" 2>&1 | tee -a ${FILE_LOG}
    exit -1
fi


# check board
if [ "${BOARD}" = "" ]; then
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: board is NULL, please input your board" 2>&1 | tee -a ${FILE_LOG}
    exit -1
fi


echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: Start build branch: "${BRANCH}" board: "${BOARD} 2>&1 | tee -a ${FILE_LOG}


#start repo init
#REPO_INIT_COMMAND="repo init -u "${INIT_URL}" -b "${BRANCH}" --repo-url="${TOOLS_URL} 2>&1
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo init ..." 2>&1 | tee -a ${FILE_LOG}
repo init -u ${INIT_URL} -b ${BRANCH} --repo-url=${TOOLS_URL} 2>&1 | tee -a ${FILE_LOG}
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo init done..." 2>&1 | tee -a ${FILE_LOG}
if [ $? -eq 0 ];then
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo init success" 2>&1 | tee -a ${FILE_LOG}
else
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo init failed" 2>&1 | tee -a ${FILE_LOG}
    exit -1
fi

#repo sync start
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo sync start ..." 2>&1 | tee -a ${FILE_LOG}
repo sync -d -c -q -j8
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo sync done"
if [ $? -eq 0 ];then
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo sync success" 2>&1 | tee -a ${FILE_LOG}
else
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: repo sync failed" 2>&1 | tee -a ${FILE_LOG}
    exit -1
fi

#set env
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: set env start ..." 2>&1 | tee -a ${FILE_LOG}
source build/envsetup.sh #2>&1 | tee -a ${FILE_LOG}
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: set env done ..." 2>&1 | tee -a ${FILE_LOG}
if [ $? -eq 0 ];then
    echo "set env success" 2>&1 | tee -a ${FILE_LOG}
else
    echo "set env failed" 2>&1 | tee -a ${FILE_LOG}
    exit -1
fi

#lunch board
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: lunch board: "${BOARD}" start ..." 2>&1 | tee -a ${FILE_LOG}
lunch ${BOARD} #2>&1 | tee -a ${FILE_LOG}
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: lunch board: "${BOARD}" done ..." 2>&1 | tee -a ${FILE_LOG}
if [ $? -eq 0 ];then
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: lunch board success" 2>&1 | tee -a ${FILE_LOG}
else
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: lunch board failed" 2>&1 | tee -a ${FILE_LOG}
    exit -1
fi

#android make
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: android make start" 2>&1 | tee -a ${FILE_LOG}
make -j32  2>&1 | tee -a ${FILE_LOG}
echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: android make done" 2>&1 | tee -a ${FILE_LOG}
if [ $? -eq 0 ];then
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: android make success" 2>&1 | tee -a ${FILE_LOG}
else
    echo "[" $(date "+%Y-%m-%d %H:%M:%S")" ]: android make failed" 2>&1 | tee -a ${FILE_LOG}
    exit -1
fi
