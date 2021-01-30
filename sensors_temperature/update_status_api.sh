#!/usr/bin/env bash

# Include configuration and lib
. $(dirname $(readlink -f $0))/config.sh || exit 1
. $(dirname $(readlink -f $0))/lib.sh || exit 1

# Generate json output for api
generate_json_output_api() {

  # JSON Prefix
  echo "{"
  echo "  \"sensors\": {"
  echo "    \"temperature\": ["

  # Temperatures
  for (( i=0; i<${#SENSORNAMES[@]}; i++ )); do

    TEMP=$(get_temperature ${i})
    echo -n "      { \"value\": ${TEMP}, \"unit\": \"°C\", \"location\": \"${SENSORNAMES[$i]}\" }"
    if [ ${i} -lt $((${#SENSORNAMES[@]}-1)) ]; then
      echo ","
    else
      echo ""
    fi
  done

  # JSON Suffix
  echo "    ]"
  echo "  }"
  echo "}"

}

check_configuration
generate_json_output_api |\
  curl \
    --silent \
    --connect-timeout 5 \
    --max-time 10 \
    --retry 3 \
    --retry-delay 5 \
    --request PUT \
    --header "Content-Type: application/json" \
    --header "Accept: application/json" \
    --header "X-Hackspace-API-Key: ${API_KEY}" \
    --data-ascii @- \
    ${API_URL} > /dev/null
