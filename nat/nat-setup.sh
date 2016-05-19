# Configure NAT and ip forwarding so that hosts on the private network can get 
# out to the internet in order to download software.

# Set this to your public iface
public_interface='br1'
rc_file='/etc/rc.local'

# Enable packet forwarding.
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -p

# Enable forwarding and masqerading 
grep -q MASQUERADE $rc_file
if [ $? != 0 ]; then
   sed -i "/^exit/i \
/sbin/iptables -P FORWARD ACCEPT \n\
/sbin/iptables -t nat -A POSTROUTING -o $public_interface -j MASQUERADE\n" $rc_file
sudo bash $rc_file
fi

sudo sh -c "iptables-save > /etc/iptables.rules"
