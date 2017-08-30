#! /bin/bash

#the problem is \ is handled by zsh
# usage :   1.sh "string"

echo -E "$1"

echo -E "$1" | sed 's_\\_\/_g' | xargs
#path=`echo -E "$1" | sed "s/\\/\//g"`
#path=`echo -E "$1" | sed 's_\\_\/_g'`

#cd "${path}"

