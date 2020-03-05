#!/bin/bash

source /home/centos/stackrc
cd /home/centos

openstack overcloud deploy \
  --stack-only \
  --templates /home/centos/tripleo-heat-templates \
  -r /home/centos/overcloud/ipv6_roles_data.yaml \
  -n /home/centos/overcloud/ipv6_network_data.yaml \
  -e /home/centos/tripleo-heat-templates/environments/enable-swap.yaml \
  -e /home/centos/overcloud/environment/node_data.yaml \
  -e /home/centos/tripleo-heat-templates/environments/network-isolation.yaml \
  -e /home/centos/tripleo-heat-templates/environments/network-environment.yaml \
  -e /home/centos/tripleo-heat-templates/environments/net-multiple-nics.yaml \
  -e /home/centos/overcloud/environment/network-environment-overrides.yaml 
