# Set up Computers
This document sets up computers so that they have all the necessary bits installed

## Pre Set Up
Ansible will require that you already have the ability to ssh into the target computers (listed in `inventory`).
You need to first prepare the node with https://github.com/marcstreeter/kubewhistle/blob/master/README.node.md

## Ansible
With Ansible we can provision the servers but we must first install it
```
pip install ansible
```

It's installation can be tested with
```
ansible --version
```

It's ability to connect with the computers can be tested with
```
# ansible -i <path-to-inventory-file> cluster -m ping -u <ssh_username>
# or the below given `ansible.cfg` has those details already set up
ansible cluster -m ping
# or you can run a random command on all the servers (ie checking free memory)
ansible cluster -a "free --mebi"
```
## 