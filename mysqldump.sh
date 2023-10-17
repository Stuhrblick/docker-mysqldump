#!/bin/bash

# Check if all environment variables are set
if [ -z "$DB_HOST" ] || [ -z "$DB_PORT" ] || [ -z "$DB_USER" ] || [ -z "$DB_PASSWORD" ] || [ -z "$DB_NAME" ] || [ -z "$DUMP_INTERVAL" ] || [ -z "$DUMP_DIR" ] || [ -z "$RETENTION_DAYS" ]; then
    echo "One or more required environment variables are not set. Please ensure all required variables are set."
    exit 1
fi

# Function to dump the MySQL database
dump_database() {
    mysqldump -h$DB_HOST -P$DB_PORT -u$DB_USER -p$DB_PASSWORD $DB_NAME > $DUMP_DIR/$(date +"%Y%m%d%H%M%S")_$DB_NAME.sql
    echo "Database dump completed."
}

# Function to delete old dumps
delete_old_dumps() {
    find $DUMP_DIR -type f -name "*_$DB_NAME.sql" -mtime +$RETENTION_DAYS -exec rm {} +
    echo "Old dumps deleted."
}

# Dump the database at the specified interval and delete old dumps
while true; do
    dump_database
    delete_old_dumps
    sleep $DUMP_INTERVAL
done
