#! /usr/bin/bash

PLUGIN_DIR="~/.terraform.d/plugins/local.providers/local/terratowns/1.0.0"
PLUGIN_NAME="terratowns-provider-terratowns_v1.0.0"
# https://servian.dev/terraform-local-providers-and-registry-mirror-configuration-b963117dfffa
cd $PROJECT_ROOT/terratowns-provider-terratowns
cd $PROJECT_ROOT/terraformrc/home/gitpod/.terraformrc
rm -rf ~/.terraform.d/plugins
rm -rf $PROJECT_ROOT/.terraform
rm -rf $PROJECT_ROOT/.terraform.lock.hcl
go build -o $PLUGIN_NAME
mkdir -p $PLUGIN_DIR/x86_64/
mkdir -p $PLUGIN_DIR/linux_amd64/
cp $PLUGIN_NAME $PLUGIN_DIR/x86_64
cp $PLUGIN_NAME $PLUGIN_DIR/x86_64/linux_amd64