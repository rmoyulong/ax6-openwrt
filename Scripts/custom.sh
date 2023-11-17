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


# 修改初始化配置
touch package/base-files/files/etc/custom.tag
sed -i '/exit 0/d' package/base-files/files/etc/rc.local
cat >> package/base-files/files/etc/rc.local << EOFEOF
PPPOE_USERNAME=""
PPPOE_PASSWORD=""
DDNS_USERNAME=""
DDNS_PASSWORD=""
SSR_SUBSCRIBE_URL=""
SSR_SAVE_WORDS=""
SSR_GLOBAL_SERVER=""

init_custom_config() {
    uci set dhcp.cfg01411c.cachesize='0'
    uci commit dhcp
    /etc/init.d/dnsmasq restart >> /etc/custom.tag 2>&1
    echo "dnsmasq finish" >> /etc/custom.tag

    uci set smartdns.cfg016bb1.enabled='1'
    uci set smartdns.cfg016bb1.server_name='smartdns'
    uci set smartdns.cfg016bb1.port='6053'
    uci set smartdns.cfg016bb1.tcp_server='0'
    uci set smartdns.cfg016bb1.ipv6_server='0'
    uci set smartdns.cfg016bb1.dualstack_ip_selection='1'
    uci set smartdns.cfg016bb1.prefetch_domain='1'
    uci set smartdns.cfg016bb1.serve_expired='1'
    uci set smartdns.cfg016bb1.cache_size='16384'
    uci set smartdns.cfg016bb1.resolve_local_hostnames='1'
    uci set smartdns.cfg016bb1.auto_set_dnsmasq='1'
    uci set smartdns.cfg016bb1.force_aaaa_soa='0'
    uci set smartdns.cfg016bb1.force_https_soa='0'
    uci set smartdns.cfg016bb1.rr_ttl='30'
    uci set smartdns.cfg016bb1.rr_ttl_min='30'
    uci set smartdns.cfg016bb1.rr_ttl_max='300'
    uci set smartdns.cfg016bb1.seconddns_enabled='1'
    uci set smartdns.cfg016bb1.seconddns_port='5335'
    uci set smartdns.cfg016bb1.seconddns_tcp_server='0'
    uci set smartdns.cfg016bb1.seconddns_server_group='oversea'
    uci set smartdns.cfg016bb1.seconddns_no_speed_check='1'
    uci set smartdns.cfg016bb1.seconddns_no_rule_addr='0'
    uci set smartdns.cfg016bb1.seconddns_no_rule_nameserver='1'
    uci set smartdns.cfg016bb1.seconddns_no_rule_ipset='0'
    uci set smartdns.cfg016bb1.seconddns_no_rule_soa='0'
    uci set smartdns.cfg016bb1.seconddns_no_dualstack_selection='1'
    uci set smartdns.cfg016bb1.seconddns_no_cache='1'
    uci set smartdns.cfg016bb1.seconddns_force_aaaa_soa='1'
    uci set smartdns.cfg016bb1.coredump='0'
    uci commit smartdns
    touch /etc/smartdns/ad.conf
    cat >> /etc/smartdns/custom.conf << EOF


# Include another configuration options
conf-file /etc/smartdns/ad.conf

# remote dns server list
server 114.114.114.114 -group china #114DNS
server 114.114.115.115 -group china #114DNS
server 119.29.29.29 -group china #TencentDNS
server 182.254.116.116 -group china #TencentDNS
server 2402:4e00:: -group china #TencentDNS
server-tls 223.5.5.5 -group china -group bootstrap #AlibabaDNS
server-tls 223.6.6.6 -group china -group bootstrap #AlibabaDNS
server-tls 2400:3200::1 -group china -group bootstrap #AlibabaDNS
server-tls 2400:3200:baba::1 -group china -group bootstrap #AlibabaDNS
server 180.76.76.76 -group china #BaiduDNS
nameserver /cloudflare-dns.com/bootstrap
nameserver /dns.google/bootstrap
nameserver /doh.opendns.com/bootstrap
server-tls 1.1.1.1 -group oversea -exclude-default-group #CloudflareDNS
server-tls 1.0.0.1 -group oversea -exclude-default-group #CloudflareDNS
server-https https://cloudflare-dns.com/dns-query -group oversea -exclude-default-group #CloudflareDNS
server-tls 8.8.8.8 -group oversea -exclude-default-group #GoogleDNS
server-tls 8.8.4.4 -group oversea -exclude-default-group #GoogleDNS
server-https https://dns.google/dns-query -group oversea -exclude-default-group #GoogleDNS
server-tls 208.67.222.222 -group oversea -exclude-default-group #OpenDNS
server-tls 208.67.220.220 -group oversea -exclude-default-group #OpenDNS
server-https https://doh.opendns.com/dns-query -group oversea -exclude-default-group #OpenDNS
EOF
    /etc/init.d/smartdns restart >> /etc/custom.tag 2>&1
    echo "smartdns remote dns server list finish" >> /etc/custom.tag

    #uci set network.wan.proto='pppoe'
    #uci set network.wan.username="\${PPPOE_USERNAME}"
    #uci set network.wan.password="\${PPPOE_PASSWORD}"
    #uci set network.wan.ipv6='auto'
    #uci set network.wan.peerdns='0'
    #uci add_list network.wan.dns='127.0.0.1'
    #uci set network.modem=interface
    #uci set network.modem.proto='dhcp'
    #uci set network.modem.device='eth0'
    #uci set network.modem.defaultroute='0'
    #uci set network.modem.peerdns='0'
    #uci set network.modem.delegate='0'
    #uci commit network
    #/etc/init.d/network restart >> /etc/custom.tag 2>&1
    #echo "network finish" >> /etc/custom.tag

    #uci add_list firewall.cfg03dc81.network='modem'
    #uci commit firewall
    # hijack dns queries to router(firewall4)
    # 把局域网内所有客户端对外ipv4和ipv6的53端口查询请求，都劫持指向路由器(nft list chain inet fw4 dns-redirect)(nft delete chain inet fw4 dns-redirect)
    cat >> /etc/nftables.d/10-custom-filter-chains.nft << EOF
chain dns-redirect {
    type nat hook prerouting priority -105;
    udp dport 53 counter redirect to :53
    tcp dport 53 counter redirect to :53
}

EOF
    /etc/init.d/firewall restart >> /etc/custom.tag 2>&1
    echo "firewall finish" >> /etc/custom.tag

    sleep 30

    echo "cloudflare-dns.com" >> /etc/ssrplus/black.list
    echo "dns.google" >> /etc/ssrplus/black.list
    echo "doh.opendns.com" >> /etc/ssrplus/black.list
    uci add_list shadowsocksr.cfg034417.wan_fw_ips='1.1.1.1'
    uci add_list shadowsocksr.cfg034417.wan_fw_ips='1.0.0.1'
    uci add_list shadowsocksr.cfg034417.wan_fw_ips='8.8.8.8'
    uci add_list shadowsocksr.cfg034417.wan_fw_ips='8.8.4.4'
    uci add_list shadowsocksr.cfg034417.wan_fw_ips='202.106.195.68'
    uci add_list shadowsocksr.cfg034417.wan_fw_ips='202.106.46.151'
    uci set shadowsocksr.cfg029e1d.auto_update='1'
    uci set shadowsocksr.cfg029e1d.auto_update_time='4'
    #uci add_list shadowsocksr.cfg029e1d.subscribe_url="\${SSR_SUBSCRIBE_URL}"
    #uci set shadowsocksr.cfg029e1d.save_words="\${SSR_SAVE_WORDS}"
    #uci set shadowsocksr.cfg029e1d.switch='1'
    uci commit shadowsocksr
    /usr/bin/lua /usr/share/shadowsocksr/subscribe.lua >> /etc/custom.tag
    #uci set shadowsocksr.cfg013fd6.global_server="\${SSR_GLOBAL_SERVER}"
    uci set shadowsocksr.cfg013fd6.pdnsd_enable='0'
    uci commit shadowsocksr
    /etc/init.d/shadowsocksr restart >> /etc/custom.tag 2>&1
    echo "shadowsocksr finish" >> /etc/custom.tag

}

if [ -f "/etc/custom.tag" ]; then
    echo "smartdns block ad domain list start" > /etc/custom.tag
    #refresh_ad_conf &
else
    echo "init custom config start" > /etc/custom.tag
    init_custom_config &
fi

echo "rc.local finish" >> /etc/custom.tag

exit 0
EOFEOF