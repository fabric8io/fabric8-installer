## Fabric8 Kubernetes Vagrant Image : DEPRECATED!

<img src="https://cdn.rawgit.com/fabric8io/fabric8-installer/master/img/warning.png" alt="WARNING"
     width="25" height="25">
<img src="https://cdn.rawgit.com/fabric8io/fabric8-installer/master/img/warning.png" alt="WARNING"
     width="25" height="25">
<img src="https://cdn.rawgit.com/fabric8io/fabric8-installer/master/img/warning.png" alt="WARNING"
     width="25" height="25">
<img src="https://cdn.rawgit.com/fabric8io/fabric8-installer/master/img/warning.png" alt="WARNING"
     width="25" height="25">
<img src="https://cdn.rawgit.com/fabric8io/fabric8-installer/master/img/warning.png" alt="WARNING"
     width="25" height="25">

<h2>PLEASE NOTE: This repository is being deprecated and will not be maintained beyond October 2016</h2>

For the best local developer experience on Kubernetes and OpenShift fabric8 recommends minikube and minishift
 - [minikube](https://github.com/kubernetes/minikube)
 - [minishift](https://github.com/jimmidyson/minishift)
 - [fabric8 getting started guide](http://fabric8.io/guide/getStarted/index.html#don-t-have-a-kubernetes-cluster-yet)

---

If you wish to run fabric8 locally we highly recommend using [minikube](http://fabric8.io/guide/getStarted/minikube.html) now! This offers the chance to use native platform hypervisors (Hyper-V on Windows, Xhyve on Mac OS X or KVM on Linux) which are much snapper and use lots less memory on your laptops!


### if you still wanna use it...

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
