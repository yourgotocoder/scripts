                        #!/bin/bash
DATE=$(date +%d-%m-%Y)

# mount extra hdd to the mounting point that you created
sudo mount /dev/sdb1 /media/mountpoint_a/

# take backup with dates
tar -zcvpf /media/mountpoint_a/cse-$DATE.tar.gz /home/cse/

# Delete files older than 10 days #
find $BACKUP_DIR/* -mtime +10 -exec rm {} \;

# unmount after backup is complete, -l flag waits for all processes to be 
# done on the mounted drive
sudo umount -l /dev/sdb1

