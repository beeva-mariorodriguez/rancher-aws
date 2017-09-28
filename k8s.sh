#!/bin/bash

clustername=$1
clusterpath=".k8s/$clustername"

if [ ! -f "${clusterpath}/ssh/id_rsa" ]
then
    mkdir -p "${clusterpath}/ssh"
    ssh-keygen -N "" -f "${clusterpath}/ssh/id_rsa"
fi

kops create cluster \
    --name "$clustername.$(terraform output domain_name)" \
    --zones "eu-west-2a,eu-west-2b" \
    --image "ami-cfb8acab" \
    --node-size "t2.medium" \
    --dns-zone "$(terraform output dns_zone_id)" \
    --networking flannel \
    --vpc "$(terraform output vpc_id)" \
    --node-count 3 \
    --cloud aws \
    --api-loadbalancer-type public \
    --topology private \
    --ssh-public-key "${clusterpath}/ssh/id_rsa.pub" \
    --dns private

