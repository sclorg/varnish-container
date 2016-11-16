Docker image for Varnish Cache 4.0 HTTP reverse proxy
=====================================================

This repository contains the source for Varnish Cache 4.0 Docker image.
The image can be used as a base image for other applications based on Varnish Cache 4.0 or using s2i tool.


*  **For RHEL based image**
    ```
    $ docker pull registry.access.redhat.com/rhscl/varnish-4-rhel7
    $ s2i build https://github.com/sclorg/varnish-container.git --context-dir=4/test/test-app/ rhscl/varnish-4-rhel7 sample-server
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

The Varnish Cache 4.0 Docker image supports the S2I tool. Note that the default.vcl configuration file in the directory accessed by S2I needs to be in the VCL format.

