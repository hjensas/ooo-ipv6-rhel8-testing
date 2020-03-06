#!/bin/bash

set -e

#
# Patch cloud-init in built image
#
cd ~


LIBGUESTFS_BACKEND=direct virt-customize --add ~/images/overcloud-full.qcow2 \
  --upload /opt/local_repo/cloud-init-18.5-5.el8_1.eterrell202003061044.noarch.rpm:/root \
  --selinux-relabel
# LIBGUESTFS_BACKEND=direct virt-customize --add ~/images/overcloud-full.qcow2 \
#   ----run-command "dnf update /root/cloud-init-18.5-11.el8.eterrell202003061040.noarch.rpm" \
#   --selinux-relabel

echo "DONE patching image"

