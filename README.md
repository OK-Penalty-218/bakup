# Ubuntu Backup Package
This package provides automated backups for Ubuntu and Debian-based systems.


## Installation
Install globally using npm:<br>
```bash 
npm install -g @ok-penalty-218/ubuntu-bakup@1.2.4
```
or<br>
```bash
npm install -g https://github.com/OK-Penalty-218/bakup.git
```

## Configuration Setup
Default Config File Location: ```\etc\bakup\config.json```<br>
Default Backup Location: ```~\bakup```<br>
Edit the Config file to change preferred backup location, source directories, and number of backups kept.

## Post-Insallation/Configuration
Run command ```bakup``` to verify functionality. The command will run a manual backup.

### Crontab
By Default this package will enable the following crontab jobs under the root user:
```bash
# m h  dom mon dow   command
0 4 * * 7 /usr/local/bin/bakup-weekly #Runs a weekly backup every Sunday at 4am.
0 3 * * * /usr/local/bin/bakup-daily #Runs a daily backup at 3am.
0 * * * * /usr/local/bin/bakup-hourly #Runs an hourly backup at the top of every hour. 
```

Use command ```sudo crontab -e``` to edit your crontab jobs or change the times at which your bakups run.

## Other Functionality
This package has 4 different types of backups: manual, hourly, daily, and weekly.<br>
To remove all bakup files, but leave 1 of each type of backup run command: ```bakup-autoremove```<br>
To purge all backup files run command: ```bakup-purge```<br>
To do a manual backup run command: ```bakup```<br>

### Notes
It is recommended that you run all commands with ```sudo``` to avoid running into permission issues.
