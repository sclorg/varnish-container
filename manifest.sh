# Manifest for image directories creation
# every dest path will be prefixed by $DESTDIR/$version

DESTDIR='' # optional, defaults to $PWD

# Files containing distgen directives
DISTGEN_RULES="
    src=src/cccp.yml
    dest=cccp.yml;

    src=src/README.md
    dest=README.md;

    src=src/opt/app-root/etc/scl_enable
    dest=root/opt/app-root/etc/scl_enable;

    src=src/s2i/bin/usage
    dest=s2i/bin/usage
    mode=0755;

    src=src/s2i/bin/run
    dest=s2i/bin/run
    mode=0755;
"

# Files containing distgen directives, which are used for each
# (distro, version) combination not excluded in multispec
DISTGEN_MULTI_RULES="
    src=src/Dockerfile.template
    dest=Dockerfile;

    src=src/Dockerfile.template
    dest=Dockerfile.rhel7;

    src=src/Dockerfile.template
    dest=Dockerfile.fedora
"

# Symbolic links
SYMLINK_RULES=""

# Files to copy
COPY_RULES="
    src=src/content_sets.yml
    dest=content_sets.yml;

    src=src/opt/app-root/etc/generate_container_user
    dest=root/opt/app-root/etc/generate_container_user;

    src=src/opt/app-root/etc/passwd.template
    dest=root/opt/app-root/etc/passwd.template;

    src=src/s2i/bin/assemble
    dest=s2i/bin/assemble
    mode=0755;

    src=test/run
    dest=test/run
    mode=0755;

    src=test/test-app/default.vcl
    dest=test/test-app/default.vcl;
"
