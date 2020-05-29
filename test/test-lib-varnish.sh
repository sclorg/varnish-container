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

function test_response_redirect_internal() {
  local url="$1"
  local expected_code="$2"
  local old_host="$3"
  local new_location="$4"
  local max_attempts=${5:-20}

  : "  Testing the HTTP(S) response for <${url}>"
  local sleep_time=3
  local attempt=1
  local result=1
  local status
  local response_code
  local response_file=$(mktemp /tmp/ct_test_response_XXXXXX)
  local util_image_name='python:3.6'

  ct_os_deploy_cmd_image "${util_image_name}"

  while [ ${attempt} -le ${max_attempts} ]; do
    ct_os_cmd_image_run "curl --connect-timeout 10 -s -w '%{redirect_url}\n%{http_code}' -H 'Host:${old_host}' '${url}'" >${response_file} && status=0 || status=1
    if [ ${status} -eq 0 ]; then
      response_code=$(cat ${response_file} | tail -c 3)
      if [ "${response_code}" -eq "${expected_code}" ]; then
        result=0
      fi
      cat ${response_file} | grep -qP -e "${new_location}" || result=1;
      # Some services return 40x code until they are ready, so let's give them
      # some chance and not end with failure right away
      # Do not wait if we already have expected outcome though
      if [ ${result} -eq 0 -o ${attempt} -eq ${max_attempts} ] ; then
        break
      fi
    fi
    attempt=$(( ${attempt} + 1 ))
    sleep ${sleep_time}
  done
  rm -f ${response_file}
  return ${result}
}

function test_varnish_integration() {
  local image_name=$1
  local version=$2
  ct_os_test_s2i_app_func "${image_name}" \
                          "https://github.com/sclorg/varnish-container.git" \
                          "test/test-app" \
                          "test_response_redirect_internal 'http://<IP>:8080' '301' 'oldexample.com' 'http://example.org'"
}

# Check the imagestream
function test_varnish_imagestream() {
  local image_stream_file
  local local_image_stream_file
  case ${OS} in
    rhel7|centos7) ;;
    *) echo "Imagestream testing not supported for $OS environment." ; return 0 ;;
  esac

  image_stream_file="${THISDIR}/imagestreams/varnish-${OS}.json"
  echo "Running image stream test for stream ${image_stream_file} and test application"

  # shellcheck disable=SC2119
  ct_os_new_project

  local_image_stream_file=$(ct_obtain_input "${image_stream_file}")
  oc create -f "${local_image_stream_file}"

  # ct_os_test_s2i_app creates a new project, but we already need
  # it before for the image stream import, so tell it to skip this time
  CT_SKIP_NEW_PROJECT=true \
  ct_os_test_s2i_app_func "${IMAGE_NAME}" \
                          "https://github.com/sclorg/varnish-container.git" \
                          test/test-app \
                          "test_response_redirect_internal 'http://<IP>:8080' '301' 'oldexample.com' 'http://example.org'"

  result=$?

  # shellcheck disable=SC2119
  ct_os_delete_project
}
# vim: set tabstop=2:shiftwidth=2:expandtab:
