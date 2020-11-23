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
           gateway4: 192.168.64.1
           routes:
           - to: 192.168.208.0/22
             via: 192.168.64.1
           - to: 192.168.224.0/25
             via: 192.168.64.1
   version: 2
EOF
"
# sudo ifconfig enp0s8 192.168.64.2 netmask 255.255.254.0
echo "Host-C -> static IP set..\n"
# sudo route add -net 192.168.64.0 netmask 255.255.254.0 gw 192.168.64.1 dev enp0s8
# sudo route add -net 192.168.128.0 netmask 255.255.255.0 gw 192.168.64.1 dev enp0s8
# sudo route add -net 192.168.192.0 netmask 255.255.252.0 gw 192.168.64.1 dev enp0s8
echo "Host-C -> Route add..\n"
# sudo docker run -it --rm -d -p 8080:80 --name webServer dustnic82/nginx-test
# echo "Host-C -> webServer run..\n"
sudo netplan apply
