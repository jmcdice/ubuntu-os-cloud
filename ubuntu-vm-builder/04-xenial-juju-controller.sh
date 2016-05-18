# Create a xenial MAAS VM
# 
# Change password post-install.

sudo ubuntu-vm-builder kvm xenial \
    --domain cloud-band.com \
    --dest juju-xenial \
    --hostname juju-xenial \
    --arch amd64 \
    --mem 2048 \
    --cpus 4 \
    --user joey \
    --pass password \
    --bridge br0 \
    --ip 10.1.0.5 \
    --mask 255.255.255.0 \
    --net 10.1.0.0 \
    --bcast 10.1.0.255 \
    --gw 10.1.0.1 \
    --dns 10.1.0.1 \
    --components main,universe \
    --addpkg acpid \
    --addpkg openssh-server \
    --addpkg linux-image-generic \
    --libvirt qemu:///system ;

