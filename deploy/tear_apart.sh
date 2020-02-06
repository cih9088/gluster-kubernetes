#!/usr/bin/env bash

# delete
./gk-deploy -g --admin-key admin --user-key user --namespace glusterfs -vy --abort

# delete namespace
kubectl delete namespace glusterfs


cat <<'EOF'
#######################################################################
##   Execute following commands in each kubernetes node to tidy up   ##
#######################################################################

# devices in your topology.jso
# here we use /dev/sdb for example
TOPOLOGY_DEVICE=/dev/sdb

# check if lv, vg, pv is set for ${TOPOLOGY_DEVICE}
lvdisplay
vgdisplay
pvdisplay

# if then remove it
lvremove
vgremove
pvremove

# remove directories
rm -rf /var/lib/heketi /etc/glusterfs /var/lib/glusterd /var/log/glusterfs

# wipe device
wipefs -af ${TOPOLOGY_DEVICE}

# check if gluster volumes are deleted
fdisk -l

# if device mapper stil exists
dmsetup remove_all

# check again
dmsetup ls
fdisk -l
EOF
