# sysbackup
Sysbackup of linux hosts, configured directory list, run by cron.


## Mountpoint on your system:

    mkdir /mnt/mymount
  
    sudo mount -t nfs backuphost.domain.ch:/volume1/backup /mnt/mymount

Install nfs-utils before (Rocky Linux):

    dnf install nfs-utils


Settings on NFS-Host:

Squash: Map all users to admin
