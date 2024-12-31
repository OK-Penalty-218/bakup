# Ubuntu Backup Package
This package provides automated backups for Ubuntu and Debian-based systems.


## Installation
Install globally using npm:
```bash
npm install -g @ok-penalty-218/ubuntu-bakup@latest
```

## Post-Insallation
Run command ```bakup``` to verify functionality.

## Configuration
Default Config File Location: ```\etc\bakup\config.json```<br>
Default Backup Location: ```~\bakup```<br>
Edit the Config file to change preferred backup location, source directories, and number of backups kept.

### Crontab
By Default this package will enable the following crontab jobs under the root user:
```bash
# m h  dom mon dow   command
0 4 * * 7 /usr/local/bin/bakup-weekly #Runs a weekly backup every Sunday at 4am.
0 3 * * * /usr/local/bin/bakup-daily #Runs a daily backup at 3am.
0 * * * * /usr/local/bin/bakup-hourly #Runs an hourly backup at the top of every hour. 
```

## Other Functionality
This package has 4 different types of backups: manual, hourly, daily, and weekly.<br>
To remove all, but 1 of each type of backup files run command: ```bakup-autoremove```<br>
To purge all backup files run command: ```bakup-purge```
