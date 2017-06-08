# server1
#
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
#
# services:
# ssh: port 22
# nginx webserver: port 80

iptables -A INPUT  -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

iptables -A INPUT  -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT

# erlaube normale nutzung des internets, wenn ausgehend von server
iptables -A OUTPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP
