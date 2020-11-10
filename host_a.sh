# Startup commands for host-A go here
sudo apt update
sudo ip link set enp0s8 up
echo "Host-A -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/50-host-a-netConf.yaml
network:
   ethernets:
       enp0s8:
           dhcp4: false
           addresses: [192.168.192.2/22]
           gateway4: 192.168.192.1
           routes:
           - to: 192.168.64.0/23
             via: 192.168.192.1
           - to: 192.168.128.0/24
             via: 192.168.192.1
           - to: 192.168.192.0/22
             via: 192.168.192.1
   version: 2
EOF
"
# sudo ifconfig enp0s8 192.168.192.2 netmask 255.255.252.0
echo "Host-A -> static IP set..\n"
# sudo route add -net 192.168.64.0 netmask 255.255.254.0 gw 192.168.192.1 dev enp0s8
# sudo route add -net 192.168.128.0 netmask 255.255.255.0 gw 192.168.192.1 dev enp0s8
# sudo route add -net 192.168.192.0 netmask 255.255.252.0 gw 192.168.192.1 dev enp0s8
echo "Host-A -> Route add..\n"
sudo netplan apply
