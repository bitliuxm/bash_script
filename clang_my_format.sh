#! /bin/bash

#echo "$*" 
#echo "$1" 
filename=`echo "$1" | sed "s/-f //g"`

USE_SPACE=1

echo(){
  :
}


while getopts ":l:f:" optname
  do
    case "$optname" in
      "f")
        #echo "Option $optname has value $OPTARG" 
        ;;
      "l")
        #echo "Option $optname has value $OPTARG" 
        endline=${OPTARG##*:}
        startline=${OPTARG%%:*}
        #echo $startline $endline
        #sed -i "/1,2/ p" $2
		#依赖于 先执行过clang_format, 使用left*, 使得指针*号可以与乘号* 进行区分
		#匹配的是 *号前后的两个标识符, 涵盖的条件如下
		#
		#
		#
		# \1 : space before tag1
		# \2 : tag1
		# \3 : ** / *
		# \4 : space after * before tag2
		# \5 : tag2
		sed -i "$startline,$endline"' s/\(\s*\)\([_a-zA-Z][_a-zA-Z0-9]\{0,30\}\)\(\*\**\)\(\s*\)\([_a-zA-Z][_a-zA-Z0-9]\{0,30\}\)/\1\2\4\3\5/g'  "$filename"
        #sed -i "$startline,$endline s/^\(\s*\)\([_a-zA-Z][_a-zA-Z0-9]\{0,30\}\)\(\s\)\*\(\s*\)\(\S*\)/\1\2\3\4*\5/"  $filename
        #sed -i "$startline,$endline s/\(\s*\)\([_a-zA-Z][_a-zA-Z0-9]\{0,30\}\)\(\s\)\*\(\s*\)\(\S*\)\(,\s*\)/\1\2\3\4*\5\6/"  $filename
        # add this to warning when // is used
		# todo change the // to /* */
		# '<,'>:s/\(.*\)\/\/\(.*\)/\/*\2 *\/\r\1/ 
		
		if [ "$USE_SPACE" -eq 1 ]
		then
			sed -i "$startline,$endline"' s/	/    /g'  "$filename"
		else
			sed -i "$startline,$endline"' s/    /	/g'  "$filename"
		fi

		# remove space in end
		sed -i "$startline,$endline"' s/[ \t]*$//g'  "$filename"

        # 查找使用了 // 的注释的位置, 使用set-x的原因是标准错误被python给拿走了
		error_comment=`cat $filename | sed -n "$startline,$endline  s/\/\/.*/&/p"`
		if [ -n "$error_comment"  ]
		then
			set -x
			echo "error_comment in :"
			echo "err""$error_comment"
			set +x
		fi
        ;;
      "?")
        echo "Unknown option $OPTARG"
        ;;
      ":")
        echo "No argument value for option $OPTARG"
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        ;;
    esac
  done

#echo $filename 

