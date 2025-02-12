import subprocess

first = ["ls","-l","/var/log"]
second = "launchctl list | grep ssh"
try:
    # p = subprocess.run(first, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    p = subprocess.run(second,shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    if(p.returncode == 0):
        print(p.stdout.decode())
    else:
        print(f'Error: {p.stderr.decode()}')

except FileNotFoundError:
    print("Error: Directory not found.")
except PermissionError:
    print("Error: Permission denied.")
