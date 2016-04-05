# Potty-Boom-Boom
A raspian based Toilet-media-center used at EH16 to entertain and speed up toilet usage

HOWTO:
 - Deploy Raspian-Lite[1] on a SD Card of your joice (If the Potty-Boom-Boom is used without network and remote-storage choose a big SD-Card 8GB+) 
 - Change the password for the `pi` user with `passwd`.
 - Run `raspi-config` and do the following steps
	 - 	Select `9 Advanced Options` then chose `A3 Memory Split` and make sure that you grant at least 64MB to the GPU.
	 -  Select `9 Advanced Options` then chose `A9 Audio` and verify that your audio output is set correctly whether you want to use HDMI audio or the 3.5mm jack.
	 -  Select `1 Expand Filesystem`, let it do its magic and reboot the system. This is important, otherwise installation will fail due to lack of freespace on the SD card.
 - After the restart connect via SSH do the installation.
 - Install git, checkout the Boom-Boom-izer.sh and execute it.
```
sudo apt update && sudo apt -y install git
git clone https://github.com/AMD1212/potty-boom-boom.git /tmp/potty-boom-boom
sudo sh /tmp/potty-boom-boom/Boom-Boom-izer.sh
```
 - Place your mp4 encoded videos in the /home/pi/Potty-Boom-Boom/Files/
 - Finally reboot the Raspberry Pi to have it autostart.
 - Boom Boom!

[1] https://www.raspberrypi.org/downloads/raspbian/
