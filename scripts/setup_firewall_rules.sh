
#!/bin/bash
#
#  mantel_server1	f8bb0972b716		10.100.1.3
#  mantel_server2	a01efd6f1bd9		10.100.1.2
#  mantel_server3	90599f0e3ddd		10.100.1.4
#  mantel_backend1	1f843d58a334		10.100.2.2
#  mantel_backend2	890bca43f496		10.100.2.3
#  mantel_backend3	5a3c1d025952		10.100.2.4
#  mantel_world1	71fb71bb3d58		10.100.0.2
#  mantel_world2	3c0ac63fd804		10.100.0.4
#  mantel_client1	a34f0c4944a7		10.100.3.3
#  mantel_client3	2c5e84370d88		10.100.3.2
#  mantel_fwintern	fb9d2643f3f1		10.100.2.5
#  mantel_fwworld	cc623f1fe1fa		10.100.0.3

# SERVER
docker exec -it mantel_server1_1 /bin/bash -c "chmod +x root/server1.sh"  
docker exec -it mantel_server2_1 /bin/bash -c "chmod +x root/server2.sh" 
docker exec -it mantel_server3_1 /bin/bash -c "chmod +x root/server3.sh" 

docker exec -it mantel_server1_1 /bin/bash -c "root/server1.sh"  
docker exec -it mantel_server2_1 /bin/bash -c "root/server2.sh" 
docker exec -it mantel_server3_1 /bin/bash -c "root/server3.sh" 

# FWINTERN
docker exec -it mantel_fwintern_1 /bin/bash -c "chmod +x root/fwintern.sh"
docker exec -it mantel_fwintern_1 /bin/bash -c "root/fwintern.sh"

# FWWORLD
docker exec -it mantel_fwworld_1 /bin/bash -c "chmod +x root/fwworld.sh"
docker exec -it mantel_fwworld_1 /bin/bash -c "root/fwworld.sh"
