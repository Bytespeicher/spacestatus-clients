#!/usr/bin/env ash

# Get open state
open_state() {

  case $STATE_DETECTION in
    "dhcp")
      OPEN=$(open_state_devices)
      ;;
    "mqtt")
      OPEN=$(open_state_mqtt)
      ;;
    *)
      OPEN="Invalid state detection mode"
      ;;
  esac

  echo $OPEN
}

# Get open state by active device count
open_state_devices() {

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

# Get open state by mqtt sensor
open_state_mqtt() {

  MQTT_ANSWER=$(mosquitto_sub -h $MQTT_HOST -C 1 -u $MQTT_USER -P $MQTT_PASSWORD -t "$MQTT_TOPIC" 2>/dev/null)

  if echo $MQTT_ANSWER | grep --quiet -E "$MQTT_STATE_OPEN"; then
    # Open state
    OPEN="true"
  elif echo $MQTT_ANSWER | grep --quiet -E "$MQTT_STATE_CLOSED"; then
    # Closed state
    OPEN="false"
  else
    # Unkown state
    OPEN="false"
  fi

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
