#!/usr/bin/env bash

SENSORNAMES=(
  "Sensor 1"
  "Sensor 2"
)

DEVICES=(
  "/sys/devices/w1_bus_master1/12-345678901234/w1_slave"
  "/sys/devices/w1_bus_master1/12-345678901235/w1_slave"
)

API_URL="https://status.bytespeicher.org/api/v1/sensors/temperature"
API_KEY="THIS_IS_THE_API_KEY"
