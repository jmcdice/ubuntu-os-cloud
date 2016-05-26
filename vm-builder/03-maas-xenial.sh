# Create a xenial MAAS VM
# 
# Change password post-install.

source ./vm-builder-common.sh || ( echo "Failed: Need vm-builder-common.sh" && exit 1 )

# Env specific
vm='maas-xenial'
rel='xenial'
ip='10.1.0.23'
mask='255.255.255.0'
net='10.1.0.0'
bcast='10.1.0.255'
gw='10.1.0.1'
edns='135.1.1.111'

domain='cloud-band.com'
user='joey'
pass='password01'

sudo umount /mnt/
start_vm

exit
echo "" > ~/.ssh/known_hosts
#build_vm
#exit
qcow=$(dir -1 maas-xenial/*qcow2)
echo "Operating on: $qcow"
sudo guestmount -a $qcow -i /mnt/
sudo sed -i 's/eth0/ens3/' /mnt/etc/network/interfaces
sudo mkdir -p /mnt/home/$user/.ssh/
sudo cp ~/.ssh/id_rsa.pub /mnt/home/$user/.ssh/authorized_keys
sudo chown -R $user:$user /mnt/home/$user/.ssh/
sudo chmod 600 /mnt/home/$user/.ssh/authorized_keys
sudo sh -c "echo 'nameserver $edns' >> /mnt/etc/resolv.conf"
sudo umount /mnt/
start_vm

