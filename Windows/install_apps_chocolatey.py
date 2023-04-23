import argparse
import os
import yaml

if __name__ != "__main__":
    print("Running as module.")
    exit()

apps_file_name = "chocolatey_apps.yml"

print(":: Install Apps with Chocolatey ::")

def main(args: argparse.Namespace) -> None:
    print(args)

    script_dir_path = os.getcwd()
    apps_file_path = os.path.join(script_dir_path, apps_file_name)
    if not os.path.exists(apps_file_path):
        raise FileNotFoundError(f"""Configuration file not found at '{apps_file_path}. Make sure you are running
        the script from a directory containing the file.""")

    with open(apps_file_path, 'r') as apps_file:
        apps_yml = yaml.safe_load(apps_file)

        for app in apps_yml['apps']:
            print(app)

    # TODO

parser = argparse.ArgumentParser()
parser.add_argument('--private', action='store_true', help='install private apps.')
parser.add_argument('--work', action='store_true', help='install work apps.')
parser.add_argument('-y', action='store_true', help='confirm to perform destructive operations')

args = parser.parse_args()
main(args)