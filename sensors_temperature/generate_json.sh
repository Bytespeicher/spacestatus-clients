#!/usr/bin/env bash

# Include configuration and lib
. $(dirname $(readlink -f $0))/config.sh || exit 1
. $(dirname $(readlink -f $0))/lib.sh || exit 1

# Generate json output
generate_json_output() {

  # JSON Prefix
  echo "{"

  # Temperatures
  for (( i=0; i<${#SENSORNAMES[@]}; i++ )); do

    TEMP=$(get_temperature ${i})
    echo -n "  \"${SENSORNAMES[$i]}\": ${TEMP}"
    if [ ${i} -lt $((${#SENSORNAMES[@]}-1)) ]; then
      echo ","
    else
      echo ""
    fi
  done

  # JSON Suffix
  echo "}"

}

check_configuration
generate_json_output
