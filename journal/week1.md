# Terraform Beginner Bootcamp 2023 week 1

## Root Module Structure

[fixing tags - delete](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

locally delete a tag
```sh
$ git tag -d <tag_name>

```

Remotely delete tag
```sh
$ git push -delete origin tagname
```

Checkout the commit you want to retag. Grab the sha from your Github history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```

## Root Module Structure

Our root module structure is as follows:


```sh
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


## Dealing with Configuration Drift


### What happens if you loose your statefile

If this happens then you most likely have to tean down all cloud infrastructure manually.

You can try terraform import but it wont work for all cloud resources. Please check documentation.

### Fix Missing Resources with Terraform import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)
### Fix Manual Configuration

If their is configuration drift, meaning that someone outside of terraform tries to do "anything" like delete a resources. Then terraform will attempt to "bring" it back.

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure
It is recomended to place modules in a 'module' directory when locally deveolpling modules but you can name it anything.

### Passing Input Variables

We can pass input variables to our module.
The module has to declare the terraform variables in its own variables.tf
```tf
module "terrahouse_aws" {
  user_uuid = var.user_uuid
  bucket_name= var.bucket_name
}
```
### Modules Sources

Using the source we can import the module from varius places eg
-locally
-Github
-Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```
[Terraform Modules](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using chatGPT to write Terraform

LLMs like chatGPT are not up to date and may produce incorrect or deprecatied information.

## Working with Files in Terraform

### Working with Files in Terraform

This is a built in function in terraform that checks if the file exists

```tf
condition = fileexists(var.error_html_filepath)
```
[File exists function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

[Filemd5 function](https://developer.hashicorp.com/terraform/language/functions/filemd5)

In Terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module
- path.root = get the path for the root module
[Special path variables](https://developer.hashicorp.com/terraform/language/expressions/references)


resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
}

## Terraform Locals
Locals allows us to define local variables.
Its useful when we need to transform data into another format and have it refernced as a variable
```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
### Terraform Data Sources

This allows us to source data from cloud resources.

This is useful when we want to refernce cloud resources without importing them.
[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

## Working with JSON

We used the jsonencode to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

```tf
[jsconencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

```

### Changing the lifecycle of resources

[Meta Arguments Lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values like Local Values and Input Variables dont have side effects to plan against. You can use terraform_data's behavoiur to trigger a replacement.


[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/resources/terraform-data)