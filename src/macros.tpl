{% macro env(config, spec) %}
  {% if config.os.id == "fedora" %}
    VERSION=0 \
  {% endif %}
    VARNISH_CONFIGURATION_PATH={{ spec.etc_path }}/varnish
{%- endmacro %}

{% macro labels(config, spec) %}
  {% if config.os.id == "fedora" %}
      io.openshift.tags="builder,varnish" \
      version="$VERSION" \
      com.redhat.component="varnish" \
  {%- elif spec.prod == "rhel8" %}
      io.openshift.tags="builder,varnish{{ spec.version }},varnish-{{ spec.version }}" \
      com.redhat.component="varnish-{{ spec.version }}-container" \
      version="1" \
  {%- else  %}
      io.openshift.tags="builder,varnish,rh-varnish{{ spec.version }}" \
      com.redhat.component="rh-varnish{{ spec.version }}-container" \
      version="{{ spec.version }}" \
  {%- endif %}
{% endmacro %}
