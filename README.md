Varnish HTTP accelerator container images
======================================

This repository contains Dockerfiles for Varnish HTTP accelerator images for OpenShift.
Users can choose between RHEL, CentOS and Fedora based images.


Versions
---------------
Varnish versions currently provided are:
* [varnish-5](https://github.com/sclorg/varnish-container/tree/generated/5)
* [varnish-6](https://github.com/sclorg/varnish-container/tree/generated/6)

RHEL versions currently supported are:
* RHEL7
* RHEL8

CentOS versions currently supported are:
* CentOS7

For more information about contributing, see
[the Contribution Guidelines](https://github.com/sclorg/welcome/blob/master/contribution.md).
For more information about concepts used in these container images, see the
[Landing page](https://github.com/sclorg/welcome).


Installation
---------------
To build a Varnish image, choose either the CentOS or RHEL based image:
*  **RHEL based image**

    These images are available in the [Red Hat Container Catalog](https://access.redhat.com/containers/#/registry.access.redhat.com/rhscl/varnish-6-rhel7).
    To download it run:

    ```
    $ podman pull registry.access.redhat.com/rhscl/varnish-6-rhel7
    ```

    To build a RHEL based Varnish image, you need to run the build on a properly
    subscribed RHEL machine.

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=rhel7 VERSIONS=6
    ```

*  **CentOS based image**

    This image is available on DockerHub. To download it run:

    ```
    $ podman pull centos/varnish-6-centos7
    ```

    To build a Varnish image from scratch run:

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=centos7 VERSIONS=6
    ```

*  **Fedora based image**

    You need to build the Fedora variant locally:

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=fedora VERSIONS=5
    ```

Note: while the installation steps are calling `podman`, you can replace any such calls by `docker` with the same arguments.

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of Varnish.**



Contributing
--------------------------------

In this repository [distgen](https://github.com/devexp-db/distgen/) is used for generating image source files. If you'd like update a Dockerfile, please make changes in specs/multispec.yml and/or Dockerfile.template (or other distgen file) and run `make generate`.


Usage
---------------------------------
For information about usage of Dockerfile for Varnish 5,
see [usage documentation](https://github.com/sclorg/varnish-container/tree/generated/5).

For information about usage of Dockerfile for Varnish 6,
see [usage documentation](https://github.com/sclorg/varnish-container/tree/generated/6).

Test
---------------------
This repository also provides a [S2I](https://github.com/openshift/source-to-image) test framework,
which launches tests to check functionality of a simple Varnish application built on top of the Varnish image.

Users can choose between testing a Varnish test application based on a RHEL or CentOS image.

*  **RHEL based image**

    To test a RHEL7 based Varnish image, you need to run the test on a properly
    subscribed RHEL machine.

    ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=rhel7 VERSIONS=6
    ```

*  **CentOS based image**

    ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=centos7 VERSIONS=6
    ```

*  **Fedora based image**

    ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=fedora VERSIONS=5
    ```

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of Varnish.**
