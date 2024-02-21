# OpenWRT Status Update
Scripts to update space status by dnsmasq leases on an OpenWRT based router using spacestatus-server API

### Dependencies
* dnsmasq (default on OpenWRT)
* curl
* ca-certificates (otherwise adjust CURL_EXTRA_OPTIONS)
* mosquitto-client (if using mqtt for state detection)

## Installation

1. Install curl on OpenWRT
    ```shell
    opkg update
    opkg install curl
    ```

2. Install CA-Certificates or create empty certificates directory

    a. Install ca-certificates on OpenWRT (requires aboud 150kb free space) or
    ```shell
    opkg install ca-certificates
    ```

    b. Create empty certificate directory to prevent curl / polarssl error messages
    ```shell
    mkdir -p /etc/ssl/certs
    ```

3. Install mosquitto-client on OpenWRT (only if you want to use mqtt for state detection)
    ```shell
    opkg update
    opkg install curl
    ```

4. Create script directory
    ```shell
    mkdir /usr/share/spacestatus
    ```

5. Copy all files to the directory created above

6. Copy example configuration
    ```shell
    cd /usr/share/spacestatus/config
    cp config.example.sh config.sh
    cp devices_exclude.example.txt devices_exclude.txt
    cp users.example.txt users.txt
    ```

7. Adjust configuration in config/config.sh
    ```
    STATE_DETECTION - Change from dhcp to mqtt if you want to detect state by mqtt topic
    
    DNSMASQ_LEASEFILE - Should point to your lease file
    DNSMASQ_LEASETIME - Should be your leasetime configured in /etc/config/dhcp
    (Script can not handle different lease times on different interfaces)
    
    MQTT_* - Adjust values if STATE_DETECTION="mqtt"
    
    API_URL - Change hostname to your spacestatus-server installation
    API_KEY - Change to your API authentication key of your spacestatus-server installation
    
    CURL_EXTRA_OPTIONS - Set extra command line options for curl
    (Example: CURL_EXTRA_OPTIONS="--insecure" if package ca-certificates is not installed)
    ```

8. Adjust hostnames to ignore in lease file in config/devices_exclude.txt
   
   *Please note: Every line is evaluated as a regular expression and control characters (e.g. \*) must be escaped with backslash.*
   ```
   fileserver
   switch[12]
   \*
   ```

10. Adjust mac to username bindings in config/users.txt to show attendant user on spacestatus-server page

11. Create cronjob entry in /etc/crontabs/root
    ```
    * * * * *     /usr/share/spacestatus/update_status_api.sh
    ```

12. Restart cron daemon
    ```shell
    /etc/init.d/cron restart
    ```
