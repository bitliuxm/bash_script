#! /bin/bash

debug()
{
echo $1
}


usage(){
cat > /dev/fd/2 << EOF 
SYNOPSIS
    check_branches -c [project_list_file] -p [manifest_branch_pattern] > output_file 
    result will out put to stdout. using pipe to save as file.

OPTIONS
     -c project_list_file
    project_list_file should be formated like below, using '#' to indicate ignore.
  1 #vendor/sprd/modules/bt
  2 #vendor/sprd/proprietories-source/connconfig
  3 vendor/sprd/proprietories-source/bt
  4 platform/system/bt
  5 platform/external/bluetooth/bluedroid

     -h print usage

     -p manifest_branch_pattern
    sample: "6.0"
            "k318", etc
    manifest_branch_pattern should be BRE
EOF
}


while getopts ":c:p:h" optname
  do
    case "$optname" in
      "h")
        debug "Option $optname has value $OPTARG"
        #manifest_branch filter pattern as $2
        usage
        exit
        ;;
      "p")
        debug "Option $optname has value $OPTARG"
        #manifest_branch filter pattern as $2
        manifest_branch_filter_pattern="$OPTARG"
        ;;
      "c")
        debug "Option $optname has value $OPTARG"
        if [ -e "$OPTARG" ]
        then
        git_projects=`cat "$OPTARG" | grep -e "^[^#]"`
        else
        echo file not found: "$OPTARG" > /dev/fd/2
        fi
        ;;
      "?")
        debug "Unknown option $OPTARG"
        ;;
      ":")
        debug "No argument value for option $OPTARG"
        ;;
      *)
      # Should not occur
        debug "Unknown error while processing options"
        ;;
    esac
    debug "OPTIND is now $OPTIND"
  done




