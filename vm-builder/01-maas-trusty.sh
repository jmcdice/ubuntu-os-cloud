# Create a trusty MAAS VM
# Change password post-install.

source ./vm-builder-common.sh || ( echo "Failed: Need vm-builder-common.sh" && exit 1 )

# Env specific
vm='maas-trusty'
rel='trusty'
ip='10.1.0.20'
mask='255.255.255.0'
net='10.1.0.0'
bcast='10.1.0.255'
gw='10.1.0.1'

user='joey'
pass='password01'
domain='cloud-band.com'

build_vm
start_vm
wait_for_ssh

ssh-copy-id $vm
