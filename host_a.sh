# Startup commands for host-A go here
sudo apt update
sudo ip link set enp0s8 up
echo "Host-A -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/51-host-a-netConf.yaml
network:
   ethernets:
       enp0s8:
           dhcp4: false
           addresses: [192.168.224.2/25]
           gateway4: 192.168.192.1
           routes:
           - to: 192.168.64.0/23
             via: 192.168.224.1
   version: 2
EOF
"
# - to: 192.168.224.0/25
# via: 192.168.224.1
# sudo ifconfig enp0s8 192.168.192.2 netmask 255.255.252.0
echo "Host-A -> static IP set..\n"
# sudo route add -net 192.168.64.0 netmask 255.255.254.0 gw 192.168.192.1 dev enp0s8
# sudo route add -net 192.168.128.0 netmask 255.255.255.0 gw 192.168.192.1 dev enp0s8
# sudo route add -net 192.168.192.0 netmask 255.255.252.0 gw 192.168.192.1 dev enp0s8
sudo netplan apply
echo "Host-A -> Route add..\n"

# sudo route del -net 192.168.224.1 gw 192.168.224.1 netmask 255.255.255.128 dev enp0s8
