## Fabric8 OpenShift Vagrant Image

This is the fastest way to get going with Fabric8 and OpenShift on your laptop.

This Vagrant image uses the [gofabric8](https://github.com/fabric8io/gofabric8) installer to install and configure Fabric8 on a vanilla OpenShift.

### Download and Install

* Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Download and install [Vagrant](http://www.vagrantup.com/downloads.html)

First clone the [fabric8 installer git repository](https://github.com/fabric8io/fabric8-installer) repository and type these commands:

```
git clone https://github.com/fabric8io/fabric8-installer.git
cd fabric8-installer/vagrant/openshift
```

### Prepare Vagrant

The next steps are specific for different operating systems. They are needed to allow easy access to
dynamically generated OpenShift routes. These steps are needed only once.

Some additional vagrant plugins are required to provide additional features like :
* Plugin [landrush](https://github.com/phinze/landrush) : provides a simple dns server for vagrant guests
* Plugin [host-manager](https://github.com/smdahlen/vagrant-hostmanager) : manages the /etc/hosts file on guests within a multi-machine environment

#### Linux

* Install the Vagrant plugin `landrush`

````
vagrant plugin install landrush
````

* Install `dnsmasq` so that all requests to `*.vagrant.f8` get resolved to the Vagrant VM's IP.

* Add a line `server=/vagrant.f8/127.0.0.1#10053` to the `dnsmasq` configuration.

For Ubuntu this looks like:

````
sudo apt-get install -y resolvconf dnsmasq
sudo sh -c 'echo "server=/vagrant.f8/127.0.0.1#10053" > /etc/dnsmasq.d/vagrant-landrush'
sudo service dnsmasq restart
````

These steps need to be performed only once. From now on, any new application route in OpenShift is visible on the host
as well.

#### OS X

* Install the Vagrant plugin `landrush`

````
vagrant plugin install landrush
````

That's it. OS X will automatically resolve now all routes to `*.vagrant.f8` your Vagrant VM. This is done vial OS X's resolver feature
(see `man 5 resolver` for details)

#### Windows

* Install Vagrant plugin `vagrant-hostmanager`

````
vagrant plugin install vagrant-hostmanager
````

There are some predefined routes which are automatically added to `%WINDIR%\System32\drivers\etc\hosts`. However if you
add a new route e.g. by installing a new application from the fabric8 console, then you must adapt the hosts file manually
for now for each new application so that it is reachable from this host.

### Start Vagrant

Now startup vagrant with

```
vagrant up
```

### Debug tips

`vagrant up` script, among other things, mounts some folder of the vms into your host file system.  
It does that via `NFS`.  
`NFS` might report errors similar to the following if it cannot connect to the vm:
```
==> default: Mounting NFS shared folders...
The following SSH command responded with a non-zero exit status.
Vagrant assumes that this means the command failed!

mount -o 'vers=3,udp' 192.168.121.1:'/500GB/fabric8v2/code/fabric8-installer/vagrant/openshift' /vagrant

Stdout from the command:

Stderr from the command:

mount.nfs: Connection timed out
```
A way to solve this problem is to configure your **host** firewall to allow the communication.  
```
sudo firewall-cmd --permanent --add-service=nfs &&
>   sudo firewall-cmd --permanent --add-service=rpc-bind &&
>   sudo firewall-cmd --permanent --add-service=mountd &&
>   sudo firewall-cmd --reload
```
Note: completely disabling `firewalld` service (and implicitely some useful `iptables` rule) might prevent the vm to be able to access the internet correctly.

### Follow on screen instructions

Then follow the on screen instructions or try [this detailed getting started guide](http://fabric8.io/guide/getStartedVagrant.html)

Have fun! We [love feedback](http://fabric8.io/community/)
