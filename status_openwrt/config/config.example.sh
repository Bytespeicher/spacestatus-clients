#!/usr/bin/env ash

# Configuration files
DEVICES_EXCLUDE_LIST="$(dirname $(readlink -f $0))/config/devices_exclude.txt"
USERS_ASSIGN_LIST="$(dirname $(readlink -f $0))/config/users.txt"

# State detection (dhcp or mqtt)
STATE_DETECTION="dhcp"

# dnsmasq configuration to get state by dhcp leases
DNSMASQ_LEASEFILE=$(/sbin/uci get dhcp.@dnsmasq[0].leasefile)
#DNSMASQ_LEASEFILE="/tmp/dhcp.leases"
DNSMASQ_LEASETIME="1800"

# MQTT configuration to get state by mqtt
MQTT_HOST="192.168.1.1"
MQTT_USER="user"
MQTT_PASSWORD="password"
MQTT_TOPIC="sensors/door/state"
# State values can be single (e.g. "open") or multiple (e.g. "(closing|closed)") as regular expression
MQTT_STATE_OPEN="11"
MQTT_STATE_CLOSED="(01|10)"

# API configuration
API_URL="https://status.example.org/api/v1/status"
API_KEY="THIS_IS_THE_API_KEY"
# CURL_EXTRA_OPTIONS="--insecure"

# Last change timestamp file
DEVICES_LASTCHANGE="$(dirname $(readlink -f $0))/config/devices.lastchange"
