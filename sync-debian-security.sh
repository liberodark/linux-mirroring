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

SOURCE="rsync://ftp.fr.debian.org/debian-security/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

rsync #--exclude 'alpha*' \
    --exclude '*arm64.deb' \
    --exclude '*armel.deb' \
    --exclude '*armhf.deb' \
    #--exclude 'hppa*' \
    #--exclude 'hurd-i386*' \
    --exclude '*i386.deb' \
    --exclude 'ia64*' \
    #--exclude 'kfreebsd-amd64*' \
    #--exclude 'kfreebsd-i386*' \
    #--exclude 'm68k*' \
    --exclude '*mipsel.deb' \
    --exclude '*powerpc.deb' \
    --exclude '*s390.deb' \
    --exclude '*s390x.deb' \
    --exclude 'sh*' \
    --exclude 'sparc*' \
    --exclude 'source*' \
    --exclude 'binary-arm64*' \
    --exclude 'binary-armel*' \
    --exclude 'binary-armhf*' \
    --exclude 'binary-i386*' \
    --exclude 'binary-mips*' \
    --exclude 'binary-mips64el*' \
    --exclude 'binary-mipsel*' \
    --exclude 'binary-ppc64el*' \
    --exclude 'binary-s390x*' \
    --exclude 'installer-arm64*' \
    --exclude 'installer-armel*' \
    --exclude 'installer-armhf*' \
    --exclude 'installer-i386*' \
    --exclude 'installer-mips*' \
    --exclude 'installer-mips64el*' \
    --exclude 'installer-mipsel*' \
    --exclude 'installer-ppc64el*' \
    --exclude 'installer-s390x*' \
    --exclude 'Contents-arm64*' \
    --exclude 'Contents-armel*' \
    --exclude 'Contents-armhf*' \
    --exclude 'Contents-i386*' \
    --exclude 'Contents-mips*' \
    --exclude 'Contents-mips64el*' \
    --exclude 'Contents-mipsel*' \
    --exclude 'Contents-ppc64el*' \
    --exclude 'Contents-s390x*' \
    --exclude 'Contents-udeb-arm64*' \
    --exclude 'Contents-udeb-armel*' \
    --exclude 'Contents-udeb-armhf*' \
    --exclude 'Contents-udeb-i386*' \
    --exclude 'Contents-udeb-mips*' \
    --exclude 'Contents-udeb-mips64el*' \
    --exclude 'Contents-udeb-mipsel*' \
    --exclude 'Contents-udeb-ppc64el*' \
    --exclude 'Contents-udeb-s390x*' \
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