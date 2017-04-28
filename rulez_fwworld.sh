# fwworld
# jedes packet von intern soll zu world gehen koennen.
# jedes antwort packet soll zu intern gehen koennen.
# intern: eth0
# extern: eth1
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP

# fextern
# http server der firma
# MASQUERADE aktiviert das NATing. Das interne interface muss angegeben werden.
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j DNAT --to 172.25.0.3:80
iptables -A FORWARD -i eth1 -p tcp --dport 80 -d 172.25.0.3 -j ACCEPT

# imap
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 143 -j DNAT --to 172.25.0.5:143
iptables -A FORWARD -i eth0 -p tcp --dport 143 -d 172.25.0.5 -j ACCEPT

# smtp
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 25 -j DNAT --to 172.25.0.2:25
iptables -A FORWARD -i eth0 -p tcp --dport 25 -d 172.31.0.2 -j ACCEPT

# FAQ:
