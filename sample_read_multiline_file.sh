#! /bin/bash


if [ -z "${git_projects}" ]
then
#try to use the file under current folder with name "project_config.txt"
default_project_config="project_config.txt"
if [ -e "${default_project_config}" ]
then
echo git_projects not specified use ${default_project_config}> /dev/fd/2
git_projects=`cat "${default_project_config}" | grep -e "^[^#]"`
else
echo git_projects not specified use default value > /dev/fd/2
git_projects='
vendor/sprd/modules/bt
vendor/sprd/proprietories-source/connconfig
vendor/sprd/proprietories-source/bt
platform/system/bt
platform/external/bluetooth/bluedroid
'
fi
fi

debug git_projects: ${git_projects}


for git_project in ${git_projects}
do
# '#' check is performed when read file
#if [[ "${git_project}" =~ ^#.* ]]
#then
#:
#else
debug ${git_project}
title+="\t${git_project}"
#fi
done
