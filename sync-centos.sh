#!/bin/sh
# This is a sample mirroring script.
HOME="/tmp/http"
TARGET="${HOME}/centos"
TMP="${HOME}/.tmp/centos"
LOCK="/tmp/rsync-centos.lock"

# NOTE: You'll probably want to change this or remove the --bwlimit setting in
# the rsync call below
BWLIMIT=10000

SOURCE="rsync://ftp.pasteur.fr/mirrors/CentOS/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync --exclude 'isos' \
    --exclude 'i386*' \
    --exclude '2' \
    --exclude '2.*' \
    --exclude '3' \
    --exclude '3.*' \
    --exclude '4' \
    --exclude '4.*' \
    --exclude '5' \
    --exclude '5.*' \
    --exclude '6' \
    --exclude '6.*' \
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
