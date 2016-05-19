#!/bin/bash
#
# PXE Boot a compute.

user=$1
pass=$2

function pxeboot() {

   ip=$1
   echo "PXE Booting: $ip"
   ipmitool -I lanplus -U $user -P $pass -H $ip chassis power off; sleep 6
   ipmitool -I lanplus -U $user -P $pass -H $ip chassis bootdev pxe; sleep 6
   ipmitool -I lanplus -U $user -P $pass -H $ip chassis power on; sleep 6
   ipmitool -I lanplus -U $user -P $pass -H $ip chassis power status
   echo ""
}

function usage() {

   echo "$0 <ilo-user> <ilo-pass> <ilo-ip>"
   exit 255
}

if [ -z $3 ]; then
   usage
fi

pxeboot $3

