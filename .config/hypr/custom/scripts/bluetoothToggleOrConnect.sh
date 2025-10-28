#!/bin/bash
MacAddrCMF=2C:BE:EB:E3:AB:D0
MacAddrCMFa=3C:B0:ED:E7:73:32

set -e

toggleBluetooth () {
	if bluetoothctl show | grep -q "Powered: yes"; then
		bluetoothctl << EOF
		power off
EOF
		notify-send --transient "Bluetooth Powered Off" "Powered off Bluetooth successfully" -i "bluetooth-disabled" -t 1000 -a "Bluetooth"
		exit 0
	else
		bluetoothctl << EOF
		power on
EOF
		notify-send --transient "Bluetooth Powered On" "Powered on Bluetooth successfully" -i "bluetooth-active" -t 1000 -a "Bluetooth"
		exit 0
	fi
}


connectToCMF ()
{
	rfkill unblock bluetooth
	sleep 1

	if bluetoothctl show | grep -q "Powered: no"; then
		bluetoothctl << EOF
		power on
EOF
	notify-send --transient "Bluetooth Powered On" "Connecting to CMF Buds..." -i "bluetooth-active" -t 1000 -a "Bluetooth"
	fi

	sleep 1

	bluetoothctl << EOF 
	trust $MacAddrCMF
	connect $MacAddrCMF
	trust $MacAddrCMFa
	connect $MacAddrCMFa
EOF

	sleep 5

	if bluetoothctl info $MacAddrCMF | grep -q "Connected: yes" || bluetoothctl info $MacAddrCMFa | grep -q "Connected: yes"; then
		notify-send --transient "Bluetooth Connected" "Connected to CMD Buds successfully" -i "bluetooth-paired" -t 1000 -a "Bluetooth"
	else
		notify-send --transient "Powered Bluetooth On" "Could not connect to CMD Buds" -i "bluetooth-active" -t 1000 -a "Bluetooth"
	fi
}


for arg in "$@"; do
	case $arg in
		--toggle)
			toggleBluetooth &
			shift
			;;
		--connect)
			connectToCMF &
			shift
			;;
		-h)
			echo -e "--toggle to Toggle\n--connect to connect to CMF Buds"
			shift
			exit 0
			;;
		*)
			echo "Unknown option: $arg"
			exit 1
			;;
	esac
done

echo "No options provided"
exit 0
