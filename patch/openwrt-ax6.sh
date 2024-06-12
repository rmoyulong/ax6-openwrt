#!/bin/bash
cd openwrt
sudo dos2unix $GITHUB_WORKSPACE/patch/ax6/*.sh
sudo dos2unix $GITHUB_WORKSPACE/patch/ax6/*
sudo dos2unix $GITHUB_WORKSPACE/patch/ax6/*.mk
sudo dos2unix $GITHUB_WORKSPACE/patch/ax6/*.dts
sudo chmod +x $GITHUB_WORKSPACE/patch/ax6/*.sh
sudo chmod -Rf 755 $GITHUB_WORKSPACE/patch/ax6/*

mv  $GITHUB_WORKSPACE/patch/ax6/01_leds target/linux/qualcommax/ipq807x/base-files/etc/board.d
mv  $GITHUB_WORKSPACE/patch/ax6/02_network target/linux/qualcommax/ipq807x/base-files/etc/board.d
mv  $GITHUB_WORKSPACE/patch/ax6/11-ath10k-caldata target/linux/qualcommax/ipq807x/base-files/etc/hotplug.d/firmware
mv  $GITHUB_WORKSPACE/patch/ax6/11-ath11k-caldata target/linux/qualcommax/ipq807x/base-files/etc/hotplug.d/firmware
mv  $GITHUB_WORKSPACE/patch/ax6/bootcount target/linux/qualcommax/ipq807x/base-files/etc/init.d
mv  $GITHUB_WORKSPACE/patch/ax6/platform.sh target/linux/qualcommax/ipq807x/base-files/lib/upgrade
mv  $GITHUB_WORKSPACE/patch/ax6/ipq807x.mk target/linux/qualcommax/image
mv  $GITHUB_WORKSPACE/patch/ax6/qualcommax_ipq807x package/boot/uboot-envtools/files
mv  $GITHUB_WORKSPACE/patch/ax6/ipq8071-ax6-stock.dts target/linux/qualcommax/files/arch/arm64/boot/dts/qcom
mv  $GITHUB_WORKSPACE/patch/ax6/ipq8071-ax3600-stock.dts target/linux/qualcommax/files/arch/arm64/boot/dts/qcom