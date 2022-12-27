## Testing restoration procedure

To test the restoration procedure create a directory "BACKUP-TEST" and
populate it with nested fire and directories, to see if files can
be restored, and in addition if directory structure is preserved

###  Procedure

1. Create BACKUP-TEST directory (with nested inner directories and files)
in the google-drive shared directory
2. Allow the BACKUP-TEST directory to be backed in the usual scheduled cronjob
3. Delete the BACKUP-TEST directory from the google-drive shared dirctory
4. Attempt to restore the deleted BACKUP-TEST directory from back up by running:
```	$ rclone copy --progress /home/josh/Google-Drive-Backup/BACKUP-TEST/ google-drive```
5. Attempt same to local machine on network:
```$ rclone copy --progress /home/josh/Google-Drive-Backup/BACKUP-TEST/ host:/<path-to-folder>```
6. Observe results noting restoration and reservation of structure

### Test run
- Date TBD
