#!/bin/sh

mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun
openvpn --config /etc/openvpn/client.ovpn --daemon

# run-services.sh - It is a Teamcity Agent startup script
sh /run-services.sh
