Varnish Cache {{ spec.version }}.0 HTTP reverse proxy Container image
=====================================================

[![Docker Repository on Quay](https://quay.io/repository/sclorg/varnish-{{ spec.version }}-c9s/status "Docker Repository on Quay")](https://quay.io/repository/sclorg/varnish-{{ spec.version }}-c9s)

This container image includes Varnish {{ spec.version }}.0 Cache server and general usage.
Users can choose between RHEL, CentOS and Fedora based images.
The RHEL images are available in the [Red Hat Container Catalog](https://access.redhat.com/containers/),
the CentOS Stream images are available on [Quay.io/sclorg](https://quay.io/organization/sclorg),
and the Fedora images are available in [Quay.io/fedora](https://quay.io/organization/fedora).
The resulting image can be run using [podman](https://github.com/containers/libpod).

Note: while the examples in this README are calling `podman`, you can replace any such calls by `docker` with the same arguments

Description
-----------

Varnish available as container is a base platform for
running Varnish server or building Varnish-based application. 
Varnish Cache stores web pages in memory so web servers don't have to create 
the same web page over and over again. Varnish Cache serves pages much faster 
than any application server, giving the website a significant speed up.

The image can be used as a base image for other applications based on Varnish Cache {{ spec.version }}.0 using Openshift's s2i feature.


Usage
-----

For this, the same application can also be built using the standalone [S2I](https://github.com/openshift/source-to-image) application on systems that have it available:

    ```
    $ s2i build https://github.com/sclorg/varnish-container.git --context-dir={{ spec.version }}/test/test-app/ rhel8/varnish-{{ spec.version }} sample-server
    ```

**Accessing the application:**
```
$ curl 127.0.0.1:8080
```


Configuration
-------------
No further configuration is required.


S2I build support
-----------------
The Varnish Cache {{ spec.version }}.0 Container image supports the S2I tool (see Usage section).
Note that the default.vcl configuration file in the directory accessed by S2I needs 
to be in the VCL format.

Environment variables and volumes
---------------------------------
No special environment variables or volumes available.

Troubleshooting
---------------
Varnish logs into standard output, so the log is available in the container log. The log can be examined by running:

    podman logs <container>


See also
--------
Dockerfile and other sources for this container image are available on
https://github.com/sclorg/varnish-container.
In that repository you also can find another versions of Python environment Dockerfiles.
Dockerfile for RHEL8 it's `Dockerfile.rhel8`, for RHEL9 it's `Dockerfile.rhel9`,
Dockerfile for CentOS Stream 9 is called `Dockerfile.c9s`
and the Fedora Dockerfile is called Dockerfile.fedora.
