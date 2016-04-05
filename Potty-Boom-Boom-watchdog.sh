#/bin/sh

while true
do
        myrandomfile=$(find ~/Potty-Boom-Boom/Files/ -type f | shuf -n 1)
        omxplayer -b "${myrandomfile}"
done
