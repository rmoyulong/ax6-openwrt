#公用函数
source $GITHUB_WORKSPACE/Scripts/functions.sh

cd openwrt
rm -rf feeds/packages/lang/python

merge_package master https://github.com/rmoyulong/old_coolsnowwolf_packages feeds/packages/lang lang/python

#================修改homeproxy初始设置===========================
git clone https://github.com/rmoyulong/Lite_OpenWrt Lite_OpenWrt 

#如果files文件夹不存在，创建文件夹
if [ ! -d "./files" ]; then
  mkdir ./files
fi

cp -rf Lite_OpenWrt/homeproxy/files/* ./files
rm -rf Lite_OpenWrt
