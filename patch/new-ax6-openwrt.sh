#!/bin/bash
cd openwrt

mv $GITHUB_WORKSPACE/patch/0001-ipq807x-add-stock-layout-variant-for-redmi-ax6.patch 0001-ipq807x-add-stock-layout-variant-for-redmi-ax6.patch
git apply 0001-ipq807x-add-stock-layout-variant-for-redmi-ax6.patch