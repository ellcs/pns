# fwworld # jedes packet von intern soll zu world gehen koennen.
# jedes antwort packet soll zu intern gehen koennen.
# intern: eth0
# extern: eth1

export eth_server="eth0"
export eth_world="eth1"

export server1="10.100.1.3"
export server2="10.100.1.2"
export server3="10.100.1.4"

export client="10.100.3.0/24"
export world="10.100.0.0/24"
export backend="10.100.2.0/24"
export server="10.100.1.0/24"

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# fextern
# http server der firma
# MASQUERADE aktiviert das NATing. Das interne interface muss angegeben werden.
iptables -t nat -A POSTROUTING -o $eth_server -j MASQUERADE

iptables -t nat -A PREROUTING -i $eth_world -p tcp --dport 80 -j DNAT --to "$server1:80"
iptables -A FORWARD -i $eth_world -p tcp --dport 80 -d "$server1" -j ACCEPT
iptables -A FORWARD -i $eth_server -p tcp --sport 80 -s "$server1" -j ACCEPT

# imap
iptables -t nat -A PREROUTING -i $eth_world -p tcp --dport 143 -j DNAT --to "$server2:143"
iptables -A FORWARD -i  $eth_world -p tcp --dport 143 -d "$server2" -j ACCEPT
iptables -A FORWARD -i  $eth_server -p tcp --sport 143 -s "$server2" -j ACCEPT

# smtp
iptables -t nat -A PREROUTING -i $eth_world -p tcp --dport 25 -j DNAT --to "$server3:25"
iptables -A FORWARD -i $eth_world -p tcp --dport 25 -d "$server3" -j ACCEPT
iptables -A FORWARD -i $eth_server -p tcp --sport 25 -s "$server3" -j ACCEPT

# intern - stateful
iptables -A FORWARD -i $eth_server -s $client -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o $eth_server -d $client -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# backend - stateful
iptables -A FORWARD -i $eth_server -s $backend -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o $eth_server -d $backend -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# server - stateful
iptables -A FORWARD -i $eth_server -s $server -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o $eth_server -d $server -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP
