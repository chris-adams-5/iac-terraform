terraform
```
terraform init -backend-config="./state.config"
```

aws
```
aws configure list  

aws configure --profile=terraform-user list
```

aws s3api
```
aws s3api create-bucket --bucket chris-s3-tf-state-2 --create-bucket-configuration LocationConstraint=eu-west-2 --profile terraform-user

aws s3api put-bucket-versioning --bucket chris-s3-tf-state --versioning-configuration Status=Enabled
```