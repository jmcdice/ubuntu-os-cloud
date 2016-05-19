#!/bin/bash

function build_vm() {

   echo "Building: $vm"

   sudo ubuntu-vm-builder kvm $rel \
    --domain $domain \
    --dest $vm \
    --hostname $vm \
    --arch amd64 \
    --mem 2048 \
    --cpus 4 \
    --user $user \
    --pass $pass \
    --bridge br0 \
    --ip $ip \
    --mask $mask \
    --net $net \
    --bcast $bcast \
    --gw $gw \
    --dns $gw \
    --components main,universe \
    --addpkg acpid \
    --addpkg openssh-server \
    --addpkg linux-image-generic \
    --libvirt qemu:///system ;

}

function start_vm() {
   virsh start $vm
   grep -q $vm /etc/hosts || sudo sh -c "echo '$ip $vm' >> /etc/hosts"
}

