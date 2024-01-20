stty -F /dev/ttyUSB2 -echo
cat /dev/ttyUSB2 &
echo AT
echo "AT+CGPSAUTO=1" > /dev/ttyUSB2
sleep 2
echo "Done!"
