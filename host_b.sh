# Startup commands for host-B go here
sudo apt update
sudo ip link set enp0s8 up
echo "Host-B -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/51-host-b-netConf.yaml
network:
   ethernets:
       enp0s8:
           dhcp4: false
           addresses: [192.168.208.2/22]
           gateway4: 192.168.208.1
           routes:
           - to: 192.168.64.0/23
             via: 192.168.208.1
   version: 2
EOF
"
# sudo ifconfig enp0s8 192.168.192.2 netmask 255.255.252.0
echo "Host-B -> static IP set..\n"
# sudo route add -net 192.168.64.0 netmask 255.255.254.0 gw 192.168.192.1 dev enp0s8
# sudo route add -net 192.168.128.0 netmask 255.255.255.0 gw 192.168.192.1 dev enp0s8
# sudo route add -net 192.168.192.0 netmask 255.255.252.0 gw 192.168.192.1 dev enp0s8
sudo netplan apply
echo "Host-B -> Route add..\n"
