# Shell Script for a Simple Antivirus Daemon 
## Overview
-Antivirus Daemon (antivirusd.sh): Periodically polls a target directory for modifications by comparing snapshots taken with ls -l. When changes are detected, it scans all files inside the directory for blacklisted file extensions or malicious keywords. Identified threats are automatically logged, quarantined, and removed from the source directory.

-Restore Tool (restore.sh): An interactive terminal tool that allows users to inspect quarantined files, restore false positives back to the monitored directory, or permanently delete confirmed threats.

-Build Automation (Makefile): Manages directory creation and executes the daemon and restore scripts with configurable target parameters.

## Directory Hierarchy
- Makefile             
- README.md            
- antivirusd.sh         
- restore.sh            
- monitored_dir/   (testdir)      
- quarantine_dir/  (test2dir)
- antivirus-cron.sh

## Prerequisites & Ubuntu Installation
-OS: Ubuntu / Linux environment
-Shell: Bash (/bin/bash)
-Utilities: cmp, grep, ls, cp, rm, make,crontab

##Installation on Ubuntu
Ensure your package lists are up to date and install build-essential (which includes make and core Linux utilities):
```
sudo apt update
sudo apt install build-essential -y
```


Make sure the execution permissions are set on both shell scripts:

chmod +x antivirusd.sh restore.sh



