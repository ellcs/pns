# fwworld # jedes packet von intern soll zu world gehen koennen.
# jedes antwort packet soll zu intern gehen koennen.
# intern: eth0
# extern: eth1


export server1="172.25.0.2"
export server2="172.25.0.4"
export server3="172.25.0.3"

export client="172.28.0.0/16"
export world="172.27.0.0/16"
export backend="172.26.0.0/16"
export server="172.25.0.0/16"

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# fextern
# http server der firma
# MASQUERADE aktiviert das NATing. Das interne interface muss angegeben werden.
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j DNAT --to "$server1:80"
iptables -A FORWARD -i eth1 -p tcp --dport 80 -d "$server1" -j ACCEPT
iptables -A FORWARD -i eth0 -p tcp --sport 80 -s "$server1" -j ACCEPT

# imap
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 143 -j DNAT --to "$server2:143"
iptables -A FORWARD -i eth0 -p tcp --dport 143 -d "$server2" -j ACCEPT
iptables -A FORWARD -i eth1 -p tcp --sport 143 -s "$server2" -j ACCEPT

# smtp
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 25 -j DNAT --to "$server3:25"
iptables -A FORWARD -i eth0 -p tcp --dport 25 -d "$server3" -j ACCEPT
iptables -A FORWARD -i eth0 -p tcp --sport 25 -s "$server3" -j ACCEPT

# intern - stateful
iptables -A FORWARD -s $client -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d $client -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# backend - stateful
iptables -A FORWARD -s $backend -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d $backend -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# server - stateful
iptables -A FORWARD -s $server -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d $server -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
