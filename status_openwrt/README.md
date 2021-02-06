# OpenWRT Status Update
Scripts to update space status by dnsmasq leases on an OpenWRT based router using spacestatus-server API

### Dependencies
* dnsmasq (default on OpenWRT)
* curl
* ca-certificates (otherwise adjust CURL_EXTRA_OPTIONS)

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
3. Create script directory
    ```shell
    mkdir /usr/share/spacestatus
    ```  
4. Copy all files to the directory created above
5. Copy example configuration
    ```shell
    cd /usr/share/spacestatus/config
    cp config.example.sh config.sh
    cp devices_exclude.example.txt devices_exclude.txt
    cp users.example.txt users.txt
    ```  
6. Adjust configuration in config/config.sh
    ```shell
    DNSMASQ_LEASEFILE - Should point to your lease file
    DNSMASQ_LEASETIME - Should be your leasetime configured in /etc/config/dhcp
    (Script can not handle different lease times on different interfaces)
    
    API_URL - Change hostname to your spacestatus-server installation
    API_KEY - Change to your API authentication key of your spacestatus-server installation
    
    CURL_EXTRA_OPTIONS - Set extra command line options for curl
    (Example: CURL_EXTRA_OPTIONS="--insecure" if package ca-certificates is not installed)
    ```
7. Adjust hostnames to ignore in lease file in config/devices_exclude.txt
8. Adjust mac to username bindings in config/users.txt to show attendant user on spacestatus-server page
9. Create cronjob entry in /etc/crontabs/root
    ```shell
    * * * * *     /usr/share/spacestatus/update_status_api.sh
    ```
10. Restart cron daemon
    ```shell
    /etc/init.d/cron restart
    ```
