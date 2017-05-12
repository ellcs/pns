# dump tcp traffic (debug)
tcpdump -i eth0 port not 22

# make a request through a proxy
wget --proxy 172.25.0.5:3128 "172.27.0.4"
