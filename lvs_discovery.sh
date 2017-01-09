#!/bin/bash
#
SVC_FLG=1
END_FLG=0
IFS=$'\n'

echo '{ "data" : ['
for LINE in `sudo /sbin/ipvsadm -Ln`
do
    PROTOCOL_INFO=`echo ${LINE} | awk '{print $1}'`
    IP_INFO=`echo ${LINE} | awk '{print $2}'`
    if [ ${END_FLG} != 0 ] ; then
        echo ", "
    fi
    if [ "${PROTOCOL_INFO}" = "TCP" -o "${PROTOCOL_INFO}" = "UDP" ] ; then
        VIP=${IP_INFO}
        PROTOCOL=${PROTOCOL_INFO}
        SVC_FLG=0
    elif [ "${PROTOCOL_INFO}" = "->" -a ${SVC_FLG} = 0 ] ; then
        echo -n "{ \"{#PROTOCOL}\" : \"${PROTOCOL}\", \"{#VIP}\" : \"${VIP}\", \"{#RIP}\" : \"${IP_INFO}\" }"
        END_FLG=1
    fi
done
echo " ] }"
