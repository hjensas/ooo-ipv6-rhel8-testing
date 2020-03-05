#!/bin/bash

set -e

#
# Patch cloud-init in built image
#
cd /home/centos

git clone -b bug/1806014 https://github.com/hjensas/cloud-init.git

LIBGUESTFS_BACKEND=direct virt-customize --add /home/centos/images/overcloud-full.qcow2 \
  --delete /usr/lib/python2.7/site-packages/cloudinit \
  --selinux-relabel
LIBGUESTFS_BACKEND=direct virt-customize --add /home/centos/images/overcloud-full.qcow2 \
  --copy-in /home/centos/cloud-init/cloudinit:/usr/lib/python2.7/site-packages/ \
  --selinux-relabel
LIBGUESTFS_BACKEND=direct virt-customize --add /home/centos/images/overcloud-full.qcow2 \
  --delete /usr/lib/python2.7/site-packages/cloudinit/tests \
  --selinux-relabel

echo "DONE patching image"

