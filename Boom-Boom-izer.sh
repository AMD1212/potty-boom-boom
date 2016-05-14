#!/bin/bash

## DEFINITIONS

DEFPLAYLIST="https://www.youtube.com/playlist?list=PL_K5oM8g3x84_JuMJhWpJvOKmjaay1inl"

export LC_ALL=C
cd `dirname $(realpath "$0")`

## STAGE 1: change base config

if [[ ! -e PLAYLIST ]]; then

	whiptail --title "Potty Boom Boom is dangerous!" \
	--yesno "This would install Potty Boom Boom - and several reboots will be necessary! Proceed?" 8 78 \
	|| exit
	PLAYLIST=$(whiptail --title "Default Playlist" \
		--inputbox "\
Your servile boomer could install a first playlist. What list should \
that be? (cancel for none)" \
		8 78 "$DEFPLAYLIST" \
	3>&1 1>&2 2>&3 || echo "")
	sudo /usr/bin/raspi-config nonint do_expand_rootfs
	sudo /usr/bin/raspi-config nonint do_memory_split 64
	echo $PLAYLIST > PLAYLIST # trigger second stage upon reboot

	sudo tee /etc/systemd/system/potty-boom-install.service >/dev/null <<EOF
[Unit]
Description=Potty Boom Boom - second stage install
After=getty@tty2.service

[Service]
Type=oneshot
ExecStart=`realpath $0`
StandardInput=tty
TTYPath=/dev/tty2
TTYReset=yes
TTYVHangup=yes

[Install]
WantedBy=default.target
EOF
	sudo systemctl enable potty-boom-install

	sudo reboot
	exit
fi

## STAGE 2: full size install

function err_apt {
	whiptail --title "ERROR" --infobox "Package installation failed - \
is there a network available? Please connect and restart..." 8 78
	exit 42
}

function err_common {
	whiptail --title "ERROR" --infobox "there was a problem - \
Maybe I had too little boom boom sleep?" 8 78
	exit 42
}

chvt 2
echo "second stage install taking off..."
setterm -blank 0 -powersave off

trap "err_apt" ERR
debconf-apt-progress -- apt update -y
debconf-apt-progress -- apt install -y omxplayer i3 lightdm youtube-dl
whiptail --title "youtube-dl" --infobox "patch in the latest youtube-dl..." 8 78
wget https://yt-dl.org/latest/youtube-dl -O /usr/local/bin/youtube-dl 2> /dev/null
chmod a+rx /usr/local/bin/youtube-dl

whiptail --title "configuration" --infobox "installing configs..." 8 78
mkdir -p /home/pi/Potty-Boom-Boom/Files
cp Potty-Boom-Boom-watchdog.sh /home/pi/Potty-Boom-Boom/

tee /etc/lightdm/lightdm.conf > /dev/null <<EOF
[SeatDefaults]
autologin-user=pi
autologin-user-timeout=0

[XDMCPServer]

[VNCServer]
EOF

mkdir -p /home/pi/.i3
tee /home/pi/.i3/config > /dev/null <<EOF
# i3 config file (v4)
exec_always /home/pi/Potty-Boom-Boom/Potty-Boom-Boom-watchdog.sh
EOF
chown -R pi.pi /home/pi/.i3

PLAYLIST=`cat PLAYLIST`
if [[ -n "$PLAYLIST" ]]; then 
	# we have to play with mawk as it is debian standard :(
	(
	cd /home/pi/Potty-Boom-Boom/Files/
	youtube-dl --prefer-free-formats --newline --format 'mp4[height<=720]' \
		"$PLAYLIST"
	) | /usr/bin/mawk -W interactive '
function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)  { return rtrim(ltrim(s)); }
BEGIN {
        current=0;
        total=0;
        videoname="";
        print "HALLO";
}
/\[download\] Downloading video/ {
        current=$4;
        total=$6;
print "A";
}
/\[download\] Destination:/ {
        $1="";
        $2="";
        videoname=trim($0);
print "B";
}
/\[download\] +[0-9.]+% of/ {
        printf( "XXX\n%d\nVideo %d/%d: %s (ETA %s)\nXXX\n",
                (100/total)*(current-1+int($2)/100), current, total, videoname, $8 );
}
' > >( whiptail --title "Download Initial Playlist" --gauge "starting download..." 8 70 0 )

fi

chown -R pi:pi /home/pi/Potty-Boom-Boom
amixer sset PCM,0 100 > /dev/null
alsactl store

# remove ourselves
systemctl disable potty-boom-install > /dev/null
rm /etc/systemd/system/potty-boom-install.service

shutdown -r now
exit 0

