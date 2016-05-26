# MAAS Xenial Instalal
# 
# bash maas-trusty-install.sh

function install_maas() {

   pkgs='git vim lsof tcpdump strace htop nload software-properties-common'
   sudo apt-get -y install $pkgs
   # sudo apt-add-repository ppa:maas/next
   # sudo apt-get update
   sudo apt-get -y install maas
}

function configure_maas() {

   iface=$(route -n |grep ^0.0.0.0| awk '{print $NF}')
   ip=$(ifconfig $iface|perl -lane 'print $1 if (/t addr:(.*?)\s/)')

   # Create the MAAS login session
   sudo maas-region createadmin --username=admin --password=admin --email=nobody@cloud-band.com
   sleep 3
   maas login admin http://$ip/MAAS/api/2.0 $(sudo maas-region apikey --username=admin)
}

function configure_private() {

   uuid=$(maas admin node-groups list | grep uuid | cut -d\" -f4)
   iface=$(route -n |grep ^0.0.0.0| awk '{print $NF}')

   echo "UUID: $uuid"
   echo "Iface: $iface"

   echo "maas admin node-group-interface update -d $uuid $iface \
      ip_range_low=10.1.0.100 \
      ip_range_high=10.1.0.200 \
      static_ip_range_low=10.1.0.50 \
      static_ip_range_high=10.1.0.99 \
      management=2  \
      broadcast_ip=10.1.0.255 \
      router_ip=10.1.0.1"

}

function import_images() {

   # Import Xenial
   maas admin boot-source-selection create 1 os="ubuntu" release="trusty" arches="amd64" subarches="*" labels="*"
}

install_maas
configure_maas
sleep 60 
#configure_private
#import_images
