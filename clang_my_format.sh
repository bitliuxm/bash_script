#! /bin/bash

#echo "$*" 
#echo "$1" 
filename=`echo "$1" | sed "s/-f //g"`

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
        sed -i "$startline,$endline s/^\(\s*\)\([_a-zA-Z][_a-zA-Z0-9]\{0,30\}\)\(\s\)\*\(\s*\)\(\S*\)/\1\2\3\4*\5/"  $filename
        sed -i "$startline,$endline s/\(\s*\)\([_a-zA-Z][_a-zA-Z0-9]\{0,30\}\)\(\s\)\*\(\s*\)\(\S*\)\(,\s*\)/\1\2\3\4*\5\6/"  $filename
        # add this to warning when // is used
		# todo change the // to /* */
		# '<,'>:s/\(.*\)\/\/\(.*\)/\/*\2 *\/\r\1/ 
		error_comment=`cat $filename | sed -n "$startline,$endline  s/\/\/.*/&/p"`
        if [ -n "$error_comment"  ]
		then
			set -x
			echo $error_comment 
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

