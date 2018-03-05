Varnish Cache 4.0 HTTP reverse proxy container image
=====================================================

This container image includes Varnish 4.0 Cache server and a reverse proxy for OpenShift and general usage.
Users can choose between RHEL and CentOS based images.
The RHEL image is available in the [Red Hat Container Catalog](https://access.redhat.com/containers/#/registry.access.redhat.com/rhscl/varnish-4-rhel7)
as registry.access.redhat.com/rhscl/varnish-4-rhel7.
The CentOS image is then available on [Docker Hub](https://hub.docker.com/r/centos/varnish-4-centos7/)
as centos/varnish-4-centos7.


Description
-----------

Varnish available as container is a base platform for 
running Varnish server or building Varnish-based application. 
Varnish Cache stores web pages in memory so web servers don't have to create 
the same web page over and over again. Varnish Cache serves pages much faster 
than any application server, giving the website a significant speed up.

The image can be used as a base image for other applications based on Varnish Cache 4.0 or using s2i tool.


Usage
-----

To build a simple [sample-app](https://github.com/sclorg/varnish-container/tree/master/4/test/test-app) application
using standalone [S2I](https://github.com/openshift/source-to-image) and then run the
resulting image with [Docker](http://docker.io) execute:

*  **For RHEL based image**
    ```
    $ docker pull registry.access.redhat.com/rhscl/varnish-4-rhel7
    $ s2i build https://github.com/sclorg/varnish-container.git --context-dir=4/test/test-app/ registry.access.redhat.com/rhscl/varnish-4-rhel7 sample-server
    $ docker run -p 8080:8080 sample-server
    ```

*  **For CentOS based image**
    ```
    $ docker pull centos/varnish-4-centos7
    $ s2i build https://github.com/sclorg/varnish-container.git --context-dir=4/test/test-app/ centos/varnish-4-centos7 sample-server
    $ docker run -p 8080:8080 sample-server
    ```

**Accessing the application:**
```
$ curl 127.0.0.1:8080
```


Configuration
-------------
No further configuration is required.


S2I build support
-------------
The Varnish Cache 4.0 container image supports the S2I tool (see Usage section). 
Note that the default.vcl configuration file in the directory accessed by S2I needs 
to be in the VCL format.

Environment variables and volumes
-------------
No special environment variables or volumes available.

Troubleshooting
---------------
Varnish logs into standard output, so the log is available in the container log. The log can be examined by running:

    docker logs <container>


See also
--------
Dockerfile and other sources for this container image are available on
https://github.com/sclorg/varnish-container.
In that repository, Dockerfile for CentOS is called Dockerfile, Dockerfile
for RHEL is called Dockerfile.rhel7.
