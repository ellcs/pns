#!/bin/bash
#
# f8bb0972b716	mantel_server1		10.100.1.3
# 90599f0e3ddd	mantel_server3		10.100.1.4
# a01efd6f1bd9	mantel_server2		10.100.1.2
# 1f843d58a334	mantel_backend1		10.100.2.2
# 890bca43f496	mantel_backend2		10.100.2.3
# 5a3c1d025952	mantel_backend3		10.100.2.4
# 71fb71bb3d58	mantel_world1			10.100.0.2
# 3c0ac63fd804	mantel_world2			10.100.0.4
# a34f0c4944a7	mantel_client1		10.100.3.3
# 2c5e84370d88	mantel_client3		10.100.3.2
# cc623f1fe1fa	mantel_fwworld		10.100.0.3
# fb9d2643f3f1	mantel_fwintern		10.100.2.5

# First arg has to be $FILE you want to copy
for c in $(cat container_list.txt); do
  docker exec -it $c /bin/bash -c "$1"
done

echo $hosts
