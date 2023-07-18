#!/bin/bash

# START A DOCKER VPC:

docker network create nfs-network

# CREATE A DIRECTORY TO BE SHARED THROUGH NFS:

mkdir nfs-storage

# CREATE AN NFS SERVER CONTAINER:

docker run \
    --name=nfs.server \
    -itd \
    --privileged=true \
    --net=nfs-network \
    -v ./nfs-storage:/nfs-storage \
    -e NFS_EXPORT_0='/nfs-storage *(rw,no_subtree_check)' \
    -p '2049:2049' \
    erichough/nfs-server

# CREATE AN NFS CLIENT CONTAINER:

docker run \
    --name=nfs.client \
    -itd \
    --privileged=true \
    --net=nfs-network \
    -e SERVER=nfs.server \
    -e MOUNTPOINT=/mnt/nfs-1 \
    -e SHARE=/nfs-storage \
    d3fk/nfs-client

# MOUNT THE NFS VOLUME IN THE NFS CLIENT:

sleep 10
docker exec -it nfs.client /bin/sh -c 'mkdir $SHARE && mount $MOUNTPOINT $SHARE' 

