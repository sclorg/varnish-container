Varnish HTTP accelerator container images
=========================================

[![Build and push images to Quay.io registry](https://github.com/sclorg/varnish-container/actions/workflows/build-and-push.yml/badge.svg)](https://github.com/sclorg/varnish-container/actions/workflows/build-and-push.yml)

This repository contains Dockerfiles for Varnish HTTP accelerator images.
Users can choose between RHEL, CentOS, CentOS Stream 8, CentOS Stream 9 and Fedora based images.


Versions
---------------
Currently supported versions are visible in the following table, expand an entry to see its container registry address.
<!--
Table start
-->
||CentOS Stream 9|CentOS Stream 10|Fedora|RHEL 8|RHEL 9|RHEL 10|
|:--|:--:|:--:|:--:|:--:|:--:|:--:|
|6|<details><summary>✓</summary>`quay.io/sclorg/varnish-6-c9s`</details>|||<details><summary>✓</summary>`registry.redhat.io/rhel8/varnish-6`</details>|<details><summary>✓</summary>`registry.redhat.io/rhel9/varnish-6`</details>||
|7||<details><summary>✓</summary>`quay.io/sclorg/varnish-7-c10s`</details>|<details><summary>✓</summary>`quay.io/fedora/varnish-7`</details>|||<details><summary>✓</summary>`registry.redhat.io/rhel10/varnish-7`</details>|
<!--
Table end
-->

Installation
---------------
To build a Varnish image, choose either the CentOS Stream or RHEL based image:
* **RHEL based image**

    These images are available in the [Red Hat Container Catalog](https://catalog.redhat.com/software/containers/rhel8/varnish-6/5ba0ae68bed8bd6ee8198613?container-tabs=overview).
    To download it run:

    ```
    $ podman pull registry.redhat.io/rhel8/varnish-6
    ```

    To build a RHEL based Varnish image, you need to run the build on a properly
    subscribed RHEL machine.

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=rhel8 VERSIONS=6
    ```
* **CentOS Stream based image**

    This image is available on Quay.io. To download it run:

    ```
    $ podman pull quay.io/sclorg/varnish-6-c9s
    ```

    To build a CentOS Varnish image from scratch run:

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=c9s VERSIONS=6

* **Fedora based image**

    You need to build the Fedora variant locally:

    ```
    $ git clone --recursive https://github.com/sclorg/varnish-container.git
    $ cd varnish-container
    $ git submodule update --init
    $ make build TARGET=fedora VERSIONS=7
    ```

Note: while the installation steps are calling `podman`, you can replace any such calls by `docker` with the same arguments.

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of Varnish.**



Contributing
------------

In this repository [distgen](https://github.com/devexp-db/distgen/) is used for generating image source files. If you'd like update a Dockerfile, please make changes in specs/multispec.yml and/or Dockerfile.template (or other distgen file) and run `make generate`.


Usage
-----
For information about usage of Dockerfile for Varnish 6,
see [usage documentation](https://github.com/sclorg/varnish-container/6).

For information about usage of Dockerfile for Varnish 7,
see [usage documentation](https://github.com/sclorg/varnish-container/7).

Test
----
This repository also provides a [S2I](https://github.com/openshift/source-to-image) test framework,
which launches tests to check functionality of a simple Varnish application built on top of the Varnish image.

Users can choose between testing a Varnish test application based on a RHEL or CentOS image.

* **RHEL based image**

    To test a RHEL8 based Varnish image, you need to run the test on a properly
    subscribed RHEL machine.

    ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=rhel8 VERSIONS=6
    ```

* **CentOS Stream based image**

   ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=c9s VERSIONS=6
    ```

* **Fedora based image**

    ```
    $ cd varnish-container
    $ git submodule update --init
    $ make test TARGET=fedora VERSIONS=7
    ```

**Notice: By omitting the `VERSIONS` parameter, the build/test action will be performed
on all provided versions of Varnish.**
