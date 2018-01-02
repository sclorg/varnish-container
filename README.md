Varnish HTTP accelerator Docker images
======================================

This repository contains Dockerfiles for Varnish HTTP accelerator images for OpenShift.
Users can choose between RHEL, CentOS and Fedora based images.


Versions
---------------
Varnish versions currently provided are:
* [varnish-4](4)
* [varnish-5](5) (Fedora only at the moment)

RHEL versions currently supported are:
* RHEL7

CentOS versions currently supported are:
* CentOS7

For more information about contributing, see
[the Contribution Guidelines](https://github.com/sclorg/welcome/blob/master/contribution.md).
For more information about concepts used in these docker images, see the
[Landing page](https://github.com/sclorg/welcome).


Installation
---------------
To build a Varnish image, choose either the CentOS or RHEL based image:
*  **RHEL based image**

    These images are available in the [Red Hat Container Catalog](https://access.redhat.com/containers/#/registry.access.redhat.com/rhscl/varnish-4-rhel7).
    To download it run:

    ```
    $ docker pull registry.access.redhat.com/rhscl/varnish-4-rhel7
    ```

    To build a RHEL based Varnish image, you need to run the build on a properly
    subscribed RHEL machine.

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=rhel7 VERSIONS=4
    ```

*  **CentOS based image**

    This image is available on DockerHub. To download it run:

    ```
    $ docker pull centos/varnish-4-centos7
    ```

    To build a Varnish image from scratch run:

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=centos7 VERSIONS=4
    ```

*  **Fedora based image**

    You need to build the Fedora variant locally:

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=fedora VERSIONS=5
    ```

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of Varnish.**


Usage
---------------------------------

For information about usage of Dockerfile for Varnish 4,
see [usage documentation](4).

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
    $ make test TARGET=rhel7 VERSIONS=4
    ```

*  **CentOS based image**

    ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=centos7 VERSIONS=4
    ```

*  **Fedora based image**

    ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=fedora VERSIONS=5
    ```

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of Varnish.**
