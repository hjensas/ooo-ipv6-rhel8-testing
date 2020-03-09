#!/bin/bash

source ~/stackrc
cd ~

openstack overcloud deploy \
  --stack-only \
  --templates /usr/share/openstack-tripleo-heat-templates \
  -r ~/overcloud/ipv6_roles_data.yaml \
  -n ~/overcloud/ipv6_network_data.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/enable-swap.yaml \
  -e ~/overcloud/environment/node_data.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/network-environment.yaml \
  -e /usr/share/openstack-tripleo-heat-templates/environments/net-multiple-nics.yaml \
  -e ~/overcloud/environment/network-environment-overrides.yaml

