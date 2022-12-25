#!/bin/bash
# author tristan garside, tristan@techmate.org.nz

# rclone *sync* maintains destination (local backup) as exact copy of original,
#  i.e deletes files if they are deleted from source (Google Drive) 
# In contrast rclone *copy* retains all files in backup, including those 
#  deleted in source dir. 


# --progress option gives verbose feedback
# SOURCE name is "google-drive" - is rclone name for remote (Google Drive) 
# DESTINATION is local directory in User's home directory 

# /dev/sdc is automatically mounted to Google-Drive-Backup/ 
# 	as specified in /etc/fstab  

DIR=/home/josh/techmate-gdrive-backup

if [ $# -eq 0 ]
  then
    echo "No arguments supplied - valid args are copy or sync" >> $DIR/backup.log
	exit
fi

BACKUP_PATH=/home/josh/Google-Drive-Backup/

if [ $1 == "copy" ]; then
	rclone copy --progress \
	--log-level ERROR \
	--log-file $DIR/error.log \
	 google-drive: $BACKUP_PATH
elif [ $1 == "sync" ]; then 
	rclone sync --progress \
	--log-level ERROR \
	--log-file $DIR/error.log \
	 google-drive: $BACKUP_PATH
else
	echo invalid argument provided to google-drive-backup-script at $(date) >> $DIR/backup.log 
	exit
fi

# keep a log of backup
BLOCK_SIZE=$(df --output=used $BACKUP_PATH | tail -1)
SIZE_GB=$(df -h --output=used $BACKUP_PATH | tail -1)
NUM_FILES=$(find $BACKUP_PATH -type f | wc -l)
DATETIME=$(date +%T-%F) 
echo Script run at $DATETIME: Mode = $1, Backup Directory: $BLOCK_SIZE blocks \($SIZE_GB \), $NUM_FILES files >> $DIR/backup.log 
