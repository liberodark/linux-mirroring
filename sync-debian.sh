#!/bin/sh
# This is a sample mirroring script.
HOME="/tmp/http"
TARGET="${HOME}/debian"
TMP="${HOME}/.tmp/debian"
LOCK="/tmp/rsync-debian.lock"
ARCH_EXCLUDE="alpha arm armel armhf hppa hurd-i386 i386 ia64 kfreebsd-amd64 kfreebsd-i386 m68k mipsel mips powerpc s390 s390x sh sparc source"
rsync_exclude=""
for item in $ARCH_EXCLUDE; do
    rsync_exclude="$rsync_exclude --exclude $item"
done

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

rsync $rsync_exclude \
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
