#!/bin/sh

set -e

BACKUP_NAME="${SALVAGE_MACHINE_NAME}_${SALVAGE_CRANE_NAME}_${SALVAGE_VOLUME_NAME}"
BACKUP_PATH="${SALVAGE_MACHINE_NAME}/${SALVAGE_CRANE_NAME}/${SALVAGE_VOLUME_NAME}"
ENCRYPTION_KEY_BASE64="${ENCRYPTION_KEY_BASE64}"
CUSTOM_CMDLINE="${CUSTOM_CMDLINE}"
ACTION="{ACTION:-incr}"

if [ -z "$ENCRYPTION_KEY_BASE64" ]; then
	echo "no encryption key given"
	exit 1
fi

# unpack encryption key
echo "${ENCRYPTION_KEY_BASE64}" | base64 -d | gpg --import

# just in case you ever wondered why no one is using gpg - this monstrosity is why
ENCRYPTION_KEY_ID=$(gpg --list-key --keyid-format=short | grep 'pub ' | cut -d'/' -f2 | cut -d' ' -f 1)
echo "Imported encryption key '${ENCRYPTION_KEY_ID}'"

echo "Picked up additional command line flags: ${CUSTOM_CMDLINE}"

# enable echo
set -x
duplicity \
	--allow-source-mismatch \
	--gpg-options "--trust-model=always" \
	--archive-dir "/cache" \
	--encrypt-key "${ENCRYPTION_KEY_ID}" \
	--name "${BACKUP_NAME}" \
	${CUSTOM_CMDLINE} \
	"/salvage/" \
	"${TARGET}/${BACKUP_PATH}"
