#! /bin/bash

echo start repo init sync compile

export USER=$(whoami)
echo user: "$USER"

echo 1:"$1" #base_folder
echo 2:"$2" #lunch
echo 3:"$3" #repo

if [ -z "$1" ]
then
BASE_FOLDER="tmo8_tmp"
else
BASE_FOLDER="$1"
fi

echo "${BASE_FOLDER}"

if [ -z "$2" ]
then
LUNCH="grover-eng"
else
LUNCH="$2"
fi

echo "${LUNCH}"

if [ -z "$3" ]
then
REPO="MSM8909W_NOUGAT_20170106.xml"
else
REPO="$3"
fi

echo "${REPO}"

REPO_PATH="/usr/local/bin/repo"


cd "/home/bit/bitwork"
echo cd1 "$?"
rm "${BASE_FOLDER}" -rf
echo rm "$?"
mkdir "${BASE_FOLDER}"
echo mkdir "$?"
cd "/home/bit/bitwork/${BASE_FOLDER}"
echo cd2 "$?"

echo `pwd`

#export JACK_SERVER=false
#export JACK_REPOSITORY=prebuilts/sdk/tools/jacks/



echo repo init start
"${REPO_PATH}" init -u ssh://gerrit.blackshark.com:29418/git/android/platform/manifest -b zs_master -m "zeusis/${REPO}"  --repo-url ssh://gerrit.blackshark.com:29418/git/android/tools/repo --repo-branch stable --no-repo-verify -q --reference /home/mirror && sed -i 's/gerrit.blackshark.com/gerrit-sh.blackshark.com/g' .repo/manifests.git/config
echo repo init end "$?"


echo repo sync start
"${REPO_PATH}" sync -d -j4
echo repo sync end "$?"

source build/envsetup.sh
echo build envsetup "$?"
lunch "$LUNCH"
echo lunch "$LUNCH" "$?"

LOG=$PWD/log.$(date +%m%d%H%M%S).txt
make -j 8  2>&1 | tee "$LOG"
echo make end "$?"

