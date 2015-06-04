## Install an individual Fabric8 App

This build lets you install a single application from the [Fabric8 Apps](http://fabric8.io/guide/apps.html) on Kubernetes or OpenShift by specifying the `artifactId` property on the command line.

e.g.

    mvn install -DartifactId=jenkins
    
Or for a specific version of an app    
    
    mvn install -DartifactId=jenkins -Dfabric8.version=2.1.6
    