#!/bin/bash

# Naming the dumpfile
filename=dumpfile.$(date +"%m-%d-%Y").sql

#Taking the backup of DB
pg_dump -U user -d db_name > /backup/$filename 
	if [ $? -eq 0 ]; then
         /usr/local/bin/aws  s3 cp /backup/$filename s3://bucket-name/folder 
        else
		/usr/bin/python3 mail.py <sender mail ID> FAILED "SQL dump unsuccessful"  # FAILED and sql sump unsuccessful are my parmaeter of choice, you can modify as per your requirement
		exit 1
        fi                                                             #Checks if the backup-process is completed successfully and sends mail in failure and push to s3 in success

/usr/bin/python3 mail.py <Sender mail ID> SUCCESSFUL "Pushed to S3 Successfully"  #After pushing to s3, sends mail with success message( You can give you parameter as per your preference)

rm -f /backup/$filename    #Removes the backup from local server after pushing to s3

