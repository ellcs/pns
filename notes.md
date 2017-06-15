- [DEBUG](#debug)
- [CONFIG](#config)
- [INFO](#info)

# DEBUG

```bash
# dump tcp traffic (debug)
tcpdump -i eth0 port not 22
```

```bash
# make a request through a proxy
wget --proxy 172.25.0.5:3128 "172.27.0.4"
```

# CONFIG

```bash
# config of squid (proxy)
# file: /etc/squid/squid.conf
http_port 127.0.0.1:3128
http_port 172.25.0.5:3128
acl local_network src 172.27.0.0/24
http_access allow local_network
http_access allow localhost
http_access deny all
cache_dir aufs /var/spool/squid 500 256 256
```

# INFO

Exercise 2:
- Make sure that you have firewall rules in both directions :)
- (kpk) network overview
  - No router images for firewalls
  - Clients should have different images then servers
  - Map IPs to interfaces
  - Write down subnet-masks to networks only
  - Move backend to a similar position as intern.
  - No diagonal lines. Better use edges.
- (kpk) NAT
  - If you use a NAT, make sure that you can not access the NATed server. Why hide a server, if it's still available?

Exercise 3:


# General

Copy `routes.sh` on all server:

```
for ip in $(cat ip_list.txt); do scp routes.sh "root@$ip:"; done
```

Make it executable on all servers:

```
for ip in $(cat ip_list.txt); do scp routes.sh "root@$ip:"; done
```
