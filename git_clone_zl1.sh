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
zl1_open_mp_shipping_20160824
zl1_open_mp_shipping_20161014
zl1_os_mp_shipping_20160913
zl1_stable_020_20161117
zl1_stable_5.9_20161031
zl1_mp_shipping_20160713
zl1_mp_shipping_v2.1_factory_20160727
zl1_mp_shipping_vipbeta_20160805
zl1_na1_mp_shipping_20161026
zl1_na2_mp_shipping_20161026
zl1_na3_mp_shipping_20161026
zl1_na_debug_shipping_20161008
zl1_na_mp1_shipping_20161026
zl1_na_mp2_shipping_20161026
zl1_na_mp3_shipping_20161026
zl1_na_mp_shipping_20160921
zl1_na_stable_019_20161104
zl1_na_stable_020_20161104
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
#git clone gitadmin@gitsrv01.spreadtrum.com:android/$repository -b "$branch"  "$repository"

#
#/home/zeusis-mirror/ruby/platform/system/bt.git
#echo git clone dianar:ruby/${repository} -b ${branch} --reference /home/zeusis-mirror/ruby/${repository}.git
git clone dianar:ruby/${repository} -b ${branch} --reference /home/zeusis-mirror/ruby/${repository}.git "$repository" 

