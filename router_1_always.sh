# This run always when router-1 starts
# config vlan port
sudo modprobe 8021q
sudo vconfig add enp0s8 2
sudo vconfig add enp0s8 3
sudo ip link set enp0s8 up
sudo ip link set enp0s8.2 up
sudo ip link set enp0s8.3 up
sudo ip link set enp0s9 up
