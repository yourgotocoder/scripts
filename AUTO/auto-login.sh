#!/bin/bash
check_ip_address=8.8.8.8
packet_count=5
net_check=$(ping -c $packet_count $check_ip_address)
if [[ $? -eq 0 ]]; then
        echo "Internet access available"
else
        wget -q --tries=10 --timeout=10 http://172.23.19.146:8090
        if [[ $? -eq 0 ]]; then
                w3m -post - http://172.23.19.146:8090/login.xml <<<"mode=191&username=pplab&password=12345&a=$1"

                echo "Online!"
        else
                echo "Unreachable!"
        fi
fi
