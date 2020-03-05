# Deploy ovb lab
./bin/deploy.py \
	--env env-ipv6-lab.yaml \
	--quintupleo \
	--env environments/all-networks.yaml \
	--env env-ipv6.yaml --poll


# Build nodes json
./bin/build-nodes-json \
	--env env-routed-lab.yaml \
	--physical_network

OVB_UNDERCLOUD=$(openstack stack show quintupleo -f json -c outputs | jq '.outputs[0].output_value' | sed s/'"'//g)
OVB_UNDERCLOUD_PUBLIC=$(openstack server show undercloud -f json -c addresses | jq '.addresses' | sed s/.*public=// | sed s/\;.*// | sed s/'"'//g)
cat << EOF > inventory.ini
[undercloud]
$OVB_UNDERCLOUD ansible_user=cloud-user ansible_ssh_extra_args='-o StrictHostKeyChecking=no' undercloud_public_ip=$OVB_UNDERCLOUD_PUBLIC
[undercloud:vars]
pool_id=8a85f98c60c2c2b40160c324e5d21d70
EOF

ansible-playbook -i inventory.ini ../ooo-ipv6-rhel8-testing/playbooks/ssh_hardening.yaml

scp -o StrictHostKeyChecking=no nodes.json cloud-user@$OVB_UNDERCLOUD:~/instackenv.json

DEPLOY_UNDERCLOUD="ansible-playbook -i inventory.ini ../ooo-ipv6-rhel8-testing/playbooks/deploy_undercloud.yaml"
DEPLOY_OVERCLOUD="Log into undercloud ($OVB_UNDERCLOUD) and run command: bash ~/overcloud/deploy_overcloud.sh"
echo "###############################################"
echo -e "Undercloud floating IP:\n\t$OVB_UNDERCLOUD"
echo -e "Deploy undercloud:\n\t$DEPLOY_UNDERCLOUD"
echo -e "Deploy overcloud:\n\t$DEPLOY_OVERCLOUD"
echo "###############################################"

