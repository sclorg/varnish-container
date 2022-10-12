{% macro env(config, spec) %}
  {% if config.os.id == "fedora" %}
    VERSION=0 \
  {% endif %}
  {% if (spec.prod == "rhel7" or spec.prod == "centos7") and spec.version|int > 5 %}
    VARNISH_VCL=/etc/opt/rh/rh-varnish{{ spec.version }}/varnish/default.vcl \
  {% elif spec.version|int > 5 %}
    VARNISH_VCL=/etc/varnish/default.vcl \
  {% endif %}
    VARNISH_CONFIGURATION_PATH={{ spec.etc_path }}/varnish
{%- endmacro %}

{% macro labels(config, spec) %}
  {% if config.os.id == "fedora" %}
      io.openshift.tags="builder,varnish" \
      version="$VERSION" \
      com.redhat.component="varnish" \
  {%- elif spec.prod in ["rhel8", "rhel9", "c9s", "c8s"] %}
      io.openshift.tags="builder,varnish{{ spec.version }},varnish-{{ spec.version }}" \
      com.redhat.component="varnish-{{ spec.version }}-container" \
      com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#rhel" \
      version="1" \
  {%- else  %}
      io.openshift.tags="builder,varnish,rh-varnish{{ spec.version }}" \
      com.redhat.component="rh-varnish{{ spec.version }}-container" \
      com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#rhel" \
      version="{{ spec.version }}" \
  {%- endif %}
{% endmacro %}

{% macro populate_install_pkgs(spec) %}
  {% if (spec.prod == "rhel7" or spec.prod == "centos7") and spec.version == "6" %}
INSTALL_PKGS="{{ spec.install_pkgs }} rh-varnish6-varnish-modules" && \
  {%- else %}
INSTALL_PKGS="{{ spec.install_pkgs }}" && \
  {%- endif %}
{% endmacro %}
