# Aufgabe 2

- Die Anwendungen sind unter `services.yaml` zu finden.

Firewall1:
- mantel01_fwworld
  - 172.27.0.3/16
  - 172.25.0.6/16
- V:
  - mantel01_world2
  - 172.27.0.4/16
- H:
  - mantel01_server1
  - 172.25.0.3/16


Firewall2:
- mantel01_fwintern
  - 172.28.0.3/16
  - 172.25.0.4/16
  - 172.26.0.5/16
- V:
  - mantel01_server3
  - 172.25.0.5/16
- H:
  - mantel01_client1
  - 172.28.0.4  /16


Drop Everything:

```
# intern: eth0
# extern: eth1
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A FORWARD -i eth0 -j ACCEPT
iptables -A FORWARD -o eth0 -j ACCEPT

iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP

# fextern
# http server der firma
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 80 -j DNAT --to 172.25.0.3:80
iptables -A FORWARD -i eth1 -p tcp --dport 80 -d 172.25.0.3 -j ACCEPT

# imap
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 143 -j DNAT --to 172.25.0.5:143
iptables -A FORWARD -i eth0 -p tcp --dport 143 -d 172.25.0.5 -j ACCEPT

# smtp
iptables -t nat -A PREROUTING -i eth1 -p tcp --dport 25 -j DNAT --to 172.25.0.2:25
iptables -A FORWARD -i eth0 -p tcp --dport 25 -d 172.31.0.2 -j ACCEPT

```


```
# intern:
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP

# allow clients to see the world
iptables -A INPUT  -d 172.28.0.0/16 -s 172.27.0.0/16 -p tcp -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -s 172.28.0.0/16 -d 172.27.0.0/16 -p tcp -m state --state NEW,ESTABLISHED -j ACCEPT

```
