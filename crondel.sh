#!/bin/bash

timeago='30 days ago'

for dir in /sftp-root/*; do
  user=`echo ${dir} | cut -d/ -f3`

  if [ $user == 'dev' ]; then
    continue;
  fi

  createdDate=`passwd -S ${user} | cut -d' ' -f3`

  createdDateInSeconds=`date +"%s" -d "$createdDate"`
  timeagoSeconds=`date +"%s" -d "$timeago"`

  if [ $createdDateInSeconds -lt $timeagoSeconds ]; then
    docker exec -it sftp rmsftpuser ${user}
  fi
done
