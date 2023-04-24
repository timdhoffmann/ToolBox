import argparse
import os
import subprocess
import yaml

if __name__ != "__main__":
    print("Running as module.")
    exit()

def main(args: argparse.Namespace) -> None:
    print(args)

    apps_to_install = get_apps_to_install(args)
    print(apps_to_install)

    intall_apps(args, apps_to_install)

def intall_apps(args: argparse.Namespace, apps: list[str]):
    if not args.y:
        print("To perform operations, provide the '-y' argument.")
        exit()

    for app in apps:
        # TODO implement installation
        response = subprocess.run(["chocolatey", "install", app, "-y"])
        print(response.stdout)


def get_apps_to_install(args: argparse.Namespace) -> list[str]:
    script_dir_path = os.path.dirname(os.path.realpath(__file__))
    apps_file_path = os.path.join(script_dir_path, apps_file_name)
    if not os.path.exists(apps_file_path):
        raise FileNotFoundError(f"""Configuration file not found at '{apps_file_path}. Make sure you are running
        the script from a directory containing the file.""")

    with open(apps_file_path, 'r') as apps_file:
        apps_yml = yaml.safe_load(apps_file)

        apps_to_install: list[str] = []
        for app in apps_yml['apps']['common']:
            apps_to_install.append(app)

        if args.private:
            for app in apps_yml['apps']['private']:
                apps_to_install.append(app)

        if  args.work:
            for app in apps_yml['apps']['work']:
                apps_to_install.append(app)

        return apps_to_install

apps_file_name = "chocolatey_apps.yml"

parser = argparse.ArgumentParser()
parser.add_argument('--private', action='store_true', help='install private apps.')
parser.add_argument('--work', action='store_true', help='install work apps.')
parser.add_argument('-y', action='store_true', help='confirm to perform destructive operations')
args = parser.parse_args()

print(":: Install Apps with Chocolatey ::")
main(args)