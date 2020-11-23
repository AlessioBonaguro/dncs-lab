# Startup commands for Roouter-1 go here
sudo apt update
sudo apt install vlan
# Enable packet forwarding
sudo /bin/su -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
sudo sysctl -p /etc/sysctl.conf
# Set static IP addresses
echo "Router-1 -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/49-router-1-netConf.yaml
network:
   ethernets:
       enp0s8.2:
           dhcp4: false
           addresses: [192.168.224.1/25]
       enp0s8.3:
           dhcp4: false
           addresses: [192.168.208.1/22]
       enp0s9:
           dhcp4: false
           addresses: [192.168.128.1/24]
           routes:
           - to: 192.168.64.0/23
             via: 192.168.128.2
   version: 2
EOF
"
echo "Router-1 -> static IP set..\n"
sudo netplan apply
echo "Router-1 -> Route add..\n"
