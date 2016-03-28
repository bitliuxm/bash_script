#! /bin/bash
# used to copy file into path

source_path='/home7/bitliu/tmp/sp9830a_5h10/obj'
dest_path='/home7/bitliu/6tt/out/target/product/sp9830a_5h10/obj'


echo $1
if [ ${dest_path}/ ]



cp "/home7/bitliu/tmp/scx35l64_sp9838aea_5mod/obj/${cppath}" "./obj/${cppath}" -rf
#cp "/home7/bitliu/tmp/scx35l64_sp9838aea_5mod/obj_arm/${cppath}" "./obj_arm/${cppath}" -rf

# ~ can not be used
#cp "~/tmp/scx35l64_sp9838aea_5mod/obj_arm/$1" "./obj_arm/$1" -rf




fix(){
cppaths='
SHARED_LIBRARIES/libc_intermediates
SHARED_LIBRARIES/libcutils_intermediates/
SHARED_LIBRARIES/liblog_intermediates/
SHARED_LIBRARIES/libm_intermediates/
SHARED_LIBRARIES/libstdc++_intermediates/
STATIC_LIBRARIES/libcompiler_rt-extras_intermediates/
lib/libc.so
lib/libcutils.so
lib/liblog.so
lib/libm.so
lib/libstdc++.so
lib/crtbegin_so.o
lib/crtend_so.o
'

cppaths2='
SHARED_LIBRARIES/libdl_intermediates
SHARED_LIBRARIES/libpower_intermediates
STATIC_LIBRARIES/libtinyxml2_intermediates
lib/libdl.so
lib/libpower.so
lib/crtbegin_dynamic.o
SHARED_LIBRARIES/libstlport_intermediates
STATIC_LIBRARIES/libbt-utils_intermediates
STATIC_LIBRARIES/libgtest_intermediates
STATIC_LIBRARIES/libgtest_main_intermediates
STATIC_LIBRARIES/libstdc++_intermediates
lib/libstlport.so
lib/crtend_android.o
SHARED_LIBRARIES/libhardware_intermediates
SHARED_LIBRARIES/libhardware_legacy_intermediates
SHARED_LIBRARIES/libutils_intermediates
lib/libhardware.so
lib/libhardware_legacy.so
lib/libutils.so
STATIC_LIBRARIES/libbt-utils_intermediates
'


for cppath in ${cppaths2}
do
#echo ${cppath}
cp "/home7/bitliu/tmp/scx35l64_sp9838aea_5mod/obj/${cppath}" "./obj/${cppath}" -rf
#cp "/home7/bitliu/tmp/scx35l64_sp9838aea_5mod/obj_arm/${cppath}" "./obj_arm/${cppath}" -rf
done
}
