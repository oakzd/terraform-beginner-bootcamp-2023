# Terraform Beginner Bootcamp 2023 week 1

## Root Module Structure

Our root module structure is as follows:


```
- PROJECT_ROOT
  |--- main.tf = everything else.
  |--- variables.tf = stores the structure of input variables.
  |--- terraform.tfvars = the data of variables we want to load into our terraform project
  |--- providers.tf = defined required providers and their configuration.
  |--- outputs.tf = stores our outputs
  |--- README.md = required for root modules
```

 [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables
In terraform we can set two kind of variables
- Envoirnment variables - those you would set in your bash terminal
  - eg. AWS creds
- Terraform variables - those you would set in your tfvars file
  - eg. user_uuid

We can set Terraform Cloud variables to be sensitive so they are not shown visibily in the UI

### Loading Terraform Input Variables
[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `- var ` flag to set an input variable or override a variable in the tfvars file 
  - eg `terraform apply -var user_ud="user_id "`
  
### var-file flag
We can use the `- var-file ` flag to set mulitple variables into a  tfvars file 
  - eg `terraform apply -var-file="test.tfvars" "`

### terraform.tfvars

This file is the default way to load variabels

### auto.tfvars
If this file is present then terraform will automatically load the variables

### order of terraform variables
Terraform will load files in this order. If variable is written multiple times then it will take the last value it sees

1. terraform.tfvars
2. terraform.tfvars.json
3. *.auto.tfvars or *.auto.tfvars.json
4. -var and -var-file
