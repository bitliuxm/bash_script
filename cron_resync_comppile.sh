#! /bin/bash

echo start resync and compile

echo 1:"$1" #base_folder
echo 2:"$2" #lunch
echo 3:"$3" #repo

if [ -z "$1" ]
then
BASE_FOLDER="tmp_tmo2"
else
BASE_FOLDER="$1"
fi

echo base_folder: "$BASE_FOLDER"

if [ -z "$2" ]
then
LUNCH="grover-userdebug"
else
LUNCH="$2"
fi

echo lunch: "$LUNCH"

if [ -z "$3" ]
then
REPO="MSM8909W_NOUGAT_20170106.xml"
else
REPO="$3"
fi

echo "$REPO"

if [ -e "/home/bit/bitwork/""$BASE_FOLDER""/.repo/manifest.xml" ]
then
echo folder exist, start sync and build
else
echo folder not existing, redo the download
/home/bit/bitwork/github/bash_script/cron_repoInit_compile.sh "$1" "$2" "$3"
exit 0
fi
REPO_PATH=/usr/local/bin/repo

cd "/home/bit/bitwork/""$BASE_FOLDER"
echo cd end "$?"

#export JACK_SERVER=false
#export JACK_REPOSITORY=prebuilts/sdk/tools/jacks/
export USER=$(whoami)

echo user: "$USER"

sed -i 's/gerrit.blackshark.com/gerrit-sh.blackshark.com/g' .repo/manifests.git/config


cd "/home/bit/bitwork/""$BASE_FOLDER""/.repo/manifests/" && git pull

cd "/home/bit/bitwork/""$BASE_FOLDER"

"$REPO_PATH" forall -c "git stash -u"
echo repo forall stash end "$?"

#"$REPO_PATH" forall -c "git reset HEAD --hard"
#echo repo forall reset end "$?"

#"$REPO_PATH" forall -c "git clean -df"
#echo repo forall clean end "$?"

echo repo sync start
"$REPO_PATH" sync -d -j4
echo repo sync end "$?"

source build/envsetup.sh
echo build envsetup "$?"
lunch "$LUNCH"
echo lunch "$LUNCH" "$?"

LOG=$PWD/log.$(date +%m%d%H%M%S).txt
make -j 8  2>&1 | tee "$LOG"
echo make end "$?"

