#! /bin/bash


# automatically check the dependency bt recursively make... 

echo $0
echo $1 #$1 should be `gettop`
echo $2 # default source path is ~/tmp/boardname

cd $1
source build/envsetup.sh

lunchop(){
lunch sp9830a_5h10_5m_native-userdebug
if [ $? -eq 0 ]
then
echo lunch success
else
echo lunch failed
fi
}

cd system/bt


source_path='/home7/bitliu/tmp'

#cat 1.txt | grep "No rule to make target" | sed 's/.*\(out\/target\/product\/.*\), needed.*/\1/g' | sed 's/\(.*\)\/.*/\1/g'

#cplib=`cat 1.txt | grep "No rule to make target" | sed 's/.*\(out\/target\/product\/.*\), needed.*/\1/g' | sed 's/\(.*\)\/.*/\1/g'`
#cplibshort=`echo ${cplib} | sed 's/out\/target\/product\///g'`

#echo ${cplib}
#echo ${cplibshort}


#mkdir -p "$1/${cplib}"
#echo "${source_path}/${cplibshort}" "$1/${cplib}"

#cp "${source_path}/${cplibshort}" "$1/${cplib}" -rfP


a(){
cp ${source_path}/
#cp "/home7/bitliu/tmp/scx35l64_sp9838aea_5mod/obj/${cppath}" "./obj/${cppath}" -rf
}



for (( i=0 ; i < 100 ; i++ ))
do

cplib=`mm 2>&1 | grep "No rule to make target" | sed 's/.*\(out\/target\/product\/.*\), needed.*/\1/g'`
if [[ ${cplib} =~ .*\.so|.*\.o ]]
then true
#only cp so
cplib=${cplib%\'*}
else
cplib=${cplib%/*}
#cp folder
fi


# | sed 's/\(.*\)\/.*/\1/g'`
echo ${cplib}

if [ -z ${cplib} ]
then
echo $i
exit 0
fi

dest_folder_path="$1/${cplib}"
mkdir -p ${dest_folder_path%/*}

cplibshort=`echo ${cplib} | sed 's/out\/target\/product\///g'`

#cp "${source_path}/${cplibshort}" "$1/${cplib}" -rfP
cp "${source_path}/${cplibshort}" "$1/${cplib}" -rf

done





