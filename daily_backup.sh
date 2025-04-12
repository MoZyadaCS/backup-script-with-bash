SOURCE_DIR="/etc"                            # What to back up
BACKUP_DIR="/opt/backups"                    # Where backups go
LOG_DIR="/var/log/backup_script"             # Where logs go
RETENTION_DAYS=7                             # How many backups to keep
LOG_RETENTION=5                              # How many logs to keep
EMAIL="mostafazyada1999@gmail.com"               # Your email for alerts

DATE=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/backup_$DATE.tar.gz"
LOG_FILE="$LOG_DIR/backup_$DATE.log"
ERROR_FLAG=0

exec > >(tee -a "$LOG_FILE") 2>&1

echo "[$DATE] Starting backup..."

if tar -czf "$BACKUP_FILE" "$SOURCE_DIR"; then
    echo "Backup successful: $BACKUP_FILE"
else
    echo "Backup failed!"
    ERROR_FLAG=1
fi

echo "Cleaning old backups..."
find "$BACKUP_DIR" -type f -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -exec rm {} \;

echo "Rotating logs..."
ls -tp "$LOG_DIR"/backup_*.log | grep -v '/$' | tail -n +$((LOG_RETENTION + 1)) | xargs -I {} rm -- {}

if [ "$ERROR_FLAG" -ne 0 ]; then
    echo "Sending alert email..."
    echo "Backup failed on $(hostname) at $DATE. Check $LOG_FILE for details." | mail -s "[Backup Failure] $(hostname)" "$EMAIL"
fi

echo "[$DATE] Backup script finished."
