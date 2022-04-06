#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/remi"
TMP="${HOME}/.tmp/remi"
LOCK="/tmp/rsync-remi.lock"

# NOTE: You'll probably want to change this or remove the --bwlimit setting in
# the rsync call below
BWLIMIT=10000

SOURCE="rsync://fr2.rpmfind.net/linux/remi/enterprise/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync --exclude 'test*' \
    --exclude '2' \
    --exclude '2.*' \
    --exclude '3' \
    --exclude '3.*' \
    --exclude '4' \
    --exclude '4.*' \
    --exclude '5' \
    --exclude '5.*' \
    --exclude '5Client' \
    --exclude '5Server' \
    --exclude '6' \
    --exclude '6.*' \
    --exclude '6Client' \
    --exclude '6Server' \
    --exclude '6Workstation' \
    --exclude '6Workstation' \
    --exclude '7.3' \
    --exclude '7.4' \
    --exclude '7.5' \
    --exclude '7.6' \
    --exclude '7.7' \
    --exclude '7Client' \
    --exclude '7Server' \
    --exclude '7Workstation' \
    --exclude '7Workstation' \
    --exclude '6.*' \
    --exclude 'composer2-test' \
    --exclude 'debug-modular*' \
    --exclude 'debug-php*' \
    --exclude 'debug-redis*' \
    --exclude 'debug-remi' \
    --exclude 'debug-test*' \
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

chown -R apache: /var/www/mirror/
