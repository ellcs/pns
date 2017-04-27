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
  88bd130ba3ec)
    echo "Backend1"
    ;;
  14a0fa88f525)
    echo "Backend2"
    ;;
  14322b435899)
    echo "Backend3"
    apt-get install cups cups-client cups-bsd
    service cups start
    ;;
  272f4cc9748a)
    echo "Server1"
    apt-get install nginx
    service nginx start
    ;;
  82a69612b1dc)
    echo "Server2"
  755518a7bf89)
    echo "Server3"
    ;;
  2241e81007bb)
    echo "world1"
    ;;
  dae0274ccffd)
    echo "world2"
    apt-get install nginx
    service nginx start
    ;;
  ae64303a4462)
    echo "Client1"
    ;;
  97162ee057e8)
    echo "Client2"
    ;;
  70ab0a05aa0f)
    echo "Firewall intern"
    ;;
  b79953b0d499)
    echo "Firewall world"
    ;;
esac
