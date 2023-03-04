# Installs new applications.

import subprocess
import json
import os
import sys

json_file_name = "winget-apps.json"

def main(args: list[str]) -> None:

    # Handle args.

    # TODO: Handle arbitrary number of arguments.
    if (len(args) != 4):
        raise Warning("Unexpected number of arguments.")
    install_work_apps, install_private_apps, should_perform_operations = args[1:]

    # Gets apps to install.

    script_dir_path = os.getcwd()
    json_file_path = os.path.join(script_dir_path, json_file_name)
    if not os.path.exists(json_file_path):
        raise FileNotFoundError(f"""File expected but not found at: {json_file_path}.
            Make sure you run the script from a directory containing the json file.""")

    with open(json_file_path) as apps_to_install_file:
        apps_to_install_content = json.load(apps_to_install_file)

        apps_to_install = apps_to_install_content["basic-apps"]

        if install_private_apps == "true":
            apps_to_install += apps_to_install_content["private-only-apps"]
            print("Adding private only apps.")

        if install_work_apps == "true":
            apps_to_install += apps_to_install_content["work-only-apps"]
            print("Adding work only apps.")

        print(f"Apps to install: {apps_to_install}")
        if should_perform_operations != "-y":
            print("Not performing actions. Provide '-y' to perform operations.")
            exit()

    # Installs apps.

    for app in apps_to_install:
        list_app_response = subprocess.run(f"winget list --exact --query {app}", \
            stdout=subprocess.DEVNULL)

        # Checks if the app is already installed.
        if (list_app_response.returncode == 0):
            print(f"Found '{app}'. Attempting to upgrade...")
            output = subprocess.run(f"winget upgrade --exact --query {app}")

            if output.returncode == 0:
                print("Upgraded successfully.")
            elif output.returncode == 2316632107:
                print("No applicable update found.")
            else:
                print(f"Error: {output}.")

        else:
            print(f"Did not find installation of '{app}'. Attempting to install...")

            output = subprocess.run(f"winget install --exact --silent {app}")
            if output.returncode == 0:
                print(f"Installed {app} successfully.")
            else:
                print(f"Error: {output}.")

if  __name__ != "__main__":
    print("Running as module.")
    exit()

print("Running as main.")

# TODO: Check out 'click' for argument parsing.
args = sys.argv
main(args)