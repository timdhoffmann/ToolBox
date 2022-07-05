# Sets for all users. This also ensures that it is available for remote sessions, e.g. Ansible.
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices" -Name "S:" -Value "\??\C:\Users\thoffmann\source"

# Sets the local user:
# Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" -Name "R Drive" -Value "subst R: D:\\projects"
