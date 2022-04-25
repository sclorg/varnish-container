FROM quay.io/centos7/s2i-core-centos7
EXPOSE 8080
EXPOSE 8443

ENV SUMMARY="Platform for running Varnish or building Varnish-based application" \
    DESCRIPTION="Varnish available as container is a base platform for \
running Varnish server or building Varnish-based application. \
Varnish Cache stores web pages in memory so web servers don't have to create \
the same web page over and over again. Varnish Cache serves pages much faster \
than any application server; giving the website a significant speed up." \
    VARNISH_VCL=/etc/opt/rh/rh-varnish6/varnish/default.vcl \
    VARNISH_CONFIGURATION_PATH=/etc/opt/rh/rh-varnish6/varnish

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Varnish 6" \
      io.openshift.expose-services="8080:http,8443:https" \
      io.openshift.tags="builder,varnish,rh-varnish6" \
      com.redhat.component="rh-varnish6-container" \
      com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#rhel" \
      version="6" \
      usage="s2i build https://github.com/sclorg/varnish-container.git --context-dir=6/test/test-app/ quay.io/centos7/varnish-6-centos7 sample-server" \
      name="centos7/varnish-6-centos7" \
      maintainer="Uhliarik Lubos <luhliari@redhat.com>"

RUN INSTALL_PKGS="gettext hostname nss_wrapper bind-utils rh-varnish6-varnish gcc rh-varnish6-varnish-modules" && \
    yum install -y centos-release-scl-rh && \
    yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    rm -f /etc/profile.d/lang.sh && \
    rm -f /etc/profile.d/lang.csh && \
    yum -y clean all --enablerepo='*'

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY 6/s2i/bin/ $STI_SCRIPTS_PATH

# Copy extra files to the image.
COPY 6/root/ /

# In order to drop the root user, we have to make some directories world
# writeable as OpenShift default security model is to run the container under
# random UID.
RUN chmod -R a+rwx ${APP_ROOT}/etc && \
    chmod -R a+rwx /var/opt/rh/rh-varnish6 && \
    chmod -R a+rwx /etc/opt/rh/rh-varnish6 && \
    chown -R 1001:0 ${APP_ROOT} && \
    chown -R 1001:0 /var/opt/rh/rh-varnish6 && \
    chown -R 1001:0 /etc/opt/rh/rh-varnish6
# Reset permissions of filesystem to default values
RUN rpm-file-permissions

USER 1001

# VOLUME ["/etc/opt/rh/rh-varnish6/varnish"]

ENV BASH_ENV=${APP_ROOT}/etc/scl_enable \
    ENV=${APP_ROOT}/etc/scl_enable \
    PROMPT_COMMAND=". ${APP_ROOT}/etc/scl_enable"
CMD $STI_SCRIPTS_PATH/usage
