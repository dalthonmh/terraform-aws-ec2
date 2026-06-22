# terraform-aws-ec2

This repository contains all files for practicing LocalStack with AWS and Terraform. The detailed documentation is in the Notion.so app.

> Reference: KopiCloud at https://github.com/KopiCloud/terraform-aws-debian-ec2-instance

## Requirements

- Docker
- LocalStack
- AWS CLI
- Terraform

## LocalStack Configuration

Start LocalStack:

```sh
docker run -dp 4566:4566 localstack/localstack
```

First, configure your credentials for LocalStack to avoid using real credentials and incurring charges.

```sh
aws configure --profile local
aws configure list-profiles
```

> Complete with fake data.

Use this local configuration (be careful, it only affects the current terminal session):

```sh
export AWS_PROFILE=local
aws configure list
```

Add a fake EC2 image for LocalStack:

```sh
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 register-image \
    --name "debian-13-amd64-local-test" \
    --description "Fake Debian image for LocalStack" \
    --architecture x86_64 \
    --root-device-name "/dev/xvdb" \
    --virtualization-type hvm \
    --region us-east-1
```

List EC2 images:

```sh
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-images \
    --filters "Name=name,Values=debian-13-amd64-local-test" \
    --region us-east-1 \
    --query 'Images[*].{Name:Name, ID:ImageId, Owner:OwnerId, Virtualization:VirtualizationType}'
```

Execute the Terraform commands:

```sh
cd environments/localstack
terraform init
terraform plan -out=tfplan
terraform apply tfplan
```

To view all created AWS resources (table view):

```sh
# EC2 instances
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-instances \
    --region us-east-1 \
    --query "Reservations[*].Instances[*].{ID:InstanceId,State:State.Name,PublicIP:PublicIpAddress,KeyName:KeyName}" \
    --output table

# Security groups
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-security-groups \
    --region us-east-1 \
    --query "SecurityGroups[*].{ID:GroupId,Name:GroupName,Description:Description}" \
    --output table

# Elastic IPs
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-addresses \
    --region us-east-1 \
    --query "Addresses[*].{PublicIP:PublicIp,InstanceID:InstanceId,AllocID:AllocationId}" \
    --output table

# Key Pairs
aws --endpoint-url=http://localhost.localstack.cloud:4566 ec2 describe-key-pairs \
    --region us-east-1 \
    --query "KeyPairs[*].{Name:KeyName,Fingerprint:KeyFingerprint}" \
    --output table
```

To destroy all resources:

```sh
terraform destroy --auto-approve
```

## Deploy to real AWS

First, ensure the local profile is active:

```sh
aws configure list
```

Configure the production profile:

```sh
export AWS_PROFILE=production
```

Execute the Terraform commands:

```sh
cd environments/stage
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

Test nginx:

```sh
curl localhost:81
```

Access via HTTP using a browser:

http://54.237.34.108:81

To destroy all resources:

```sh
terraform destroy --auto-approve
```
