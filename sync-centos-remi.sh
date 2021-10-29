#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/remi"
TMP="${HOME}/.tmp/remi"
LOCK="/tmp/rsync-remi.lock"
USER="apache"

# NOTE: You'll probably want to change this or remove the --bwlimit setting in
# the rsync call below
BWLIMIT=10000

SOURCE="rsync://fr2.rpmfind.net/linux/remi/enterprise/7/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync --exclude 'test' \
    --exclude 'test70' \
    --exclude 'test71' \
    --exclude 'test72' \
    --exclude 'test73' \
    --exclude 'test74' \
    --exclude 'test80' \
    --exclude 'debug-php55' \
    --exclude 'debug-php56' \
    --exclude 'debug-php70' \
    --exclude 'debug-php71' \
    --exclude 'debug-php72' \
    --exclude 'debug-php73' \
    --exclude 'debug-php74' \
    --exclude 'debug-php80' \
    --exclude 'debug-remi' \
    --exclude 'debug-test' \
    --exclude 'debug-test70' \
    --exclude 'debug-test71' \
    --exclude 'debug-test72' \
    --exclude 'debug-test73' \
    --exclude 'debug-test74' \
    --exclude 'debug-test80' \
    --exclude 'modular-test' \
    --exclude 'aarch64' \
    --exclude 'armhfp' \
    --delete-excluded \
    -rtlvH \
    --safe-links \
    --bwlimit=${BWLIMIT} \
    --delete-after --progress \
    -h ${QUIET} \
    --timeout=600 \
    --contimeout=120 -p \
    --delay-updates \
    --no-motd \
    --temp-dir="${TMP}" \
    ${SOURCE} \
    "${TARGET}"

chown -R "$USER":"$USER" "$HOME"
