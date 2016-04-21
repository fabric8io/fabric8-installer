## Fabric8 Kubernetes Vagrant Image

**NOTE** right now to install this vagrant file you need to download a tarball of Kubernetes and unpack it to a local `kubernetes` folder in this directory!

```
curl -L https://github.com/kubernetes/kubernetes/releases/download/v1.3.0-alpha.2/kubernetes.tar.gz | tar xzv
```

This is the fastest way to get going with Fabric8 and Kubernetes on your laptop.

### Download and Install

* Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* Download and install [Vagrant](http://www.vagrantup.com/downloads.html)

First clone the [fabric8 installer git repository](https://github.com/fabric8io/fabric8-installer) repository and type these commands:

```
git clone https://github.com/fabric8io/fabric8-installer.git
cd fabric8-installer/vagrant/kubernetes
```

### Prepare Vargant

The next steps are specific for different operating systems. They are needed to allow easy access to
dynamically generated OpenShift routes. These steps are needed only once.

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

```
vagrant plugin install landrush
```

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

### Follow on screen instructions

Then follow the on screen instructions or try [this detailed getting started guide](http://fabric8.io/guide/getStartedVagrant.html)

Have fun! We [love feedback](http://fabric8.io/community/)
