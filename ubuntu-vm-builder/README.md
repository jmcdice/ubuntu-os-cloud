# ubuntu-vm-builder

These scripts will deploy VM's for the last 2 LTS releases of Ubuntu.

- 01-trusty-maas.sh
- 02-trusty-juju-controller.sh
- 03-xenial-maas.sh
- 04-xenial-juju-controller.sh


You can run all all 4 scripts (make sure they match you're networking).
Once finished, you can start a pair like so:

   $ virsh start trusty-maas
   $ virsh start trusty-juju

