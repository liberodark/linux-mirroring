#!/bin/sh
# This is a sample mirroring script.
HOME="/tmp/http"
TARGET="${HOME}/debian"
TMP="${HOME}/.tmp/debian"
LOCK="/tmp/rsync-debian.lock"
#EXCLUDE="${alpha arm armel armhf hppa hurd-i386 i386 ia64 kfreebsd-amd64 kfreebsd-i386 m68k mipsel mips powerpc s390 s390x sh sparc source}"

# NOTE: You'll probably want to change this or remove the --bwlimit setting in
# the rsync call below
BWLIMIT=10000

SOURCE="rsync://ftp.fr.debian.org/debian/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync --exclude '*alpha*' \
    --exclude '*arm*' \
    --exclude '*armel*' \
    --exclude '*armhf*' \
    --exclude '*hppa*' \
    --exclude '*hurd-i386*' \
    --exclude '*i386*' \
    --exclude '*ia64*' \
    --exclude '*kfreebsd-amd64*' \
    --exclude '*kfreebsd-i386*' \
    --exclude '*m68k*' \
    --exclude '*mipsel*' \
    --exclude '*powerpc*' \
    --exclude '*s390*' \
    --exclude '*s390x*' \
    --exclude '*sh*' \
    --exclude '*sparc*' \
    --exclude '*source*' \
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
