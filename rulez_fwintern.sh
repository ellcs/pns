# fwintern
# jedes ausgehende packet von world wird akzeptiert.
# nur verbindungen welche 
# jedes packet von intern soll zu server gehen koennen.
# jedes packet von intern soll zu  world gehen koennen.
# Umgesetzt als: jedes packet von intern, darf ueberall hin.
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# intern
# jedes ausgehende packet ist okay.
iptables -A FORWARD -s 172.28.0.0/16 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# jedes antwort-packet soll zu intern gehen koennen.
iptables -A FORWARD -d 172.28.0.0/16 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT


# backend
# jedes ausgehende packet ist okay.
iptables -A FORWARD -s 172.26.0.0/16 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# jedes antwort-packet soll zu backend gehen koennen.
iptables -A FORWARD -s 172.25.0.0/16 -d 172.26.0.0/16 -j ACCEPT
iptables -A FORWARD -s 172.28.0.0/16 -d 172.26.0.0/16 -j ACCEPT
iptables -A FORWARD -d 172.26.0.0/16 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
# erlaube server und intern mit backend zu sprechen

# Alle anderen packete sollen gedroped werden
iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP

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

