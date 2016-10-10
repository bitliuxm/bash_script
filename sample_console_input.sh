#! /bin/bash



while true
do

    echo -n "input the pac path :"
    read -r var

if [ "${var}" = "y" ]
then
    echo y
elif [ "${var}" = "n" ]
then
    echo n
elif [ "${var}" = "q" ]
then
    echo q
    exit
fi
done



