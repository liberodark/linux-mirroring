#!/bin/bash
# This is a sample mirroring script.
HOME="/tmp/http"
TARGET="${HOME}/debian"
TMP="${HOME}/.tmp/debian"
LOCK="/tmp/rsync-debian.lock"

# NOTE: You'll probably want to change this or remove the --bwlimit setting in
# the rsync call below
BWLIMIT=10000

SOURCE="rsync://archive.debian.org/debian-archive/debian/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync -rtlvH --safe-links \
    --bwlimit=${BWLIMIT} \
    --delete-after --progress \
    -h ${QUIET} --timeout=600 --contimeout=120 -p \
    --delay-updates --no-motd \
    --temp-dir="${TMP}" \
    ${SOURCE} \
    "${TARGET}"
