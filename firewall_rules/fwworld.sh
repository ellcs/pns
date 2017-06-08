# fwworld
# jedes packet von intern soll zu world gehen koennen.
# jedes antwort packet soll zu intern gehen koennen.
# intern: $eth0
# extern: $eth1

export server_interface="eth0"
export world_interface="eth1"

export backend="172.26.0.0/16"
export intern="172.28.0.0/16"
export server="172.25.0.0/16"

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT


# fextern
# http server der firma
# MASQUERADE aktiviert das NATing. Das interne interface muss angegeben werden.
iptables -t nat -A POSTROUTING -o $server_interface -j MASQUERADE

iptables -t nat -A PREROUTING -p tcp --dport 80 -j DNAT --to 172.25.0.3:80
iptables -A FORWARD -p tcp -o $server_interface --dport 80 -d 172.25.0.3 -j ACCEPT
iptables -A FORWARD -p tcp -i $server_interface --sport 80 -s 172.25.0.3 -j ACCEPT

# imap
iptables -t nat -A PREROUTING -p tcp --dport 143 -j DNAT --to 172.25.0.5:143
iptables -A FORWARD -p tcp -o $server_interface --dport 143 -d 172.25.0.5 -j ACCEPT
iptables -A FORWARD -p tcp -i $server_interface --sport 143 -s 172.25.0.5 -j ACCEPT

# smtp
iptables -t nat -A PREROUTING -p tcp --dport 25 -j DNAT --to 172.25.0.2:25
iptables -A FORWARD -p tcp -o $server_interface --dport 25 -d 172.31.0.2 -j ACCEPT
iptables -A FORWARD -p tcp -i $server_interface --sport 25 -s 172.31.0.2 -j ACCEPT

# intern
# jedes ausgehende packet ist okay.
iptables -A FORWARD -s $intern -i $server_interface -o $world_interface -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d $intern -i $world_interface -o $server_interface -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# backend
# jedes ausgehende packet ist okay.
# jedes antwort-packet soll zu backend gehen koennen.
iptables -A FORWARD -s $backend -i $server_interface -o $world_interface -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d $backend -i $world_interface -o $server_interface -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables -A FORWARD -s $server -i $server_interface -o $world_interface -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d $server -i $world_interface -o $server_interface -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP

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
