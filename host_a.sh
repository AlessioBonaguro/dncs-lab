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
           gateway4: 192.168.224.1
           routes:
           - to: 192.168.64.0/23
             via: 192.168.224.1
   version: 2
EOF
"
echo "Host-A -> static IP set..\n"
sudo netplan apply
echo "Host-A -> Route add..\n"
