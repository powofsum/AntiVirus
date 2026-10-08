# Overview
-Antivirus Daemon (antivirusd.sh): Periodically polls a target directory for modifications by comparing snapshots taken with ls -l. When changes are detected, it scans all files inside the directory for blacklisted file extensions or malicious keywords. Identified threats are automatically logged, quarantined, and removed from the source directory.

-Restore Tool (restore.sh): An interactive terminal tool that allows users to inspect quarantined files, restore false positives back to the monitored directory, or permanently delete confirmed threats.

-Build Automation (Makefile): Manages directory creation and executes the daemon and restore scripts with configurable target parameters.

