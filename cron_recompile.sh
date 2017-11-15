#! /bin/bash

echo start recompile repo

echo 1:"$1" #base_folder
echo 2:"$2" #lunch

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

cd "/home/bit/bitwork/""$BASE_FOLDER"
echo cd1 "$?"

#export JACK_SERVER=false
#export JACK_REPOSITORY=prebuilts/sdk/tools/jacks/
export USER=$(whoami)

echo user: "$USER"

source build/envsetup.sh
echo build envsetup "$?"
lunch "$LUNCH"
echo lunch "$LUNCH" "$?"
LOG=$PWD/log.$(date +%m%d%H%M%S).txt
make -j 8  2>&1 | tee "$LOG"
echo make end "$?"

