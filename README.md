# Testing Ansible in Docker Containers - Run it against AWS

## Introduction

Playbooks to work through some examples of Ansible. These will be tested in Kitchen inside of Docker containers and then executed against AWS instances (mostly in private subnets)

## Further work - TODO

| Item | Description          |
|------|----------------------|
| 1    | Use Ansible Container|cd -
| 2    | KOPS|
| 3    | Jenkinsy things|


## Useful Links

* https://spin.atomicobject.com/2016/05/16/ansible-aws-ec2-vpc/

## Useful commands for AWS (esp. Jump Hosts)

* `ssh -t`  
  e.g. `ssh -t ec2-user@ec2-35-177-176-239.eu-west-2.compute.amazonaws.com 'ssh ec2-user@ip-172-17-1-197.eu-west-2.compute.internal'`

* ANOTHER