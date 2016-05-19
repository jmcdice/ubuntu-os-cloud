# Create a xenial juju VM
# Change password post-install.

source ./vm-builder-common.sh || ( echo "Failed: Need vm-builder-common.sh" && exit 1 )

# Env specific
vm='juju-xenial'
rel='xenial'
ip='10.1.0.4'
mask='255.255.255.0'
net='10.1.0.0'
bcast='10.1.0.255'
gw='10.1.0.1'

domain='cloud-band.com'
user='joey'
pass='password01'

build_vm
start_vm

