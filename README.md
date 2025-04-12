### 🛠 Backup Script

---

#### ✅ How to Run and Test the Script

1. **Run the script manually:**
   ```bash
   sudo ./backup.sh
   ```
2. **Check the backup output:**
   - Backup files are stored in the `BACKUP_DIR` as `.tar.gz` archives.
   - Logs are stored in the `LOG_DIR`.

3. **Set up daily automation:**
   - Open crontab:
     ```bash
     crontab -e
     ```
   - Add this line to run daily at midnight:
     ```bash
     0 0 * * * /path/to/backup.sh
     ```

---

#### ⚙️ How to Configure Paths and Retention

- Open the script and modify the following variables at the top:

  ```bash
  BACKUP_SRC="/etc"               # Directory to back up
  BACKUP_DIR="/opt/backups"       # Where to store backups
  LOG_DIR="/opt/backup-logs"      # Log storage
  RETENTION_DAYS=7                # Number of backup days to keep
  LOG_RETENTION=5                 # Number of logs to keep
  ALERT_EMAIL="your@email.com"    # Alert email on failure
  ```

---

#### 🚨 How to Test the Failure Alert

1. **Force a failure:**
   - Try changing the backup source to a restricted folder without `sudo`, e.g.:
     ```bash
     BACKUP_SRC="/root"
     ```

2. **Run the script without `sudo`:**
   ```bash
   ./backup.sh
   ```
