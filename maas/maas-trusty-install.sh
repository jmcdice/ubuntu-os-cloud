# MAAS Trusty Install
# bash maas-trusty-install.sh

function install_maas() {

   sudo apt-get -y install software-properties-common vim
   sudo apt-add-repository -y ppa:maas/stable
   sudo apt-get update
   sudo apt-get -y install maas
}

function configure_maas() {

   ip=$(ifconfig eth0|perl -lane 'print $1 if (/t addr:(.*?)\s/)')

   # Create the MAAS login session
   sudo maas-region-admin createadmin --username=admin --password=admin --email=nobody@cloud-band.com
   maas login admin http://$ip/MAAS/api/1.0 $(sudo maas-region-admin apikey --username=admin)
}

function configure_private() {

   uuid=$(maas admin node-groups list | grep uuid | cut -d\" -f4)

   maas admin node-group-interface update $uuid eth0 \
      ip_range_low=10.1.0.100 \
      ip_range_high=10.1.0.200 \
      static_ip_range_low=10.1.0.50 \
      static_ip_range_high=10.1.0.99 \
      management=2  \
      broadcast_ip=10.1.0.255 \
      router_ip=10.1.0.1

}

function import_images() {

   # Import some images
   # maas admin boot-source-selections create 2 os="ubuntu" release="xenial" arches="amd64" subarches="*" labels="*"
   maas admin boot-resources import
}

install_maas
configure_maas
sleep 60 
configure_private
import_images
