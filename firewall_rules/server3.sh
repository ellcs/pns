# server3
#
# services:
# ssh: port 22
# imap: port 134
# squid: port 3128

iptables -A INPUT  -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

iptables -A INPUT  -p tcp --dport 134 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 134 -j ACCEPT

iptables -A INPUT  -p tcp --dport 3128 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 3128 -j ACCEPT

# erlaube normale nutzung des internets, wenn ausgehend von server
iptables -A OUTPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP
