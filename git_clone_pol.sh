#! /bin/bash

#git clone dianar:android/platform/system/bt -b zl1_na_stable_020_20161104 --reference /home/zeusis-mirror

#git clone dianar:android/platform/system/bt -b letv_master -m letv/ZL1_STABLE_5.9_20161031.xml  --repo-url=dianar:tools/repo.git --no-repo-verify --reference /home/zeusis-mirror

#ls -al /home/zeusis-mirror/ruby/platform/system/bt.git


#usage:
#git clone -b xx
#git_clone_zl1 repo branch

#echo repo: $1
#echo branch: $2

repositories="
platform/system/bt
platform/hardware/libhardware
platform/packages/apps/Bluetooth
platform/frameworks/base
platform/external/bluetooth/bluedroid
kernel/common
device/sprd
device/sprd/scx35l
device/sprd/whale
device/sprd/whale2
vendor/sprd/modules/bt
vendor/sprd/proprietories-source/connconfig
vendor/sprd/proprietories-source/bt
vendor/sprd/open-source
vendor/sprd/wcn
vendor/sprd/proprietories-source/engmode
"

branches="
msm8953_nougat_r03000_20161013
"

if [ -z $2 ]
then
PS3='select repositories ' # Sets the prompt string.
                                       # Otherwise it defaults to #? .
select repository in $repositories
do
  break  # What happens if there is no 'break' here?
done
else
repository="$2"
fi

echo '###' repository selected: $repository '###'

if [ -z $1 ]
then

PS3='select branches ' # Sets the prompt string.
                                       # Otherwise it defaults to #? .
select branch in $branches
do
  break  # What happens if there is no 'break' here?
done
else
branch="$1"
fi

echo '###' branch selected: $branch '###'

set -x
# usage: git clone [options] [--] <repo> [<dir>]
mkdir -p ${repository}

#/home/mirror/platform/system/bt.git
git clone ssh://gerrit.zeusis.com:29418/git/android/${repository} -b ${branch} --reference /home/mirror/${repository}.git "$repository" 

