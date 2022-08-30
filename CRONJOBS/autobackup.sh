#!/bin/bash
DATE=$(date +%d-%m-%Y)
BACKUP_DIR=”/backup”

# take backup in separate name, use below format #
tar -zcvpf $BACKUP_DIR/yeahhub-$DATE.tar.gz /home/cse/

# Delete files older than 10 days #
find $BACKUP_DIR/* -mtime +10 -exec rm {} \;

