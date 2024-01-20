#!/bin/bash

echo "Installing pyserial..."
pip3 install pyserial

echo "Installing resources needed to automatically select APN..."
cp apn_database.json /etc/ppp/
cp query_apn /etc/ppp/
chmod +x /etc/ppp/query_apn
# Overwrite chat-script
cp chat-script /etc/ppp/

echo "Installing ppp systemd service..."
# Create udev rule for the serial device
cp 99-simcom.rules /lib/udev/rules.d/
cp ppp.service /lib/systemd/system/
# Disable old init script if still around
rm /etc/rc2.d/S02ppp
rm /etc/init.d/ppp
systemctl enable ppp

echo "Done! A reboot is needed for the new configuration to take effect."