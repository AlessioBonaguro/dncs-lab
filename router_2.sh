# Startup commands for Router-2 go here
sudo apt update
sudo ip link set enp0s8 up
sudo ip link set enp0s9 up
# Enable packet forwarding
sudo /bin/su -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
sudo sysctl -p /etc/sysctl.conf
# Set ip addresses
echo "Router-2 -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/50-router-2-netConf.yaml
network:
   ethernets:
       enp0s8:
           dhcp4: false
           addresses: [192.168.64.1/23]
           gateway4: 192.168.64.1
           routes:
           - to: 192.168.224.0/25
             via: 192.168.64.1
           - to: 192.168.208.0/22
             via: 192.168.64.1
       enp0s9:
           dhcp4: false
           addresses: [192.168.128.2/24]
           gateway4: 192.168.128.1
           routes:
           - to: 192.168.224.0/25
             via: 192.168.128.1
           - to: 192.168.208.0/22
             via: 192.168.128.1
   version: 2
EOF
"
# sudo ifconfig enp0s8 192.168.64.1 netmask 255.255.254.0
# sudo ifconfig enp0s9 192.168.128.2 netmask 255.255.255.0
echo "Router-2 -> static IP set..\n"
# sudo route add -net 192.168.64.0 netmask 255.255.254.0 dev enp0s8
# sudo route add -net 192.168.128.0 netmask 255.255.255.0 gw 192.168.128.1 dev enp0s9
# sudo route add -net 192.168.192.0 netmask 255.255.252.0 gw 192.168.128.1 dev enp0s9
sudo netplan apply
echo "Router-2 -> Route add..\n"
