# ubuntu-os-cloud

Install and configure an ubuntu openstack cloud platform.

# Networking

You have (n) number of physical computes dedicated to this project
They have 3 or more physical interfaces, one of which (public) is able to access the Internet.

Networks:

   - private 
   - public
   - storage

# Step one

Download and install Ubuntu 16.04 LTS on the first bare-metal system.
Powerdown all physical systems except the frontend.

# Step two

We'll be creating a bridged interface on the private network, where we'll install 
a MAAS virtual machine as well as a juju controller virtual machine.

See the 'interfaces' file for an example (note br0 for private)
Restart networking when done:

   $ sudo /etc/init.d/networking restart

# Step three

Install all the packages we need on the frontend.
See the 'frontend-apt-get-install' file.

# Step four

Create the management VM's (I'm doing both trusty and xenial, so I can handle multiple 
deployment version for testing). 
See the scripts in the ubuntu-vm-builder/ directory.
