{% macro env(config, spec) %}
  {% if config.os.id == "fedora" %}
    VERSION=0 RELEASE=1 \
  {% endif %}
    VARNISH_CONFIGURATION_PATH={{ spec.conf_path }}
{%- endmacro %}

{% macro labels(config, spec) %}
  {% if config.os.id == "fedora" %}
      io.openshift.tags="builder,varnish" \
      version="$VERSION" \
      release="$RELEASE.$DISTTAG" \
      usage="Invoke this container directly to get more info on how it should be used." \
  {%- else %}
      io.openshift.tags="builder,varnish,rh-varnish{{ spec.version }}" \
      com.redhat.component="rh-varnish{{ spec.version }}-docker" \
      version="{{ spec.version }}" \
      usage="s2i build https://github.com/sclorg/varnish-container.git --context-dir={{ spec.version }}/test/test-app/ {{ spec.img_name }} sample-server" \
  {%- endif %}
{% endmacro %}
