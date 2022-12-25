#!/bin/bash
# author: tristan garside
# create a text file that can be used by ssmtp
#  to send an email
DIR_PATH=/home/josh/techmate-gdrive-backup

TO="To: josh@techmate.org.nz"
SUBJECT="Subject: Google-Drive Backup Logs"
BODY="This is an Automated email\n\n"
BODY+="Backup Logs for last 7 entries follows:\n"
BODY+=$(cat $DIR_PATH/backup.log | tail -7)
# check if any errors thrown by rclone  
if [ -s $DIR_PATH/error.log ]; then
	BODY+="\n...\nError Log:\n"
	BODY+=$(cat $DIR_PATH/error.log)
else
	BODY+="\n...\nrclone reports no errors\n"
fi
echo -e "$TO\n$SUBJECT\n$BODY" > $DIR_PATH/auto-email.txt
