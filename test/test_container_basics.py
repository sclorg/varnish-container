from container_ci_suite.container_lib import ContainerTestLib
from container_ci_suite.engines.podman_wrapper import PodmanCLIWrapper

from conftest import VARS


class TestVarnishBasicsContainer:

    def setup_method(self):
        self.app = ContainerTestLib(image_name=VARS.IMAGE_NAME, s2i_image=True)

    def teardown_method(self):
        self.app.cleanup()

    def test_run_s2i_usage(self):
        """
        Test if /usr/libexec/s2i/usage works properly
        """
        output = self.app.s2i_usage()
        assert output

    def test_docker_run_usage(self):
        """
        Test if podman run works properly
        """
        assert PodmanCLIWrapper.call_podman_command(
            cmd=f"run --rm {VARS.IMAGE_NAME} &>/dev/null",
            return_output=False
        ) == 0

    def test_scl_usage(self):
        assert f"varnish-{VARS.VERSION}" in PodmanCLIWrapper.podman_run_command(
            f"--rm {VARS.IMAGE_NAME} /bin/bash -c 'varnishd -V'"
        )
