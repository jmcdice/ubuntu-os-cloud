# Create a xenial MAAS VM
# 
# Change password post-install.

source ./vm-builder-common.sh || ( echo "Failed: Need vm-builder-common.sh" && exit 1 )

# Env specific
vm='maas-xenial'
rel='xenial'
ip='10.1.0.22'
mask='255.255.255.0'
net='10.1.0.0'
bcast='10.1.0.255'
gw='10.1.0.1'

domain='cloud-band.com'
user='joey'
pass='password01'

echo "" > ~/.ssh/known_hosts
#build_vm
#sudo guestmount -a maas-xenial/tmpELDFKn.qcow2 -i /mnt/
sudo sed -i 's/eth0/ens3/' /mnt/etc/network/interfaces
sudo umount /mnt/
start_vm

