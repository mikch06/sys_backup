#!/bin/bash

# mik, 2023.09.19
# edited: 2023.11.01

# Backup Script for unix hosts
# Script performs a backup from local files to
# a remote system (NFS), run by cronjob.
# Prepare mountpoint before!

# debug
#set -x

# Parent directory path
cd "$(dirname "$0")"

# Logfile
LOGFILE="backup.log"
exec 3>&1 1>>"$LOGFILE" 2>&1
printf "\n\n***\nStarting new backup\n"
date

# Read backup config
. config.cfg

# Mount backup mountpoint
sudo mount -t nfs $bak_mount

# Check if backup folder exists, create if not
if [[ ! -e $dst_dir/$(hostname) ]]; then
  echo "Create backup base directory for host $(hostname)"
  mkdir $dst_dir/$(hostname)
fi

# Check directory for current date
today=$(date +%Y-%m-%d)
if [[ ! -e $dst_dir/$(hostname)/$today ]]; then
  printf "Create backup daily directory $today\n"
  mkdir $dst_dir/$(hostname)/$today
fi

for path in $backups; do
  printf "Backup: $path to $dst_dir/$(hostname)/$today\n"
  cp -r --parents $path $dst_dir/$(hostname)/$today
done
