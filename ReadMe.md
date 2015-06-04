## Fabric8 Installer

This is an installer project for installing the [Fabric8 Apps](http://fabric8.io/guide/apps.html) on Kubernetes or OpenShift.

To use this project you need to install a recent distribution of [Apache Maven](http://maven.apache.org/)

### How to install a main app

To install one of the [main apps](http://fabric8.io/guide/fabric8Apps.html) in fabric8:

* clone the respository and cd into the directory for the _app groups_ you wish to install. e.g.

```
    git clone https://github.com/fabric8io/fabric8-installer.git
    cd fabric8-installer
```
    
* now run `mvn install` specifying the domain and overriding any other properties you need

You also need to specify a **domain** to install it on; such as `vagrant.local`.

You can specify the domain via a command line argument

```
    mvn install -Ddomain=vagrant.local
```
  
Or via the $KUBERNETES_DOMAIN environment variable:

```
    export KUBERNETES_DOMAIN=vagrant.local
    mvn install
```  

### Installing individual micro services

The above supports the [main apps](http://fabric8.io/guide/fabric8Apps.html) in fabric8 but there are a [number of individual microservices](https://github.com/fabric8io/quickstarts/tree/master/apps) you can install individually.
 
For those use the `app` folder and specify the `artifactId` property:
 
```
    git clone https://github.com/fabric8io/fabric8-installer.git
    cd fabric8-installer
    cd app
    mvn install -DartifactId=jenkins
```

Or to install a specific version of an app:

```
    mvn install -DartifactId=jenkins -Dfabric8.version=2.1.6
```
 
### Using different versions

If you wish to change the fabric8 version you wish to install, just edit the pom.xml for the `fabric8.version` or you can just supply it on the command line:

    mvn install -Dfabric8.version=2.1.6

If you wish to try the latest/greatest snapshot builds of fabric8 and the apps you can use this profile:

    mvn install -Pfabric8-snapshot

### Other options

Add the `recreate` property if you wish to force recreation of kubernetes resources:

    mvn install -Drecreate=true

If ommitted then resources are updated if they already exist.

### Apps

The following apps are available:

* [Base](base) provides the [Console](http://fabric8.io/guide/console.html) with the [App Library](appLibrary.html) 
* [Management](management) adds to [Base](base):
    * [Logging](logging) provides consolidated logging and visualisation of log statements and events across your environment
    * [Metrics](metrics) provides consolidated historical metric collection and visualisation across your environment
(replicationControllers.html) and [services](http://fabric8.io/guide/services.html)
* [Continuous Delivery](cdelivery)
    * [CD Core](cdelivery-core) using [Gogs](http://gogs.io/), [Jenkins](https://jenkins-ci.org/), [Nexus](http://www.sonatype.org/nexus/) and [SonarQube](http://www.sonarqube.org/)
    * [Chat](http://fabric8.io/guide/chat.html) provides a [hubot](https://hubot.github.com/) integration with the CD infrastructure
* [iPaaS](ipaas) provides an _Integration Platform As A Service_  
    * [API Registry](http://fabric8.io/guide/apiRegistry.html) provides a global view of all of your RESTful and web service APIs that is displayed in the [Console](http://fabric8.io/guide/console.html) allowing you to inspect and invoke all the endpoints
    * [MQ](http://fabric8.io/guide/fabric8MQ.html) implements _Messaging As A Service_ with [Apache ActiveMQ](http://activemq.apache.org/) on Kubernetes.
    * [MQ AutoScaler](http://fabric8.io/guide/fabric8MQAutoScaler.html) monitors and scales the [Apache ActiveMQ](http://activemq.apache.org/) brokers running on Kubernetes
