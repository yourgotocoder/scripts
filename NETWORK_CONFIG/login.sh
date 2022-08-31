#!/bin/bash

wget -q --tries=10 --timeout=10  http://172.23.19.146:8090
if [[ $? -eq 0 ]]; then
     w3m -post - http://172.23.19.146:8090/login.xml<<<'mode=191&username=sllab&password=Smit%4012345&a=1661920421730&producttype=0'
        echo "Online!"
else
        echo "Unreachable!"
fi