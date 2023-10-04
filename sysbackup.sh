#!/bin/bash

# mik, 2023.09.19
# edited:

# Backup Script for unix hosts
# Script performs a backup from local files to
# a remote system (NFS), run by cronjob.
# Prepare mountpoint before!

# debug
#set -x


# Logfile
LOGFILE="backup.log"
#exec 3>&1 1>>"$LOGFILE" 2>&1
printf "\n###\nStart backup\n"
date

# Read backup config
. config.cfg

# Mount backup mountpoint
sudo mount -t nfs $bak_mount

# Check if backup folder exists, create if not
if [[ ! -e $dst_dir/$src_dir ]]; then
  echo "Create backup dir"
  mkdir $dst_dir/$src_dir
fi

# Check directory for current date
today=$(date +%Y-%m-%d)
if [[ ! -e $dst_dir/$src_dir/$today ]]; then
  printf "Create backup daily dir"
  mkdir $dst_dir/$src_dir/$today
fi

for path in $backups; do
  printf "Backup of $path to $dst_dir/$src_dir/$today"
  cp -r $path $dst_dir/$src_dir/$today
done
