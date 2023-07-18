# Simple NFS Server and Client with Docker

The `setup.sh` script deploys an NFS server and an NFS client. This repository was done purely to learning/test some NFS features - both containers run in priviledged mode, which is a known 'no-no' security-wise.

Run the setup to create an NFS Server and NFS Client containers, and setup a shared folder:
```bash
./setup.sh
```

Log into an interactive console (sh) in each container:
```bash
docker exec -it nfs.server sh

# inside nfs.server:
ls /nfs-storage
touch /nfs-storage/test123
exit

docker exec -it nfs.client sh

# inside nfs.client:
ls /nfs-storage
# (verify test123 is there)
```

Teardown the environment (might retry killing the containers a couple of times):
```bash
./teardown.sh
```