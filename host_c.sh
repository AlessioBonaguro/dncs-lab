# Startup commands for host-C go here
sudo apt update
sudo apt install -y docker.io
sudo ip link set enp0s8 up
echo "Host-C -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/51-host-c-netConf.yaml
network:
   ethernets:
       enp0s8:
           dhcp4: false
           addresses: [192.168.64.2/23]
           routes:
           - to: 192.168.208.0/22
             via: 192.168.64.1
           - to: 192.168.224.0/25
             via: 192.168.64.1
   version: 2
EOF
"
echo "Host-C -> static IP set..\n"
echo "Host-C -> Route add..\n"
sudo netplan apply
