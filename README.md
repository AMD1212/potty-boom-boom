# Potty-Boom-Boom
A raspian based lavatory media center used at EH16 to entertain and speed up toilet usage

HOWTO:
 - Start your RaspberryPi with Raspian-Lite[1] on a SD card of your joice 
   (if used with local movie storage, choose a big card 8GB+) 
 - Get ``potty-boom-boom`` on the device:
```
scp -r potty-boom-boom pi@raspberrypi:
```
 - Start the installation process:
```
ssh pi@raspberrypi
potty-boom-boom/Boom-Boom-izer.sh
```
 - Wait for the boom to start...

NB: If you have your lavatory media center connected to a network, don't be
stupid and secure it...

[1] https://www.raspberrypi.org/downloads/raspbian/
