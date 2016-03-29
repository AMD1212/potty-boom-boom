# Potty-Boom-Boom
An raspian based Toilet-media-center used at EH16 to entertain and speed up toilet usage

HOWTO:
 - Deploy Raspian-Lite[1] on a SD Card of your joice (If the Potty-Boom-Boom is used without network and remote-storage choose a big SD-Card 8GB+) 
 - Start your new Potty-Boom-Boom device and connect to it.
 - Install git, checkout the Boom-Boom-izer.sh and execute it.
```
apt update && apt -y install git
git clone https://github.com/AMD1212/potty-boom-boom.git /tmp/potty-boom-boom
sh /tmp/potty-boom-boom/Boom-Boom-izer.sh
```
 - Place your mp4 encoded videos in the /home/pi/Potty-Boom-Boom/Files/
 - Run raspi-config and choose the menupoint to extend the root-filesystem and reboot the system
 - Boom Boom!






[1] https://www.raspberrypi.org/downloads/raspbian/
