#!/bin/bash

set -e

USER_HOME=/home/cloud-user

#
# Patch cloud-init in image
#
LIBGUESTFS_BACKEND=direct virt-customize --add $USER_HOME/images/overcloud-full.qcow2 \
  --upload /opt/local_repo/cloud-init-18.5-11.el8.eterrell202003061040.noarch.rpm:/root \
  --selinux-relabel
# LIBGUESTFS_BACKEND=direct virt-customize --add $USER_HOME/images/overcloud-full.qcow2 \
#   ----run-command "dnf update /root/cloud-init-18.5-11.el8.eterrell202003061040.noarch.rpm" \
#   --selinux-relabel

echo "DONE patching image"

