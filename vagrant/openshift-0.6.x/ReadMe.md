## Fabric8 Vagrant Image

This is the fastest way to get going with Fabric8 and OpenShift on your laptop.

* Download and install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 
* Download and install [Vagrant](http://www.vagrantup.com/downloads.html)
  

Now first clone the [fabric8 installer git repository](https://github.com/fabric8io/fabric8-installer) repository and type these commands:

```
git clone https://github.com/fabric8io/fabric8-installer.git
cd fabric8-installer/vagrant/openshift-0.6.x
vagrant plugin install vagrant-hostmanager
vagrant up
```

Then follow the on screen instructions or try [this detailed getting started guide](http://fabric8.io/guide/getStartedVagrant.html)

Have fun! We [love feedback](http://fabric8.io/community/)

