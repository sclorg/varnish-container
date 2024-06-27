{% macro env(config, spec) %}
  {% if config.os.id == "fedora" %}
    VERSION=0 \
  {% endif %}
  {% if spec.version|int > 5 %}
    VARNISH_VCL=/etc/varnish/default.vcl \
  {% endif %}
    VARNISH_CONFIGURATION_PATH={{ spec.etc_path }}/varnish
{%- endmacro %}

{% macro labels(config, spec) %}
  {% if config.os.id == "fedora" %}
      io.openshift.tags="builder,varnish" \
      version="$VERSION" \
      com.redhat.component="varnish" \
  {%- else %}
      io.openshift.tags="builder,varnish{{ spec.version }},varnish-{{ spec.version }}" \
      com.redhat.component="varnish-{{ spec.version }}-container" \
      com.redhat.license_terms="https://www.redhat.com/en/about/red-hat-end-user-license-agreements#rhel" \
      version="1" \
  {%- endif %}
{% endmacro %}
