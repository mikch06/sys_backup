#!/bin/bash

# mik, 2023.09.19
# edited:

# Script performs a backup from local files to
# a remote system, run by cronjob.

src_host="tux-manjaro"
dst_host="/mnt/sysbackup"
backups="
/opt/teamviewer
/var/log
"

# Check if backup folder exists, create if not
if [[ ! -e $dst_host/$src_host ]]; then
  echo "Create backup dir"
  mkdir $dst_host/$src_host
fi

# Check directory for current date
today=$(date +%Y-%m-%d)
if [[ ! -e $dst_host/$src_host/$today ]]; then
  echo "Create backup daily dir"
  mkdir $dst_host/$src_host/$today
fi

for path in $backups; do
  echo "Backup of $path to $dst_host/$src_host/$today"
  cp -r $path $dst_host/$src_host/$today
done

