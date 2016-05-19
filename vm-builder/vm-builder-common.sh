#!/bin/bash

function build_vm() {

   echo "Building: $vm"

   # We'll use this ssh key to login to our VM's
   # Create it if it doesn't exist.
   if [ ! -f ~/.ssh/id_rsa ]; then
      echo "Creating rsa key."
      ssh-keygen -N '' -f ~/.ssh/id_rsa &> /dev/null
   fi

   sudo ubuntu-vm-builder kvm $rel \
    --domain $domain \
    --dest $vm \
    --hostname $vm \
    --arch amd64 \
    --mem 2048 \
    --cpus 4 \
    --user $user --pass $pass \
    --ssh-key ~/.ssh/id_rsa.pub \
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

function wait_for_vm() {

   while ! nc -w 2 -z $vm 22; do sleep 2; done
}
