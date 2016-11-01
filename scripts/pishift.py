#!/usr/bin/env python 
import subprocess
from time import sleep
def grabRecent():
    #mountCommand = "sudo mount -o ro /opt/pishift/binaries/ms.bin /mnt"
    mountCommand = ["sudo", "mount", "-o", "ro", "/opt/pishift/binaries/ms.bin", "/mnt"]
    #unmountCommand = "sudo umount /mnt"
    unmountCommand = ["sudo", "umount", "/mnt"]

    findCmd = "cd /mnt; ls -tp | grep -v '/$' | head -n1"

    runCmd(mountCommand)

    filename = runCmd(findCmd, shell=True)[:-1]

    copyDest = "/opt/pishift/programs/"+filename

    #copyCmd = 'cp "/mnt/' + filename + '" "' + copyDest + '"' 
    copyCmd = ["cp", "/mnt/" + filename, copyDest]

    runCmd(copyCmd)

    runCmd(unmountCommand)

    return copyDest,filename

def getMD5(fname):
    #md5Command = 'md5sum "' + fname + '"'
    md5Command = ["md5sum", fname]
    result = runCmd(md5Command)
    return result.split()[0]

def runCmd(cmd, shell=False):
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE, shell=shell)
    output = process.communicate()[0]
    return output

lastHash = None
proc = None
while True:
    fullpath,newName = grabRecent()
    newHash = getMD5(fullpath)
    if(proc):
        if (proc.poll()!=None):
            print ("=====YOUR PROGRAM DIED. TRY AGAIN?=====")
            print ("=====THE OUTPUT WAS: ========")
            print ""
            print (proc.communicate()[0])
            print ("=====WAITING FOR NEW FILE======")
            proc = None
    if (newHash!=lastHash and newName!="pishift.py"): #avoid recursion by not running this file automatically
        if (proc):
            proc.kill() #kill the old python file that was running, and start running the new process
            print ("======KILLED======")
        print ("======RUNNING NEW FILE: "+newName+"======")
        proc = subprocess.Popen(["python3",fullpath],stdout=subprocess.PIPE,stderr=subprocess.STDOUT)
        lastHash = newHash 
    else:
        #print ("======NO CHANGES FOUND======")
        pass
    sleep(1)
