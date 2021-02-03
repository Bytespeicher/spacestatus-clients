#!/usr/bin/env ash

# Get mac address filter from dhcp lease file
__get_mac_include_filter() {
  # Return mac address regex filter with must start with condition
  echo $(cat $DNSMASQ_LEASEFILE | cut -d' ' -f2 | sed 's/^\(.*\)$/^\1 /g' | tr '\n' '|' | sed 's/^\(.*\)|$/(\1)/')
}

# Get number of connected users
users_get_count() {
  # Grep all mac addresses from lease file by regex filter (-E) with case ignored (-i)
  # Afterwards get usernames from result, sort and uniq them and output as quoted comma seperated list
  echo $(\
    cat $USERS_ASSIGN_LIST | \
      grep -i -E "$(__get_mac_include_filter)" | \
      cut -d' ' -f2 | \
      sort | \
      uniq | \
      wc -l
  )
}

# Get list of connected users
users_get_names() {
  # Grep all mac addresses from lease file by regex filter (-E) with case ignored (-i)
  # Afterwards get usernames from result, sort and uniq them and output as quoted comma seperated list
  echo $(\
    cat $USERS_ASSIGN_LIST | \
      grep -i -E "$(__get_mac_include_filter)" | \
      cut -d' ' -f2 | \
      sort | \
      uniq | \
      tr '\n' ' ' | \
      sed 's/\(.*\) $/"\1"/' | \
      sed 's/ /", "/g'
  )
}
