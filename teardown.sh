#!/bin/bash

# TEAR DOWN NFS SERVER CONTAINER:

docker kill nfs.server
until [ $? -eq 0 ]; do
    echo "Retriying..."
    docker kill nfs.server 
done

docker rm nfs.server

# TEAR DOWN NFS CLIENT CONTAINER:

docker kill nfs.client
until [ $? -eq 0 ]; do
    echo "Retriying..."
    docker kill nfs.client
done

docker rm nfs.client

# TEAR DOWN DOCKER VPC:

docker network rm nfs-network

# DELETE DIRECTORY THAT HAS BEEN CREATED TO BE SHARED THROUGH NFS:

rm -rvf ./nfs-storage