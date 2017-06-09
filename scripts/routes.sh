#!/bin/bash
#
# f8bb0972b716	mantel_server1		10.100.1.3
# 90599f0e3ddd	mantel_server3		10.100.1.4
# a01efd6f1bd9	mantel_server2		10.100.1.2
# 1f843d58a334	mantel_backend1		10.100.2.2
# 890bca43f496	mantel_backend2		10.100.2.3
# 5a3c1d025952	mantel_backend3		10.100.2.4
# 71fb71bb3d58	mantel_world1			10.100.0.2
# 3c0ac63fd804	mantel_world2			10.100.0.4
# a34f0c4944a7	mantel_client1		10.100.3.3
# 2c5e84370d88	mantel_client3		10.100.3.2
# cc623f1fe1fa	mantel_fwworld		10.100.0.3
# fb9d2643f3f1	mantel_fwintern		10.100.2.5

world_network="10.100.0.0"
server_network="10.100.1.0"
backend_network="10.100.2.0"
client_network="10.100.3.0"

if [[ "$HOST" == "" ]]; then
  HOST=$HOSTNAME
fi
echo "Hostname: $HOST"
NETMASK="255.255.255.0"
case "$HOST" in
  1f843d58a334|890bca43f496|5a3c1d025952)
    echo "Backend network"
    gateway="10.100.2.5"
    route add -net $world_network  netmask $NETMASK gateway $gateway metric 1
    route add -net $server_network netmask $NETMASK gateway $gateway metric 1
    route add -net $client_network netmask $NETMASK gateway $gateway metric 1
    ;;
  f8bb0972b716|90599f0e3ddd|a01efd6f1bd9)
    echo "Server network"
    gateway_fwworld="10.100.1.6"
    gateway_fwintern="10.100.1.5"
    route add -net $client_network  netmask $NETMASK gateway $gateway_fwintern metric 1
    route add -net $world_network   netmask $NETMASK gateway $gateway_fwworld  metric 1
    route add -net $backend_network netmask $NETMASK gateway $gateway_fwintern metric 1
    ;;
  71fb71bb3d58|3c0ac63fd804)
    echo "World network"
    gateway="10.100.0.3"
    route add -net $server_network  netmask $NETMASK gateway $gateway metric 1
    route add -net $backend_network netmask $NETMASK gateway $gateway metric 1
    route add -net $client_network  netmask $NETMASK gateway $gateway metric 1
    ;;
  a34f0c4944a7|2c5e84370d88)
    echo "Client network"
    gateway="10.100.3.4"
    route add -net $world_network   netmask $NETMASK gateway $gateway metric 1
    route add -net $server_network  netmask $NETMASK gateway $gateway metric 1
    route add -net $backend_network netmask $NETMASK gateway $gateway metric 1
    ;;
  fb9d2643f3f1)
    echo "Firewall intern"
    gateway_fwworld="10.100.1.6"
    route add -net $world_network netmask $NETMASK gateway $gateway_fwworld metric 1
    ;;
  cc623f1fe1fa)
    echo "Firewall world"
    gateway_fwintern="10.100.1.5"
    route add -net $client_network  netmask $NETMASK gateway $gateway_fwintern metric 1
    route add -net $backend_network netmask $NETMASK gateway $gateway_fwintern metric 1
    ;;
esac
