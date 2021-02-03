#!/usr/bin/env ash

# Get devices exclude filter from filter list
__get_devices_exclude_filter() {
  # Return device regex filter with leading and trailing space to match exact host names
  echo $(cat $DEVICES_EXCLUDE_LIST | sed 's/^\(.*\)$/ \1 /g' | tr '\n' '|' | sed 's/^\(.*\)|$/(\1)/')
}

# Get number of active devices (without excludefilter)
devices_count_all() {
  # Count all active leases
  echo $(cat $DNSMASQ_LEASEFILE | wc -l)
}

# Get number of active devices (with exclude filter)
devices_count() {
  # Grep all active leases by host names from regex (-E) that do not (-v) match with case ignored (-i)
  # Count found host names (-c) with grep directly
  echo $(cat $DNSMASQ_LEASEFILE | grep -c -v -i -E "$(__get_devices_exclude_filter)")
}

# Get timestamp of longest valid dhcp lease
devices_get_last_change() {
  # Grep all host names from regex filter (-E) that do not (-v) match with case ignored (-i) from list sorted by lease end time
  # Afterwards get last line and select lease end time (1st position)
  TIMESTAMP_DHCP_LEASE=$(sort -k+1 $DNSMASQ_LEASEFILE | grep -v -i -E "$(__get_devices_exclude_filter)" | tail -n1 | cut -d' ' -f1)

  if [ "$TIMESTAMP_DHCP_LEASE" != "" ]; then
    # Timestamp could be determined, subtract dhcp lease time
    TIMESTAMP_DHCP_LEASE=$(($TIMESTAMP_DHCP_LEASE - $DNSMASQ_LEASETIME))
    echo $TIMESTAMP_DHCP_LEASE > $DEVICES_LASTCHANGE
  else
    # Timestamp could NOT be determined, get saved one or current timestamp
    TIMESTAMP_DHCP_LEASE=$(cat $DEVICES_LASTCHANGE 2>/dev/null || date "+%s")
  fi

  echo $TIMESTAMP_DHCP_LEASE
}
