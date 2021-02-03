#!/usr/bin/env ash

DNSMASQ_LEASEFILE=$(/sbin/uci get dhcp.@dnsmasq[0].leasefile)
#DNSMASQ_LEASEFILE="/tmp/dhcp.leases"
DNSMASQ_LEASETIME="1800"

DEVICES_EXCLUDE_LIST="$(dirname $(readlink -f $0))/config/devices_exclude.txt"
DEVICES_LASTCHANGE="$(dirname $(readlink -f $0))/config/devices.lastchange"
USERS_ASSIGN_LIST="$(dirname $(readlink -f $0))/config/users.txt"

API_URL="https://status.bytespeicher.org/api/v1/status"
API_KEY="THIS_IS_THE_API_KEY"

# CURL_EXTRA_OPTIONS="--insecure"
