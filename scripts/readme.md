Copy `routes.sh` on all server:

```
for ip in $(cat ip_list.txt); do scp routes.sh "root@$ip:"; done
```

Make it executable on all servers:

```
for ip in $(cat ip_list.txt); do scp routes.sh "root@$ip:"; done
```
