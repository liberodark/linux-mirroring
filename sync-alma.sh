#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/alma"
TMP="${HOME}/.tmp/alma"
LOCK="/tmp/rsync-alma.lock"
USER="apache"

# NOTE: You'll probably want to change this or remove the --bwlimit setting in
# the rsync call below
BWLIMIT=10000

SOURCE="rsync://rsync.repo.almalinux.org/almalinux/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync --exclude 'isos' \
    --exclude '*.iso' \
    --exclude '8.*-beta' \
    --exclude '8.*-rc' \
    --exclude 'i386*' \
    --exclude 'aarch64'	\
    --exclude 'ppc64le'	\
    --exclude 's390x'	\
    --exclude 'raspberrypi' \
    --exclude 'Source'	\
    --exclude 'debug'	\
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
