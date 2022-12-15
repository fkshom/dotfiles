#!/bin/bash

/sbin/ifconfig tun0 | grep tun0 > /dev/null
if [ $? -eq 0 ]
then
  tun0_ip=$(/sbin/ifconfig tun0 | grep -A1 tun0 | grep inet | cut -d" " -f10)
  echo "<txt>tun0: ${tun0_ip}</txt>"
  echo "<tool>VPN Address is ${tun0_ip}</tool>"
else
  echo "<txt></txt>"
fi
