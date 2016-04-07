#/bin/sh

DIRECTORY="$HOME/Potty-Boom-Boom/Files"
PLAYER="omxplayer -b"

unset old
while true
do
	find "$DIRECTORY" -type f | shuf | while read one; do
		if [ "$one" != "$old" ]; then 
			echo "... boom-booming '$one'"
			$PLAYER "$one"
			old=$one
		fi
	done
done
