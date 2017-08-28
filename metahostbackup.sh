#!/bin/bash

# Number of rolling backup copies to retain
RETENTION=3
# IP Address of your NFS server
NFS_SERVER_IP="192.168.152.10"
# NFS share location for xen pool metadata & host backups
FILE_LOCATION_ON_NFS="/volume1/VM/Backup"

DATE=`date +%d%b%Y_%H%M%S`
XSNAME=`echo $HOSTNAME`
MOUNTPOINT=/xenmnt
xencmd="/opt/xensource/bin/xe"

# Create mount point
if [ ! -e "${MOUNTPOINT}" ]; then
	mkdir -p "${MOUNTPOINT}"
elif [ ! -d ${MOUNTPOINT} ]; then
	echo "No mount point found, kindly check" && exit 0
fi

# Mounting remote nfs share backup drive
mount -t nfs ${NFS_SERVER_IP}:${FILE_LOCATION_ON_NFS} ${MOUNTPOINT}
BACKUPPATH=${MOUNTPOINT}/${XSNAME}

mkdir -p ${BACKUPPATH}
if [ ! -d ${BACKUPPATH} ]; then
	echo "No backup directory found" && exit 0
fi

# Backup xenserver host & pool metadata
$xencmd host-backup file-name="$BACKUPPATH/$DATE-$XSNAME-host.bak" host=${XSNAME}
$xencmd pool-dump-database file-name="$BACKUPPATH/$DATE-$XSNAME-metadata.bak"

# Retention by depth & keeps recent 5 files
BACKUPPATHHFILTER="$BACKUPPATH/*.bak"
let RETENTIONDEPTH="2*$RETENTION"

# Trim command to retain last n-copies defined in the RETENTION variable - BE CAREFUL WITH MODIFYING THIS COMMAND! 
ls -tr $BACKUPPATHHFILTER | head -n -$RETENTIONDEPTH | xargs --no-run-if-empty rm

umount ${MOUNTPOINT}