#!/bin/bash

STATUS=`ps aux | grep 'openvpn'`
if [[ $STATUS != *"openvpn --config /etc/openvpn/client.ovpn --daemon"* ]];then  
  /usr/sbin/openvpn --config /etc/openvpn/client.ovpn --daemon  
fi
