# MAAS Xenial Instalal
# 
# bash maas-xenial-install.sh

function install_maas() {

   pkgs='git vim lsof tcpdump strace htop nload software-properties-common'
   sudo apt-get -y install $pkgs
   sudo apt-add-repository ppa:maas/next
   sudo apt-get update
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

function configure_dhcp() {

   hostname=$(hostname)
   maas admin ipranges create type=dynamic start_ip=10.1.0.28 end_ip=10.1.0.100
   maas admin vlan update fabric-0 untagged dhcp_on=True primary_rack="$hostname"
}

function import_images() {

   maas admin boot-resources import
}

install_maas
configure_maas
sleep 60 
import_images
configure_dhcp
