# If you screw up your maas install and want to completely start over, run this.

sudo apt-get remove --purge $(dpkg -l |grep maas| awk '{ printf "%s ",$2 }')


