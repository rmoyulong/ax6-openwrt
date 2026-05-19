#公用函数
source $GITHUB_WORKSPACE/sh/functions.sh

rm -rf feeds/luci/applications/luci-app-homeproxy
git clone https://github.com/VIKINGYFY/homeproxy package/homeproxy

rm -rf feeds/luci/applications/luci-app-amlogic
git clone https://github.com/ophub/luci-app-amlogic package/luci-app-amlogic


rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/packages/net/sing-box
git clone https://github.com/stupidloud/helloworld package/helloworld
rm -rf package/helloworld/geoview
rm -rf package/helloworld/hysteria
rm -rf package/helloworld/xray-core
rm -rf package/helloworld/v2ray-geodata 

cd package
$GITHUB_WORKSPACE/sh/Packages.sh
$GITHUB_WORKSPACE/sh/Handles.sh
