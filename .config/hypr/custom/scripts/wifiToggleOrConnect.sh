#!/bin/bash
wifiSSID=TP-Link_9F66

set -e

nmcliDevResult=$(nmcli device)

toggleWifi () {
	if echo $nmcliDevResult | rg "wlan0[\s]+[\w]+[\s]+connected"; then 
		notify-send "WiFi Powered off" "Powered off WiFi successfully" -i "network-wireless-offline" -a "WiFi"
		nmcli radio wifi off
	elif echo $nmcliDevResult | rg "wlan0[\s]+[\w]+[\s]+disconnected"; then 
		notify-send "Connecting to $wifiSSID" -i "network-wireless-acquiring" -a "WiFi"
		nmcli connection up $wifiSSID &
		notify-send "Connected to $wifiSSID" -i "network-wireless-connected" -a "WiFi"
	else 
		notify-send "Connecting to TP-Link_9F66" "Powered on WiFi successfully" -i "network-wireless-acquiring" -a "WiFi"
		nmcli radio wifi on & sleep 1 & nmcli connection up $wifiSSID & notify-send "Connected to $wifiSSID" -i "network-wireless-connected" -a "WiFi"
	fi
}

toggleWifi

exit 0
