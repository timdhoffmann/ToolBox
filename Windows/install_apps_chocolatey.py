"""
Installs apps via Chocolatey.
"""

import argparse
import os
import subprocess
import sys
import yaml

if __name__ != "__main__":
    print("Running as module.")
    sys.exit()


def main(args: argparse.Namespace) -> None:
    # TODO: Consider if we need to check if we are running elevated for choco to work.

    apps = get_apps(args)
    print(apps)

    handle_apps(args, apps)


def handle_apps(args: argparse.Namespace, apps: list[str]):

    choco_args: list[str] = []
    if not args.y:
        print("Running in 'whatif' mode. To perform operations, provide the '-y' argument.")
        choco_args.append("--whatif")
    else:
        choco_args.append("-y")

    for app in apps:

        cmd = ["choco", "upgrade", app, *choco_args]
        print(cmd)

        show_output = True
        stdout_dest = None if show_output else subprocess.DEVNULL
        # 'shell=True' is required to fix a 'File not found' error.
        # see https://stackoverflow.com/questions/73193119/python-filenotfounderror-winerror-2-the-system-cannot-find-the-file-specifie.
        response = subprocess.run(
            cmd, stdout=stdout_dest, shell=True, check=True
        )

        print(f"\
{response.stdout=!r},\
{response.returncode=!r},\
{response.stderr=!r}"
        )

        # TODO: handle non-zero return codes.
        if response.returncode != 0:
            print(f"Non-zero return code detected: {response.returncode}")

        # TODO: Handle hanging installers, e.g. Spotify:
            # Download of SpotifyFullSetup.exe (909.97 KB) completed.
            # Hashes match.
            # SUCCESS: The scheduled task "spotify" has successfully been created.
            # SUCCESS: Attempted to run the scheduled task "spotify".
            # SUCCESS: The scheduled task "spotify" was successfully deleted.


def get_apps(args: argparse.Namespace) -> list[str]:
    script_dir_path = os.path.dirname(os.path.realpath(__file__))
    apps_file_path = os.path.join(script_dir_path, APPS_FILE_NAME)
    if not os.path.exists(apps_file_path):
        raise FileNotFoundError(f"""
Configuration file not found at '{apps_file_path}. Make sure you are running
the script from a directory containing the file."""
                                )

    with open(apps_file_path, 'r', encoding="utf-8") as apps_file:
        apps_yml = yaml.safe_load(apps_file)

        apps_to_install: list[str] = []
        for app in apps_yml['apps']['common']:
            apps_to_install.append(app)

        if args.private:
            for app in apps_yml['apps']['private']:
                apps_to_install.append(app)

        if args.work:
            for app in apps_yml['apps']['work']:
                apps_to_install.append(app)

        return apps_to_install


APPS_FILE_NAME = "chocolatey_apps.yml"

parser = argparse.ArgumentParser()
parser.add_argument('--private', action='store_true',
                    help='install private apps.')
parser.add_argument('--work', action='store_true', help='install work apps.')
parser.add_argument('-y', action='store_true',
                    help='confirm to perform destructive operations')
cli_args = parser.parse_args()

print(":: Install Apps with Chocolatey ::")
main(cli_args)
