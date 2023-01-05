#!/bin/bash
wget -q --tries=10 --timeout=10  http://172.23.19.146:8090
if [[ $? -eq 0 ]]; then
    w3m -post - http://172.23.19.146:8090/login.xml <<<'mode=191&username=pplab&password=12345&a=1951345153461'
        echo "Online!"
else
        echo "Unreachable!"
fi