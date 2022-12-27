## Testing restoration procedure

To test the restoration procedure create a directory "BACKUP-TEST" and
populate it with nested empty files and directories, to see if files can
be restored, and in addition if directory structure is preserved

###  Procedure

1. Create BACKUP-TEST directory (with nested inner directories and files)
in the google-drive shared directory
2. Allow the BACKUP-TEST directory to be backed in the usual scheduled cronjob
3. Delete the BACKUP-TEST directory from the google-drive shared directory
4. Attempt to restore the deleted BACKUP-TEST directory from `Google-Drive-Backup` to google drive
5. Attempt same to a local  machine on network:
6. Observe results noting restoration and reservation (or flattening) of structure

### Commands
BACKUP-TEST to google-drive:<br/><br/>
```$ rclone copy --progress /home/josh/Google-Drive-Backup/Techmate\ things./BACKUP-TEST/ google-drive```
<br/><br/>
BACKUP-TEST to local machine:<br/><br/>
```$ rclone copy --progress /home/josh/Google-Drive-Backup/Techmate\ things./BACKUP-TEST/ <host-ip>:/<path-to-folder>/```


### Test run
- Date TBD
