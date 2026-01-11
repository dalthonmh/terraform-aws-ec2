# terraform-aws-ec2

This repository contains all files for localstack practice with aws and terraform, the detailed is in Notion.so app.

## Requeriments

- Docker
- Localstack
- Awscli
- Terraform

## Configuration

first need configure your credencials for locastack to dont use the reals and have charges.

```sh
aws configure --profile local
aws configure list-profiles
```

> Complete with fake data.

Use this local configuration (be carefull is only for terminal session)

```sh
export AWS_PROFILE=local
```

Add fake image of ec2 for localstack

```sh
aws --endpoint-url=http://localhost:4566 ec2 register-image \
    --name "debian-13-amd64-local-test" \
    --description "Imagen Fake de Debian para LocalStack" \
    --architecture x86_64 \
    --root-device-name "/dev/xvdb" \
    --virtualization-type hvm \
    --region us-east-1
```

List images of ec2

```sh
aws --endpoint-url=http://localhost:4566  ec2 describe-images  \
  --filters "Name=name,Values=debian-13-amd64*" \
  --query 'sort_by(Images, &CreationDate)[].Name' \
  --region us-east-1
```

listar v2

```sh
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-images \
    --filters "Name=name,Values=debian-13-amd64-local-test" \
    --region us-east-1 \
    --query 'Images[*].{Name:Name, ID:ImageId, Owner:OwnerId, Virtualization:VirtualizationType}'
```

Execute the terraform comands

```sh
terraform init
terraform plan -out=tfplan
terraform apply tfplan
terraform destroy --auto-approve
```

To get all aws resources created - table view

- EC2 instances
- Security groups
- Elactic IP
- Key-Pairs

```sh
aws --endpoint-url=http://localhost:4566 ec2 describe-instances \
    --region sa-east-1 \
    --query "Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,PublicIP:PublicIpAddress,KeyName:KeyName}" \
    --output table

aws --endpoint-url=http://localhost:4566 ec2 describe-security-groups \
    --region sa-east-1 \
    --query "SecurityGroups[*].{ID:GroupId,Name:GroupName,Description:Description}" \
    --output table

aws --endpoint-url=http://localhost:4566 ec2 describe-addresses \
    --region sa-east-1 \
    --query "Addresses[*].{PublicIP:PublicIp,InstanceID:InstanceId,AllocID:AllocationId}" \
    --output table

aws --endpoint-url=http://localhost:4566 ec2 describe-key-pairs \
    --region sa-east-1 \
    --query "KeyPairs[*].{Name:KeyName,Fingerprint:KeyFingerprint}" \
    --output table
```

Inline view

```sh
aws --endpoint-url=http://localhost:4566 ec2 describe-instances --region sa-east-1
aws --endpoint-url=http://localhost:4566 ec2 describe-security-groups --region sa-east-1
aws --endpoint-url=http://localhost:4566 ec2 describe-addresses --region sa-east-1
aws --endpoint-url=http://localhost:4566 ec2 describe-key-pairs --region sa-east-1
```

View in one table:

```sh
aws --endpoint-url=http://localhost:4566 ec2 describe-instances --query "Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,PublicIP:PublicIpAddress}" --output table
```
