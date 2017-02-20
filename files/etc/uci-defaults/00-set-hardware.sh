#!/bin/sh

if [ ! -s /etc/HARDWARE ]; then
    read HARDWARE < /tmp/sysinfo/model
    [ -z "$HARDWARE" ] && { 
        HARDWARE=$(grep ^machine /proc/cpuinfo | sed 's/.*: \(.*\)/\1/')
    }
    [ -z "$HARDWARE" ] && {
    	if $(grep -qc ^"model name" /proc/cpuinfo); then 
    		HARDWARE=$(uname -m)-$(grep ^"model name" /proc/cpuinfo | sed 's/.*: \(.*\)/\1/')
    	elif 
		HARDWARE=$(uname -m)-unknown
    	fi
    }
    echo "$HARDWARE" > /etc/HARDWARE
fi
