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
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT
iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP

# fextern
iptables -A INPUT -p tcp -s 172.27.0.0/16 --dport 80 -j ACCEPT                                                     |
iptables -A OUTPUT -p tcp -s 172.25.0.3 --sport 1024: -j ACCEPT   
```
