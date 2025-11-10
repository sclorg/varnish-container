import pytest

from pathlib import Path

from container_ci_suite.container_lib import ContainerTestLib
from container_ci_suite.container_lib import ContainerImage
from container_ci_suite.engines.podman_wrapper import PodmanCLIWrapper

from conftest import VARS

test_app = VARS.TEST_DIR / "test-app"


def build_s2i_app(app_path: Path) -> ContainerTestLib:
    container_lib = ContainerTestLib(VARS.IMAGE_NAME)
    app_name = app_path.name
    s2i_app = container_lib.build_as_df(
        app_path=app_path,
        s2i_args="--pull-policy=never",
        src_image=VARS.IMAGE_NAME,
        dst_image=f"{VARS.IMAGE_NAME}-{app_name}",
    )
    return s2i_app


class TestVarnishApplicationContainer:
    def setup_method(self):
        self.s2i_app = build_s2i_app(test_app)

    def teardown_method(self):
        self.s2i_app.cleanup()

    def test_run_s2i_usage(self):
        """
        Test if /usr/libexec/s2i/usage works properly
        """
        assert self.s2i_app.s2i_usage()

    def test_docker_run_usage(self):
        """
        Test if podman run works properly
        """
        assert (
            PodmanCLIWrapper.call_podman_command(
                cmd=f"run --rm {VARS.IMAGE_NAME} &>/dev/null", return_output=False
            )
            == 0
        )

    @pytest.mark.parametrize("container_arg", ["", "--user=100001", "--user 12345"])
    def test_run_app_test(self, container_arg):
        """
        Test checks if varnish starts properly
        and response returns proper http://example.org
        """
        cid_file_name = self.s2i_app.app_name
        assert self.s2i_app.create_container(
            cid_file_name=cid_file_name, container_args=container_arg
        )
        assert ContainerImage.wait_for_cid(cid_file_name=cid_file_name)
        cid = self.s2i_app.get_cid(cid_file_name=cid_file_name)
        assert cid
        cip = self.s2i_app.get_cip(cid_file_name=cid_file_name)
        assert cip
        assert self.s2i_app.test_response(
            url=cip,
            host="oldexample.com",
            expected_code=301,
            expected_output="http://example.org",
        )
