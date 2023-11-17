#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2-ax6-openwrt.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# https://github.com/deplives/OpenWrt-CI-RC/blob/main/second.sh
# https://github.com/jarod360/Redmi_AX6/blob/main/diy-part2.sh

# 删除 packages
#rm -rf $(find ./feeds/applications/ -type d -regex ".*\(passwall\|mosdns\).*")
#rm -rf $(find ./feeds/net/ -type d -regex ".*\(v2ray-geodata\|v2dat\).*")

# 增加 packages
#svn co https://github.com/rmoyulong/My-Pkg