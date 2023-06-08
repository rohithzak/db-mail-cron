#!/bin/bash

# Naming the dumpfile
filename=dumpfile.$(date +"%m-%d-%Y").sql

#Taking the backup of DB
pg_dump -U postgres -d db_name > /backup/$filename 
	if [ $? -eq 0 ]; then
         /usr/local/bin/aws --profile s3backup s3 cp /backup/$filename s3://cri-backups/db-backups/ 
        else
		/usr/bin/python3 mail.py FAILED "SQL dump unsuccessful for hotcri"
		exit 1
        fi                                                             #Checks if the backup-process is completed successfully and sends mail in failure and push to s3 in success

/usr/bin/python3 mail.py SUCCESSFUL "Pushed to S3 Successfully"  #After pushing to s3, sends mail with success message

rm -f /backup/$filename    #Removes the backup from local server after pushing to s3

