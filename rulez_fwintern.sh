# fwintern
# jedes packet von intern soll zu server gehen koennen.
# jedes packet von intern soll zu  world gehen koennen.
# Umgesetzt als: jedes packet von intern, darf ueberall hin.
iptables -A INPUT -s 172.28.0.0/16 -j ACCEPT
iptables -A OUTPUT -s 172.28.0.0/16 -j ACCEPT

# jedes antwort-packet von server soll zu intern gehen koennen.
iptables -A INPUT -s 172.25.0.0/16 -d 172.28.0.0/16 -j ACCEPT
iptables -A OUTPUT -s 172.25.0.0/16 -d 172.28.0.0/16 -j ACCEPT

# jedes antwort-packet von world soll zu intern gehen koennen.

# Alle anderen packete sollen gedroped werden
iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP
