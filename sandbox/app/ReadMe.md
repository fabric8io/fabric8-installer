## Install an individual Fabric8 App

This build lets you install one of the [individual microservices](https://github.com/fabric8io/quickstarts/tree/master/apps) from fabric8 on Kubernetes or OpenShift by specifying the `artifactId` property on the command line.

e.g.

    mvn install -DartifactId=jenkins
    
Or for a specific version of an app    
    
    mvn install -DartifactId=jenkins -Dfabric8.version=2.1.6
    