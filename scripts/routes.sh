#!/bin/bash

# server:  "172.25.0.0"
# backend: "172.26.0.0"
# world:   "172.27.0.0"
# client:  "172.28.0.0"
#
# 70ab0a05aa0f	mantel01_fwintern	172.25.0.4 172.28.0.3 172.26.0.5
# b79953b0d499	mantel01_fwworld	172.27.0.3 172.25.0.6
#
# 272f4cc9748a	mantel01_server1	172.25.0.3
# 82a69612b1dc	mantel01_server2	172.25.0.2
# 755518a7bf89	mantel01_server3	172.25.0.5
#
# 88bd130ba3ec	mantel01_backend1	172.26.0.2
# 14a0fa88f525	mantel01_backend2	172.26.0.3
# 14322b435899	mantel01_backend3	172.26.0.4
#
# 2241e81007bb	mantel01_world1	  172.27.0.2
# dae0274ccffd	mantel01_world2	  172.27.0.4
#
# ae64303a4462	mantel01_client1	172.28.0.4
# 97162ee057e8	mantel01_client3	172.28.0.2

if [[ "$HOST" == "" ]]; then
  HOST=$HOSTNAME
fi
echo "Hostname: $HOST"
NETMASK="255.255.0.0"
case "$HOST" in
  88bd130ba3ec|14a0fa88f525|14322b435899)
    echo "Backend network"
    gateway="172.26.0.5"
    route add -net "172.25.0.0" netmask $NETMASK gateway $gateway metric 1
    route add -net "172.27.0.0" netmask $NETMASK gateway $gateway metric 1
    route add -net "172.28.0.0" netmask $NETMASK gateway $gateway metric 1
    ;;
  272f4cc9748a|82a69612b1dc|755518a7bf89)
    echo "Server network"
    gateway_world="172.25.0.6"
    gateway_intern="172.25.0.4"
    route add -net "172.26.0.0" netmask $NETMASK gateway $gateway_intern metric 1
    route add -net "172.27.0.0" netmask $NETMASK gateway $gateway_world metric 1
    route add -net "172.28.0.0" netmask $NETMASK gateway $gateway_intern  metric 1
    ;;
  2241e81007bb|dae0274ccffd)
    echo "World network"
    gateway="172.27.0.3"
    route add -net "172.25.0.0" netmask $NETMASK gateway $gateway metric 1
    route add -net "172.26.0.0" netmask $NETMASK gateway $gateway metric 1
    route add -net "172.28.0.0" netmask $NETMASK gateway $gateway metric 1
    ;;
  ae64303a4462|97162ee057e8)
    echo "Client network"
    gateway="172.28.0.3"
    route add -net "172.25.0.0" netmask $NETMASK gateway $gateway metric 1
    route add -net "172.26.0.0" netmask $NETMASK gateway $gateway metric 1
    route add -net "172.27.0.0" netmask $NETMASK gateway $gateway metric 1
    ;;
  70ab0a05aa0f)
    echo "Firewall intern"
    gateway="172.25.0.6"
    route add -net "172.27.0.0" netmask $NETMASK gateway $gateway metric 1
    ;;
  b79953b0d499)
    echo "Firewall world"
    gateway="172.25.0.4"
    route add -net "172.26.0.0" netmask $NETMASK gateway $gateway metric 1
    route add -net "172.28.0.0" netmask $NETMASK gateway $gateway metric 1
    ;;
esac
