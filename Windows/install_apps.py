# Installs new applications.

import subprocess

apps = [
    # Development.
    "test.test",
    "Microsoft.PowerShell",
    # "Microsoft.VisualStudioCode"
]

for app in apps:
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