#公用函数
source $GITHUB_WORKSPACE/Scripts/functions.sh

cd openwrt
merge_package master https://github.com/immortalwrt/luci/ package themes/luci-theme-argon
