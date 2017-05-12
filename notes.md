```
# dump tcp traffic (debug)
tcpdump -i eth0 port not 22
```

```
# make a request through a proxy
wget --proxy 172.25.0.5:3128 "172.27.0.4"
```


```
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

