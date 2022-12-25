Techmate Backup Guide 2022
==========================

ceated by: Tristan Garside | tristan@techmate.org.nz  
date: 19-08-2022

* * *

### Introduction

The Backup scripts used in this project rely on three main utility programs:

1.  [rclone](https://rclone.org) - for transferring data from cloud to local storage
2.  [cron](https://docs.fedoraproject.org/en-US/packaging-guidelines/CronFiles/) - scheduling the running of scripts
3.  [ssmtp](https://wiki.archlinux.org/title/SSMTP) - for automating an email summary of the status
    

There are two main BASH scripts that do the heavy lifting in the project currently located in the folder `/home/josh/rclone` on the Fedora Linux Server:

1.  `google-drive-backup.sh`
2.  `email-composer.sh`
    

The `micro` text editor is installed for ease of use (standard microsoft shortcuts) but any editor can be used to edit scripts / text files e.g.

`$ micro google-drive-backup.sh`  
`$ nano google-drive-backup.sh`  
etc.

* * *

### Use Case

All files that are saved in Google-Drive (currently in Josh’s account) need to backed up to the on-site server to protect from accidental deletion / loss / corruption etc.

An `rclone copy` of all the data is transferred daily at ascheduled time.

Periodically (e.g. every 3 months) an `rclone sync` operation may be performed to clear out deleted files / junk files that have been removed from the master copy (The Google Drive)

File(s) can be recovered from the backup by several methods (see below)

* * *

Installation and Configuration of Utilities

[rclone](https://rclone.org)

### Installation

The version currently installed is from the Fedora Linux repository and was installed by running `sudo dnf install rclone`

### Configuration

The setup of rclone with Google Drive is done by a simple wizard in the terminal: https://rclone.org/drive/

NB If the server is headless (currently true) then providing access with Google a/c credentials requires selecting  

`Use auto config? No`  

and accessing the provided URL from a machine with a browser

### Usage

The two commands within the backup script employed are:

1.  `rclone copy` - transfers all files from SOURCE to DESTINATION and preserves all previously transferred files regardless of if they still exist at SOURCE
2.  `rclone sync` - transfers all files from SOURCE to DESTINATION, deleting any files in DESTINATION that do not exist in SOURCE - i.e. an exact mirror version.

The `google-drive-backup.sh` script also provides a couple of options to supply verbose output and write any errors with `rclone` to a log

https://rclone.org

* * *

[cron](https://docs.fedoraproject.org/en-US/packaging-guidelines/CronFiles/)

Intallation: This utility is included as a standard program in GNU/Linux

The scheduling “table” can be edited by running  
`$ crontab -e`

The table can be viewed without editing by  
`$ crontab -l`

N.B. each user on the server may have their own crontab - to edit the correct crontab you will need to be logged in as `josh`

https://docs.fedoraproject.org/en-US/packaging-guidelines/CronFiles

* * *

[ssmtp](https://wiki.archlinux.org/title/SSMTP)

This utility is a very simple email server that can only send email. This avoids the configuration headaches associated with `postfix` or `sendmail`

NB _This project is unmaintaned - may need replacing with alternative_  

### Installation

`$ sudo dnf install ssmtp`

### Configuration

`ssmtp` allows you to send the automated email from you GMail with the correct authentication. However your regular password cannot be used.
 From May 2022 Google requires that you create an “App Password”:

https://www.lifewire.com/get-a-password-to-access-gmail-by-pop-imap-2-1171882

The username and password need to be accessed from the config file at `/etc/ssmtp/ssmtp.config`. The following entries seem to work:

`root=postmaster`  
`mailhub=smtp.gmail.com:587`  
`AuthUser=<example>@techmate.org.nz`  
`AuthPass=<example's App password here>`  
`UseTLS=Yes`  
`UseSTARTTLS`  

The entry in the crontab needs to include the MAILTO line.

* * *

Source Files and Recovery / Migration of Project

This document should have enough detail to set up the preject again on a different GNU/Linux machine.

The project can be cloned into the Admin Users home folder with git:  
`$ git clone https://github.com/techmateTristan/techmate-gdrive-backup.git`

All the files required are located in the directory `/home/josh/rclone`. Included is a backup / reference file `crontab.bak`
 which can be pasted into new table using `$ crontab -e`

* * *

  

Backup Recovery Options
=======================

These instructions are specific to our tools in 2022 but can be applied more generally too.  
Here are a few options:

Quick and Elegant - copy over local network

Simply reverse SOURCE and DESTINATION order using rclone

Recover to Google-Drive \*need to test:  
`$ rclone copy --progress /home/josh/Google-Drive-Backup/ google-drive`

Or to machine on local network \*need to test  
`$ rclone copy --progress /home/josh/Google-Drive-Backup/ host:/<path-to-folder>`

Quick and Dirty - Copy Backup to external HDD

1.  plug in “Big Red” external HDD drive
2.  `ssh` into `/home/josh`  
    
3.  double check which device ID Big Red has  
    `$ lsblk` and identify by size - 1.8T- (currently `/dev/sdc1`)
4.  Mount drive:  
    `$ sudo mount /dev/sdc1 /home/josh/big-red-mountpoint`
5.  copy drive contents over  
    `$ rsync -arv --progress Google-Drive-Backup/* big-red-mountpoint`
6.  For extra safety  
    `$ sudo umount /dev/sdc1` before unplugging Big Red HDD

Last Resort

Shutdown server, unplug and remove internal HDD “WDC” brand to access via recovery rig. Filesystem is ext4 so easiest to access via Linux machine.

* * *
