#!/usr/bin/env bash

# Check configuration
check_configuration() {

  # Test identical length of SENSORNAMES AND DEVICES
  if [ ${#SENSORNAMES[@]} -ne ${#DEVICES[@]} >&2 ]; then
    echo "Different number of SENSORNAMES and DEVICES in configuration" >&2
    exit 255
  fi

}

# Calculate temperature
get_temperature() {
  echo $(cat ${DEVICES[${1}]} | sed -e 's/.*t=\([-]\?[0-9]\+\)/\1/;t;d' | awk '{printf "%0.2f", $1 / 1000}')
}
