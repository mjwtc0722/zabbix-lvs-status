#!/bin/bash
#
FUNCTION=$1
PROTOCOL=$2
VIP=$3
RIP=$4

function ActiveConn {
    sudo /sbin/ipvsadm -Ln |sed -n "/$1  $2/,/$3/p" |tail -n 1 |awk '{print $5}'
}
function InActConn {
    sudo /sbin/ipvsadm -Ln |sed -n "/$1  $2/,/$3/p" |tail -n 1 |awk '{print $6}'
}
function CPS {
    sudo /sbin/ipvsadm -Ln --rate |sed -n "/$1  $2/,/$3/p" |tail -n 1 |awk '{print $3}'
}
function InPPS {
    sudo /sbin/ipvsadm -Ln --rate |sed -n "/$1  $2/,/$3/p" |tail -n 1 |awk '{print $4}'
}
function OutPPS {
    sudo /sbin/ipvsadm -Ln --rate |sed -n "/$1  $2/,/$3/p" |tail -n 1 |awk '{print $5}'
}
function InBPS {
    sudo /sbin/ipvsadm -Ln --rate |sed -n "/$1  $2/,/$3/p" |tail -n 1 |awk '{print $6}'
}
function OutBPS {
    sudo /sbin/ipvsadm -Ln --rate |sed -n "/$1  $2/,/$3/p" |tail -n 1 |awk '{print $7}'
}

$FUNCTION $PROTOCOL $VIP $RIP
