#!/bin/bash

# mik, 2023.09.19
# edited:

# Backup Script for unix hosts
# Script performs a backup from local files to
# a remote system (NFS), run by cronjob.

# Logfile
LOGFILE="backup.log"
exec 3>&1 1>>"$LOGFILE" 2>&1
printf "\n###\nStart backup\n"
date



# Read backup config
. config.cfg

# Check if backup folder exists, create if not
if [[ ! -e $dst_host/$src_host ]]; then
  echo "Create backup dir"
  mkdir $dst_host/$src_host
fi

# Check directory for current date
today=$(date +%Y-%m-%d)
if [[ ! -e $dst_host/$src_host/$today ]]; then
  printf "Create backup daily dir"
  mkdir $dst_host/$src_host/$today
fi

for path in $backups; do
  printf "Backup of $path to $dst_host/$src_host/$today"
  cp -r $path $dst_host/$src_host/$today
done
