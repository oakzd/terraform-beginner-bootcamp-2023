# Terraform Beginner Bootcamp 2023!

## Semantic Versioning

This project is going to utilize semantic versioning for its its tagging.
[semver.org](https://semver.org/)

The general format:

 **MAJOR.MINOR.PATCH** , eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the terraform CLI

### Considerations with the terraform CLU changes
The terraform CLI installation insctructions have changed due to gpg keyring changes. So we needed refer to the lastest install cli instructions via Terraform Docs and change the scripting for install.

[Terraform CLI Install](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for linux distribution

This project is built against Ubuntu.
Please consider checking your Linux distro and change accordingly to distribution needs.
[How to check linux OS version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version
```sh
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts
While fixing the Terraform CLI gpg depreciation issues we noticed that bash scripts steps were a considerable amount of more code. We decided to create a bash script to install the terraform CLI

This bash script is located here: [./bin/install_terraform_cli.sh](./bin/install_terraform_cli.sh)
- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang considerations
A Shebang (pronounced sha-bang) tells the bash script what program that will intepret the script. eg. `#!/bin/bash`

ChatGPT recommened to use `#!/usr/bin/env bash`
- for portability for differnt OS distributions
- will search the user PATH for the bash executable

[shebang guide](https://bash.cyberciti.biz/guide/Shebang)

## Execution considerations
When executing the bash script we can use the `./` shorthand notation to execute the bash script.

eg. `./bin/install_terraform_cli`

if we are using a script in .gitpod.yml we need to point the script to a program to interpet it
eg `source ./bin/install_terraform_cli`

#### Linux permissions considerations

You need to change permissions on bash scripts to make them executable

```sh
chmod u+x ./bin/install_terraform_cli
```
alternatively
```sh
chmod 744 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod


### Github Lifecycle Before, Init, Command
We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

### Working Env Vars

We can list out all Enviroment variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

In the terminal we can set using `export HELLO='world'`
In the terminal we can unset using `unset HELLO`

We can set an env var temporaily when using a comand

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without export eg.

```sh
#!/usr/bin/env bash
HELLO='world' 

echo $HELLO
```

#### Printing Vars

We can print an env var using echo eg `echo $HELLO`

#### Scoping of Env Vars
When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to have Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile eg. `.bash_profile`


#### persisting Env Vars in Gitpod
We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```sh
gp env HELLO='world'

```

All future workspaces launched will set the env vars for all bash terminals opened in thoses workspaces

You can also set env vars in the `gitpod.yml` but this can only contain non-sensitive env vars.


### AWS CLI Installation

AWS CLI is installed for the project via the bash scrip [`./bin/install_aws_cli.sh`](./bin/install_aws_cli.sh)

[Getting Started(AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
We can check our AWS credentials is configured properly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

```json
{
    "UserId": "QDSWVZ7e4DVA7ZDa2dIOD",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```
We'll need to generate AWS CLI credits from IAM User to the user AWS CLI 


## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which is located at [registry.terraform.io](https://registry.terraform.io)

- **Providers** is an interface to Cloud APIs that will allow to create resources in terraform.

- **Modules** are premade templates that anyone can use to make life easier

[Random Terraform provider](https://registry.terraform.io/providers/hashicorp/random/latest)

### Terraform Console

We can see a list of all the terraform commands by typing
`terraform`

#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project


#### Terraform Plan

`terraform plan`
This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. 'plan' to be passed to an apply, but often you can just ignore outputting

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be executed by terraform.

Automatically approve by doing the following

`terraform apply --auto-approve`

#### Terraform Destroy

This will destroy your resources that you spun up

`terraform destroy --auto-approve`


#### s3 Bucket Naming rules
We ran into an issue were we have uppercase letters. To allow only lowercase and not uppcase apply the `uppcase = false` option

#### Terraform Lock Files

`terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used for the entire project.

Please **commit** this to your VSC (Github).

#### Terraform State Files

`terraform.tfstate` contains senstive information about the current state of your infrastructure. Do **NOT** commit this file!

`terraform.tfstate.backup` contains the previous file state.

##@# Terraform Directory

`terraform` directory contains binaries of terraform providers.

## Issues with Terraform Cloud login and Gitpod Workspace

When attempting `terraform login` it is very diffcult to complete the steps. Instead follow the steps below.


1. Generate your token!
[Token!](https://app.terraform.io/app/settings/tokens?source=terraform-login)

2. Then create the file manually

```sh
/home/gitpod/.terraform.d/credentials.tfrc.json

```

3. open file and enter your generated token

```json
{
"credential": {
    "app.terraform.io": {
        "token": "Your terraform -cloud-token-here"
    }
  }
}
```
We automated this task with the following bash script. 
[bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)
