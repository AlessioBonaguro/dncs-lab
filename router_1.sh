# Startup commands for Roouter-1 go here
sudo apt update
sudo apt install vlan
# Enable packet forwarding
sudo /bin/su -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
sudo sysctl -p /etc/sysctl.conf
# Set static IP addresses
echo "Router-1 -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/50-router-1-netConf.yaml
network:
   ethernets:
       enp0s8.2:
           dhcp4: false
           addresses: [192.168.224.1/25]
           gateway4: 192.168.224.1
           routes:
           - to: 192.168.224.0/25
             via: 192.168.224.1
           # - to: 192.168.64.0/23
           #   via: 192.168.128.1
       enp0s8.3:
           dhcp4: false
           addresses: [192.168.208.1/22]
           gateway4: 192.168.208.1
           routes:
           - to: 192.168.208.0/22
             via: 192.168.208.1
           # - to: 192.168.64.0/23
           #   via: 192.168.128.1
       enp0s9:
           dhcp4: false
           addresses: [192.168.128.1/24]
           gateway4: 192.168.128.1
           routes:
           - to: 192.168.128.0/24
             via: 192.168.128.1
           - to: 192.168.64.0/23
             via: 192.168.128.2
   version: 2
EOF
"
# routes enp0s9:
# - to: 192.168.128.0/24
#   via: 192.168.192.1
# - to: 192.168.64.0/23
#   via: 192.168.128.2
# sudo ifconfig enp0s8 192.168.192.1 netmask 255.255.252.0
# sudo ifconfig enp0s9 192.168.128.1 netmask 255.255.255.0
echo "Router-1 -> static IP set..\n"
# sudo route add -net 192.168.64.0 netmask 255.255.254.0 gw 192.168.128.2 dev enp0s9
# sudo route add -net 192.168.128.0 netmask 255.255.255.0 dev enp0s9
# sudo route add -net 192.168.192.0 netmask 255.255.252.0 dev enp0s8
# sudo route del -net 0.0.0.0 netmask 0.0.0.0 gw 192.168.192.1 dev enp0s8
# sudo route del -net 0.0.0.0 netmask 0.0.0.0 gw 192.168.128.1 dev enp0s9
sudo netplan apply
echo "Router-1 -> Route add..\n"
