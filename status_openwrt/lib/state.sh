#!/usr/bin/env ash

# Get open state
open_state() {

  DEVICES=$(devices_count)
  case $DEVICES in
    "0") OPEN="false"
       ;;
    "1") OPEN="true"
       ;;
    *) OPEN="true"
       ;;
  esac

  echo $OPEN
}

# Get connection string
connected_devices_message() {

  DEVICES=$(devices_count)
  case $DEVICES in
    "0") CONNECTED="No devices connected"
       ;;
    "1") CONNECTED="1 device connected"
       ;;
    *) CONNECTED="$DEVICES devices connected"
       ;;
  esac

  echo $CONNECTED
}
