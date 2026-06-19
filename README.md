# terraform-aws-ec2

This repository contains all files for localstack practice with aws and terraform, the detailed is in Notion.so app.

> Reference: KopiCloud in https://github.com/KopiCloud/terraform-aws-debian-ec2-instance

## Requeriments

- Docker
- Localstack
- Awscli
- Terraform

## Configuration Localstack

Start localstack

```sh
docker run -dp 4566:4566 localstack/localstack
```

First need configure your credencials for locastack to dont use the reals and have charges.

```sh
aws configure --profile local
aws configure list-profiles
```

> Complete with fake data.

Use this local configuration (be carefull is only for terminal session)

```sh
export AWS_PROFILE=local
aws configure list
```

Add fake image of ec2 for localstack

```sh
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 register-image \
    --name "debian-13-amd64-local-test" \
    --description "Imagen Fake de Debian para LocalStack" \
    --architecture x86_64 \
    --root-device-name "/dev/xvdb" \
    --virtualization-type hvm \
    --region us-east-1
```

List images of ec2

```sh
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-images \
    --filters "Name=name,Values=debian-13-amd64-local-test" \
    --region us-east-1 \
    --query 'Images[*].{Name:Name, ID:ImageId, Owner:OwnerId, Virtualization:VirtualizationType}'
```

Execute the terraform comands

```sh
cd environments/localstack
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

To get all aws resources created - table view

```sh
# EC2 instances
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-instances \
    --region us-east-1\
    --query "Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,PublicIP:PublicIpAddress,KeyName:KeyName}" \
    --output table

# Security groups
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-security-groups \
    --region us-east-1\
    --query "SecurityGroups[*].{ID:GroupId,Name:GroupName,Description:Description}" \
    --output table

# Elactic IP
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-addresses \
    --region us-east-1\
    --query "Addresses[*].{PublicIP:PublicIp,InstanceID:InstanceId,AllocID:AllocationId}" \
    --output table

# Key-Pairs
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-key-pairs \
    --region us-east-1\
    --query "KeyPairs[*].{Name:KeyName,Fingerprint:KeyFingerprint}" \
    --output table
```

To destroy all

```sh
terraform destroy --auto-approve
```

## Levantar en AWS real

First need ensurance the local profile

```sh
aws configure list
```

Configuramos el profile de produccion

```sh
export AWS_PROFILE=production
```

Execute the terraform comands

```sh
cd /environments/stage
```

```sh
terraform init
terraform plan -out=ec2-setup.binary
terraform apply ec2-setup.binary

```

```sh
chmod 400 "todoapp-stage-linux-us-east-1.pem"
ssh -i "todoapp-stage-linux-us-east-1.pem" admin@<ec2-ip.compute-1.amazonaws.com>
```

Test nginx

```sh
curl localhost:81
```

Entrar mediante http con un navegador

http://54.237.34.108:81

To destroy all

```sh
terraform destroy --auto-approve
```
