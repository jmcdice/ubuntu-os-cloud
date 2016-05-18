# Configure NAT and ip forwarding so that hosts on the private network can get 
# out to the internet in order to download software.

public_interface='enp4s0f1'

# Enable packet forwarding.
sudo sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
sudo sysctl -p

sudo /sbin/iptables -P FORWARD ACCEPT
sudo /sbin/iptables -t nat -A POSTROUTING -o $public_interface -j MASQUERADE

sudo sh -c "iptables-save > /etc/iptables.rules"
