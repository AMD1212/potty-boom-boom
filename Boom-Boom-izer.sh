/bin/sh
##################################
# Vars
copies=0

echo "Boom Boom Boom Potty Boom!"
echo "##########################"
echo "01 - Installing Packages we need"

# Package installations
apt update && apt -y install omxplayer i3 lightdm youtube-dl
if [ $? -ne 0 ] ; then
	echo " - BOOM - There was a Boom Boom problem with Boom Boom package installation."
	echo " - BOOM - Do you have an Network/Internet connection?"
	echo " - BOOM - Please start the Boom-Boom-izer.sh again when your Boom Boom InternetZ is working"
	exit 42
fi

# Adopting the configs
echo "02 - Changing some configs"
cp /tmp/potty-boom-boom/potty-lightdm.conf /etc/lightdm/lightdm.conf && ((copies=${copies}+1)) && echo " - Installed lightdm.conf for pi-autologin"
mkdir /home/pi/.i3
cp /tmp/potty-boom-boom/potty-i3.conf /home/pi/.i3/config && ((copies=${copies}+1)) && echo " - Installed i3 config, starts the watchdog"
mkdir -p /home/pi/Potty-Boom-Boom/Files
chown -R pi:pi /home/pi/Potty-Boom-Boom
cp /tmp/potty-boom-boom/Potty-Boom-Boom-watchdog.sh /home/Potty-Boom-Boom/Potty-Boom-Boom-watchdog.sh && ((copies=${copies}+1)) && echo " - Installed the watchdog, looks for videos and takes a random one for the player"
chmod +x /home/Potty-Boom-Boom/Potty-Boom-Boom-watchdog.sh && echo " - Watchdog is now executeable"

if [ ${copies} -lt 3 ] ; then
	echo " - BOOM - There was a problem with Boom Boom copying Boom files"
	echo " - BOOM - Maybe the guy who Boom Boom wrote the script had to less Boom Boom sleep"
	exit 42
fi

# Prefill with ONE Video
youtube-dl --prefer-free-formats --audio-format best --format mp4 --output /home/pi/Potty-Boom-Boom/Files/01_Pausenmusik https://www.youtube.com/watch?v=C23E5grsczE 

# END
echo "03 - Profit (Potty-Boom-Boom should Boom Boom after compatible files are placed in the correct folder and a reboot)
exit 0
