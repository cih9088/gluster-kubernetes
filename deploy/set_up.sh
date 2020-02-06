#!/usr/bin/env bash

# create namespace
kubectl create namespace glusterfs

# deploy gluster-kubernetes
./deploy/gk-deploy -g --admin-key admin --user-key user --namespace glusterfs -vy
