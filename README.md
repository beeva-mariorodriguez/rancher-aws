# rancher-aws

deploy rancher on AWS using terraform

## instructions
```sh
terraform apply -target aws_instance.rancher_server
```
tunnel ssh to rancher server
```sh
ssh -D 12345 -L 8080:127.0.0.1:8080 rancher@1.2.3.4
```
register IP using web interface
* change rancher register IP
* generate API keys
```sh
export TF_VAR_rancher_access_key="..."
export TF_VAR_rancher_secret_key="..."
terraform apply
```

