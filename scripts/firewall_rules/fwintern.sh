# fwintern
# jedes ausgehende packet von world wird akzeptiert.
# nur verbindungen welche
# jedes packet von intern soll zu server gehen koennen.
# jedes packet von intern soll zu  world gehen koennen.
# Umgesetzt als: jedes packet von intern, darf ueberall hin.

export client="172.28.0.0/16"
export world="172.27.0.0/16"
export backend="172.26.0.0/16"
export server="172.25.0.0/16"

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# intern
# jedes ausgehende packet ist okay.
iptables -A FORWARD -s $client -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# jedes antwort-packet soll zu intern gehen koennen.
iptables -A FORWARD -d $client -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# backend
# jedes ausgehende packet ist okay.
iptables -A FORWARD -s $backend -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# jedes antwort-packet soll zu backend gehen koennen.
iptables -A FORWARD -s $server -d $backend -j ACCEPT
iptables -A FORWARD -s $client -d $backend -j ACCEPT
iptables -A FORWARD -d $backend -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP
