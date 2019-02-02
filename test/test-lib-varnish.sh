#!/bin/bash
#
# Functions for tests for the Varnish image in OpenShift.
#
# IMAGE_NAME specifies a name of the candidate image used for testing.
# The image has to be available before this script is executed.
#

THISDIR=$(dirname ${BASH_SOURCE[0]})

source ${THISDIR}/test-lib.sh
source ${THISDIR}/test-lib-openshift.sh

function test_varnish_integration() {
  local image_name=$1
  local version=$2
  local import_image=${3:-}
  VERSION=$version ct_os_test_s2i_app_func "${image_name}" \
                                           "https://github.com/sclorg/varnish-container.git" \
                                           test/test-app \
                                           "test_response_redirect_internal 'http://<IP>:8080' '301' 'oldexample.com' 'http://example.org'" \
                                           "" \
                                           "${import_image}"
}

