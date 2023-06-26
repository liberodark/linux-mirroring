#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/debian-security"
TMP="${HOME}/.tmp/debian-security"
LOCK="/tmp/rsync-debian-security.lock"
USER="apache"

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

rsync --exclude 'source*' \
    --exclude '*.debian.tar.xz' \
    --exclude '*.orig.tar.xz' \
    --exclude '*.orig.tar.bz2' \
    --exclude '*.dsc' \
    --exclude '*_arm64.deb' \
    --exclude '*_armel.deb' \
    --exclude '*_armhf.deb' \
    --exclude '*_i386.deb' \
    --exclude '*_mips.deb' \
    --exclude '*_mips64el.deb' \
    --exclude '*_mipsel.deb' \
    --exclude '*_ppc64el.deb' \
    --exclude '*_s390x.deb' \
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
