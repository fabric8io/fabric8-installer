## NOTE
These ansilble scripts and docs are modified from their original form in the [Kubernetes contrib project](https://github.com/kubernetes/contrib/tree/master/ansible/vagrant)

## Vagrant deployer for Kubernetes Ansible

This deployer installs Kubernetes based platforms from Red Hat such as OpenShift Enterprise and Atomic Enterprise Platform

## Before you start !

You will need a functioning vagrant openstack provider.

## USAGE

In general all that should be needed it to run

```
vagrant up --provider=openstack
```
Currently only a single openstack instance is supported which hosts both kubernetes master and kubernetes node

### OpenStack
Make sure to install the openstack provider for vagrant.
```
vagrant plugin install vagrant-openstack-provider --plugin-version ">= 0.6.1"
```
NOTE This is a more up-to-date provider than the similar  `vagrant-openstack-plugin`.

Also note that current (required) versions of `vagrant-openstack-provider` are not compatible with ruby 2.2.
https://github.com/ggiamarchi/vagrant-openstack-provider/pull/237
So make sure you get at least version 0.6.1.

To use the vagrant openstack provider you will need
- Copy `openstack_config.yml.example` to `openstack_config.yml`
- Edit `openstack_config.yml` to include your relevant details.

For vagrant (1.7.2) does not seem to ever want to pick openstack as the provider. So you will need to tell it to use openstack explicitly.
