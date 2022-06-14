#!/bin/sh


echo "I'm crane ${SALVAGE_CRANE_NAME} supposed to be backing up ${SALVAGE_VOLUME_NAME} on ${SALVAGE_HOST_NAME}"
echo "I'm currently running in $(pwd)"
cat "/salvage/meta/meta.json"
echo "Let's look at the backup"
ls -lA "/salvage/volume"
echo "Now I will wait for you to exec into me daddy"
sleep 5