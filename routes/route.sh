#!/bin/bash

# Routing
# netstat -r
# route -n
# 

SUBNETMASK="255.255.0.0"
case $HOST in
*backend1) 
*backend2) 
*backend3) 
        echo "Backend network"
        GATEWAY="172.22.0.3"
        route add net 172.21.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        route add net 172.23.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        route add net 172.24.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        ;;
*world1) 
*world2) 
        echo "World network"
        GATEWAY="172.23.0.3"
        route add net 172.21.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        route add net 172.22.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        route add net 172.24.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        ;;
*server1)
*server2)
*server3)
        echo "Server network"
        # world
        route add net 172.23.0.0 netmask $SUBNETMASK gateway 172.21.0.3 metric 1
        # backend
        route add net 172.22.0.0 netmask $SUBNETMASK gateway 172.21.0.6 metric 1
        # client
        route add net 172.24.0.0 netmask $SUBNETMASK gateway 172.21.0.6 metric 1
        ;;
*client1)
*client2)
        echo "Client network"
        GATEWAY="172.24.0.3"
        route add net 172.21.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        route add net 172.22.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        route add net 172.23.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        ;;
*fwintern)
        echo "Firewall intern"
        GATEWAY="172.21.0.3"
        route add net 172.23.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        ;;
*fwworld)
        echo "Firewall world"
        GATEWAY="172.21.0.6"
        route add net 172.22.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        route add net 172.24.0.0 netmask $SUBNETMASK gateway $GATEWAY metric 1
        ;;
*)
        echo "Script: No matching hostname: '$HOST'."
        ;;
esac

