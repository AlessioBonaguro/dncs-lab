# DNCS-LAB

This repository contains the Vagrant files required to run the virtual lab environment used in the DNCS course.
```


        +-----------------------------------------------------+
        |                                                     |
        |                                                     |eth0
        +--+--+                +------------+             +------------+
        |     |                |            |             |            |
        |     |            eth0|            |eth2     eth2|            |
        |     +----------------+  router-1  +-------------+  router-2  |
        |     |                |            |             |            |
        |     |                |            |             |            |
        |  M  |                +------------+             +------------+
        |  A  |                      |eth1                       |eth1
        |  N  |                      |                           |
        |  A  |                      |                           |
        |  G  |                      |                     +-----+----+
        |  E  |                      |eth1                 |          |
        |  M  |            +-------------------+           |          |
        |  E  |        eth0|                   |           |  host-c  |
        |  N  +------------+      SWITCH       |           |          |
        |  T  |            |                   |           |          |
        |     |            +-------------------+           +----------+
        |  V  |               |eth2         |eth3                |eth0
        |  A  |               |             |                    |
        |  G  |               |             |                    |
        |  R  |               |eth1         |eth1                |
        |  A  |        +----------+     +----------+             |
        |  N  |        |          |     |          |             |
        |  T  |    eth0|          |     |          |             |
        |     +--------+  host-a  |     |  host-b  |             |
        |     |        |          |     |          |             |
        |     |        |          |     |          |             |
        ++-+--+        +----------+     +----------+             |
        | |                              |eth0                   |
        | |                              |                       |
        | +------------------------------+                       |
        |                                                        |
        |                                                        |
        +--------------------------------------------------------+



```

# Requirements
 - Python 3
 - 10GB disk storage
 - 2GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet

# How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/fabrizio-granelli/dncs-lab`
 - You should be able to launch the lab from within the cloned repo folder.
```
cd dncs-lab
[~/dncs-lab] vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 4 VMs
 ```
 [dncs-lab]$ vagrant status                                                                                                                                                                
Current machine states:

router                    running (virtualbox)
switch                    running (virtualbox)
host-a                    running (virtualbox)
host-b                    running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them:
`vagrant ssh router`
`vagrant ssh switch`
`vagrant ssh host-a`
`vagrant ssh host-b`
`vagrant ssh host-c`

# Assignment
This section describes the assignment, its requirements and the tasks the student has to complete.
The assignment consists in a simple piece of design work that students have to carry out to satisfy the requirements described below.
The assignment deliverable consists of a Github repository containing:
- the code necessary for the infrastructure to be replicated and instantiated
- an updated README.md file where design decisions and experimental results are illustrated
- an updated answers.yml file containing the details of your project

## Design Requirements
- Hosts 1-a and 1-b are in two subnets (*Hosts-A* and *Hosts-B*) that must be able to scale up to respectively 92 and 513 usable addresses
- Host 2-c is in a subnet (*Hub*) that needs to accommodate up to 388 usable addresses
- Host 2-c must run a docker image (dustnic82/nginx-test) which implements a web-server that must be reachable from Host-1-a and Host-1-b
- No dynamic routing can be used
- Routes must be as generic as possible
- The lab setup must be portable and executed just by launching the `vagrant up` command

## Tasks
- Fork the Github repository: https://github.com/fabrizio-granelli/dncs-lab
- Clone the repository
- Run the initiator script (dncs-init). The script generates a custom `answers.yml` file and updates the Readme.md file with specific details automatically generated by the script itself.
  This can be done just once in case the work is being carried out by a group of (<=2) engineers, using the name of the 'squad lead'.
- Implement the design by integrating the necessary commands into the VM startup scripts (create more if necessary)
- Modify the Vagrantfile (if necessary)
- Document the design by expanding this readme file
- Fill the `answers.yml` file where required (make sure that is committed and pushed to your repository)
- Commit the changes and push to your own repository
- Notify the examiner (fabrizio.granelli@unitn.it) that work is complete specifying the Github repository, First Name, Last Name and Matriculation number. This needs to happen at least 7 days prior an exam registration date.

# Notes and References
- https://rogerdudler.github.io/git-guide/
- http://therandomsecurityguy.com/openvswitch-cheat-sheet/
- https://www.cyberciti.biz/faq/howto-linux-configuring-default-route-with-ipcommand/
- https://www.vagrantup.com/intro/getting-started/


# Design
## Network diagram

![Network diagram](DisegnoRete/NetworkDesign.png)

Network is characterized by six devices. First of all, I assigned at every machine an IP addresses and a netmask.  
To do this, I had to respect the design requirements, in particular the number of usable addresses of every devices.  
In this part of work, I didn't consider *Switch*. Sure enough, *switch* works at L2 of tcp/ip stack, so it doesn't require an IP addresses.  
Moreover, I use the range of addresses by 192.168.0.0 to 192.168.255.255, because, like 10.0.0.0/18 and 172.16.0.0/12, can be used for private network and the selected range permit me to accommodate sufficently addresses.  
So I used:  

* **Host-a**  
Host-a needs to accommodate 92 addresses, so I assigned the netmask **255.255.255.128**. So I can connect to the netmask 2<sup>7</sup>-1 = 127 devices. Two devices are just assigned (*router-1* and *host-a*) so remain 125 free addresses. At this stage I could assign to *host-b* subnet the address **192.168.224.0/23** and to *host-c* **192.168.224.2**.
* **Host-b**  
Host-b needs to accommodate 513 addresses, so I assigned the netmask **255.255.252.0**. So *host-c* subnet support maximus 2<sup>10</sup>-1 = 1023 devices. Two devices are just assigned (*router-1* and *host-b*) so remain 1021 free addresses. So it was assigned to the subnet the address **192.168.208.0/22** and to *host-b* **192.168.208.2**.
* **Host-c**  
Host-c needs to accommodate 388 addresses, so I assigned the netmask **255.255.254.0**. With this netmask, in the *host-c* subnet can connect 2<sup>9</sup>-1 = 511 devices. Two devices are just assigned (*router-2* and *host-c*) so remain 509 free addresses. At this time, I decided that *host-c* subnet is **192.168.64.0/23** and to *host-c* is assigned **192.168.64.2**.
* **Router 2**  
Router-2 is linked to two subnet. One of this is the *host-c* subnet. In this subnet, *router-2*'s address is **192.168.64.1**.  
The other subnet represents the link with *router-1*, and in this I didn't have particular rules give by project to respect, so I decided to use a netmask **255.255.255.0**, with 2<sup>8</sup>-1 = 255 addresses. So, this subnet is represented by **192.168.128.0/24** and the *router-2*'s address is **192.168.128.2**.
* **Router 1**  
Router-1 is also link at two subnet. First of this is the link with *router-2*, and in this subnet it's address is **192.168.128.1**.
In the other one, there is a VLAN to divede port in two virtual subnet. So, enp0s8 (wich is the port name) are virtual splitted in two: enp0s8.2 and enp0s8.3. This can be made through a trunk port, wich allows more then one VLAN in the same port. Enp0s8.2 is connected to VLAN tag 2, so to the *host-a*'s subnet, and in this the *router-1*'s address is **192.168.224.1**. On the other side, enp0s8.3 is connected to VLAN tag 3, so to the *host-b*'s subnet, and in this the *router-1*'s address is **192.168.208.1**.

In the left part of the schematic, where is the *switch*, I opted for a VLAN. Sure enaugh, I had to manage a net where two devices can't speak toghether, but they was link to the same router and to the same switch. So the best way for me it's to use a VLAN.

## Devices configurations
For all devices I prepared script. In some case are invoked only to the firt start-up of machine, some other at every start up.
### Host-a
For host-a, I use only a script when machine is created.  
```bash
sudo apt update  
sudo ip link set enp0s8 up
echo "Host-A -> net set up..\n"
sudo /bin/su -c \
"cat << EOF > /etc/netplan/50-host-a-netConf.yaml
network:
   ethernets:
       enp0s8:
           dhcp4: false
           addresses: [192.168.224.2/25]
           gateway4: 192.168.192.1
           routes:
           - to: 192.168.224.0/25
           via: 192.168.224.1
           - to: 192.168.64.0/23
             via: 192.168.224.1
   version: 2
EOF
"
echo "Host-A -> static IP set..\n"
sudo netplan apply
echo "Host-A -> Route add..\n"
```
