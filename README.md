# Sysbackup
I need a smiple backup script to just backup Linux directories to my NAS on cronjob base.

Script will mount the remote filesystem on every run - it doesn't need a fix fstab entry for persistent
storage.

Create and configure mountpoints before.

## Mountpoint on your system:

    mkdir /mnt/mymount
  
    sudo mount -t nfs backuphost.domain.ch:/volume1/backup /mnt/mymount

Install nfs-utils before (Rocky Linux):

    dnf install nfs-utils


Settings on NFS-Host:

Squash: Map all users to admin
