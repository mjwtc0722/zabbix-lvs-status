#!/bin/bash
#
IFS=$'\n'
TOTAL_LINES=$(sudo /sbin/ipvsadm -Ln |sed -n '4,$p' |awk '{print $1" "$2}' |wc -l)
LINE_NUM=0

printf '{ "data" : [\n'
for LINE in $(sudo /sbin/ipvsadm -Ln |sed -n '4,$p' |awk '{print $1" "$2}')
do
    LINE_NUM=$(( $LINE_NUM + 1 ))
    if [ $(echo ${LINE} | awk '{print $1}') = "TCP" -o $(echo ${LINE} | awk '{print $1}') = "UDP" ];then
        PROTOCOL=$(echo ${LINE} | awk '{print $1}')
        VIP=$(echo ${LINE} | awk '{print $2}')
    fi
    if [ $(echo ${LINE} | awk '{print $1}') = "->" ];then
        RIP=$(echo ${LINE} | awk '{print $2}')
        printf "{ \"{#PROTOCOL}\" : \"${PROTOCOL}\", \"{#VIP}\" : \"${VIP}\", \"{#RIP}\" : \"${RIP}\" }"
        if [ $LINE_NUM != $TOTAL_LINES ];then
            printf ", \n"
        fi
    fi
done
printf " ] }\n"
