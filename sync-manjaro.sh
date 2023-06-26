#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/manjaro"
TMP="${HOME}/.tmp/manjaro"
LOCK="/tmp/rsync-manjaro.lock"
USER="apache"

# NOTE: You'll probably want to change this or remove the --bwlimit setting in
# the rsync call below
BWLIMIT=10000

SOURCE="rsync://ftp.halifax.rwth-aachen.de/manjaro/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync --exclude 'stable-staging' \
    --exclude 'testing' \
    --exclude 'unstable' \
    --exclude 'x32-stable' \
    --exclude 'x32-testing' \
    --exclude 'x32-unstable' \
    --exclude 'arm-stable' \
    --exclude 'arm-testing' \
    --exclude 'arm-unstable' \
    --exclude 'kde-unstable' \
    --exclude 'sync-arm' \
    --delete-excluded \
    -rtlvH \
    --safe-links \
    --bwlimit="${BWLIMIT}" \
    --delete-after --progress \
    -h ${QUIET} \
    --timeout=600 \
    --contimeout=120 -p \
    --delay-updates \
    --no-motd \
    --temp-dir="${TMP}" \
    "${SOURCE}" \
    "${TARGET}" || exit

chown -R "$USER":"$USER" "$HOME" || exit
