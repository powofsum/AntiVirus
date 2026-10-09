# Shell Script for a Simple Antivirus Daemon 
## Overview
-Antivirus Daemon (antivirusd.sh): Periodically polls a target directory for modifications by comparing snapshots taken with ls . When changes are detected, it scans all files inside the directory for blacklisted file extensions or malicious keywords. Identified threats are automatically logged, quarantined, and removed from the source directory.

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
- OS: Ubuntu / Linux environment
- Shell: Bash (/bin/bash)
- Utilities: cmp, grep, ls, cp, rm, make,crontab

### Installation on Ubuntu
Ensure your package lists are up to date and install build-essential (which includes make and core Linux utilities):
```
sudo apt update
sudo apt install build-essential -y
```


Make sure the execution permissions are set on both shell scripts:
```
chmod +x antivirusd.sh restore.sh
```
## How to run 
### Prepare the Directories

Before starting, ensure you have a target directory to monitor (e.g., monitored_dir).
```
mkdir -p monitored_dir
```

### Run the Antivirus Daemon

The daemon takes three positional arguments: ./antivirusd.sh  dir malicious_dir interval-secs

Using Make (automatically creates quarantine_dir before running):
```
make antivirus DIR=DIR_NAME MALICIOUS_DIR=DIR_NAME  INTERVAL_SECS=SECS
```

Or running directly via shell:
```
./antivirusd.sh monitored_dir quarantine_dir 5
```


Within 5 seconds, the daemon will output:
test_threat.txt is malicious and it is DELETED

### Run the Restore Tool

> [!CAUTION]
> Do not run antivirusd.sh and restore.sh concurrently.

Using Make:
```
make restore DIR=DIR_NAME MALICIOUS_DIR=DIR_NAME
```

Or running directly via shell:
```
./restore.sh monitored_dir quarantine_dir
```

### Interactive Options in Restore Tool:

Input 1: Restore file back to monitored_dir (False positive)

Input 2: Permanently delete file from quarantine_dir (Genuinely malicious)

Input 3: Leave file in quarantine and return to the main list

## flagged-extensions and flagged-keywords lists 
any of the following keywords found in file or extensions are considered as malicious file. 
- Keywords (case insensitive) : virus, trojan, malware, worm, ransomware.
- Extensions:  .exe, .bat, .vbs, .scr, .ps1.
### Locations 
Located in antivirusd.sh file  

## Cron Job Configuration Guide
To schedule an automated periodic scan without running a persistent daemon, you can configure a system cron job.

### Cron Syntax
```
m hr DOM M DOW   /path/to/antivirusd.sh /path/to/monitored_dir /path/to/quarantine_dir
```
>[!NOTE]
>**Example:**
>the cron expression should be to run this scan every 3rd Friday of the month at 12:31 am 
>```
>31 0 * * 5 [ "$(date +\%d)" -ge 15 ] && [ "$(date +\%d)" -le 21 ] && /path/to/antivirus-cron.sh /path/to/dir1 /path/to/malicious_dir
>```
### How to Setup
```
crontab -e
```
then select nano and type your schedule prefrence

type ctrl+o then enter

type ctrl+x

Verify that your cron entry was successfully added:
```
crontab -l
```
## Whitelist
A file is considered as whitelist if it was restored again by the user restore.sh , A hidden file created **.whitelist** which will contain the names of file restored by user to avoid removing it again by antivirus.
### How a File Added to whitelist
When a suspicious file is detected, the daemon moves it to malicious_dir.
If the user determines that the file is safe, they run restore.sh to restore it to its original directory.
After the file is successfully restored, restore.sh appends its filename to a hidden text file named .whitelist, using the >> operator.
Each line in .whitelist contains the name of one file that the user has restored and marked as safe.
The original filename and extension remain unchanged. The .whitelist file is separate from the restored file and preserves the whitelist entries between scans.
### How Daemon Checks the Whitelist Dusring a Scan
Before checking a file's extension or content for suspicious patterns, antivirusd.sh checks whether the file is listed in .whitelist.
```
 touch .whitelist
            if ! grep -Fxq -- "$(basename "$file")" .whitelist
            then    
                echo "$file is malicious and it is DELETED"
                # DELTE AND MOVE IT TO MALICIOUS DIR
                move_to_malicious_dir "$file"    
             fi   

```
then in restore.sh we have
```
mark_as_whitelist(){
    touch .whitelist # if it doesn't exist
    echo "$file_selected" >> .whitelist
}
```
and if user decided to restore file 
```
if [[ "$choice" -eq 1 ]]
        then
            restore_file
            mark_as_whitelist
```


## Helpful Links
- [Makefile](https://commandlinux.com/how-to/makefile/)
- [Cron Job](https://en.wikipedia.org/wiki/Cron)
