                        #!/bin/bash
DATE=$(date +%d-%m-%Y)
BACKUP_DIR='/media/mountpoint_a'
# mount extra hdd to the mounting point that you created
sudo mount /dev/sdb1 $BACKUP_DIR/

# take backup with dates
tar --exclude=".*" -zcvpf $BACKUP_DIR/cse-$DATE.tar.gz /home/cse/

# Delete files older than 10 days #
find $BACKUP_DIR/* -mtime +10 -exec rm {} \;




