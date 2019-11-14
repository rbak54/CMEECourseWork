import subprocess
p=subprocess.Popen(["echo","I'm talking to you , bash!"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout,stderr = p.communicate()
stderr
stdout
print(stdout.decode())
p=subprocess.Popen(["ls","-l"], stdout=subprocess.PIPE)
stdout,stderr=p.communicate()
print(stdout.decode())
p=subprocess.Popen(["python", "boilerplate.py"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
stdout, stderr= p.communicate()
print(stdout.decode())
MyPath=subprocess.os.path.join('directory', 'subdirectory', 'file')
##good for when trying to make directory that works on different operating systems)
