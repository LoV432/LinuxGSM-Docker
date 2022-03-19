#!/bin/bash
echo "-----BEGIN-----"
if [ ! -e ~/linuxgsm.sh ]; then
    echo "Initializing Linuxgsm User Script in New Volume"
    cp /opt/linuxgsm/linuxgsm.sh ./linuxgsm.sh
    /home/linuxgsm/linuxgsm.sh cod4server
fi

if [ -e ~/cod4server* ]; then
    if [ ! -e ~/serverfiles/cod4x18_dedrun ]; then
        /home/linuxgsm/cod4server* ai
        /home/linuxgsm/cod4server* start
    fi
    /home/linuxgsm/cod4server* ul
    /home/linuxgsm/cod4server* r
    tail -f /dev/null
    #tail -F /home/linuxgsm/log/console/cod4server*-console.log # "docker logs -f container-name" will give console realtime output

else
    tail -f /dev/null
fi
