# MAAS Trusty Install

suser='joey'
sudo "echo '$suser ALL=(ALL) NOPASSWD: ALL' >> /etc/suoders"

sudo apt-get install software-properties-common
sudo apt-add-repository ppa:maas/stable
sudo apt-get update
sudo apt-get -y install maas

# Create the MAAS login session
sudo maas-region-admin createadmin --username=admin --password=admin --email=nobody@cloud-band.com
maas login admin http://10.1.0.2/MAAS/api/1.0 $(sudo maas-region-admin apikey --username=admin)

# Import some images
maas admin boot-source-selections create 2 os="ubuntu" release="xenial" arches="amd64" subarches="*" labels="*"
maas admin boot-resources import

# Update my private network
# maas admin ipranges create type=dynamic start_ip=172.16.0.20 end_ip=172.16.0.250
# maas admin vlan update fabric-0 untagged dhcp_on=true primary_rack=slmaaster
# maas admin subnet update 172.16.0.0/24 gateway_ip=172.16.0.1 dns_servers=172.16.0.1

