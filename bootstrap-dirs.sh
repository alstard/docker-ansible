#!/bin/bash

# If you use set -e here the read commands will stop script execution... so dont use it
set -x
NEW_PROJECT=$1

if [ -z "$NEW_PROJECT" ]; then
    echo "ERROR: new_project variable unset. Specify a new_project name on the command line"
    echo "ERROR: Exiting... "
    exit 1
fi

if [[ "$NEW_PROJECT" != "." ]]; then
    mkdir -p $NEW_PROJECT
    cd $NEW_PROJECT
fi

# Inventories and master playbook
echo "---" > site.yml

# Create a role with all the folders (role is named common)
mkdir -p roles/common/{tasks,handlers,templates,files,vars,defaults,meta}

# Create inventories for different environments
mkdir -p inventories/{production,test,kitchen,ec2hosts}/{group_vars,host_vars}

# Create variables files for the different environments
echo "---" | tee -a ./inventories/{production,test,kitchen,ec2hosts}/{group_vars,host_vars}/all.yml

# 
echo "---" | tee -a roles/common/{tasks,handlers,templates,files,vars,defaults,meta}/main.yml
echo "localhost" | tee -a ./inventories/{production,test,kitchen}/hosts

# Input the ec2hosts into the inventory
read -r -d '' EC2_INVENTORY << EOM
[app]
ip-172-17-0-104.eu-west-2.compute.internal
ip-172-17-0-168.eu-west-2.compute.internal

[db]
ip-172-17-1-197.eu-west-2.compute.internal
ip-172-17-1-63.eu-west-2.compute.internal

[jumpbox]
ec2-35-177-184-21.eu-west-2.compute.amazonaws.com

[aws:children]
app
db
jumpbox
EOM

echo "$EC2_INVENTORY" > ./inventories/ec2hosts/hosts

# Create ansible.cfg with defaults for AWS
read -r -d '' AWS_ANSIBLE_CFG << EOM
[defaults]
inventory = inventories/ec2hosts
remote_user = ec2-user
ansible_ssh_private_key_file = ~/Dropbox/aws-creds/atd-dpe-ew2-keypair.pem
EOM

echo "$AWS_ANSIBLE_CFG" > ansible.cfg
