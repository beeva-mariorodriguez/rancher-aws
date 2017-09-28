# rancher-aws

deploy rancher on AWS using terraform

## instructions
### rancher server
```sh
terraform apply
```
tunnel ssh to rancher server
```sh
ssh -D 12345 -L 8080:server.rancher.cluster:8080 rancher@${BASTION_IP}
```
### kubernetes
```bash
./k8s.sh clustername
kops edit cluster clustername.$(terraform output domain_name)
# change subnets to avoid conflicts with subnets declared in terraform
kops update cluster clustername.$(terraform output domain_name)
kops update cluster clustername.$(terraform output domain_name) --yes
```

