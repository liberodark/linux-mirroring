#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/rsyslog"
TMP="${HOME}/.tmp/rsyslog"
LOCK="/tmp/rsync-rsyslog.lock"

SOURCE="http://rpms.adiscon.com/v8-stable/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

pushd "${TARGET}" || exit
wget --mirror \
    --no-parent \
    --cut-dirs=1 \
    --exclude-directories=epel-5 \
    --exclude-directories=epel-6 \
    --exclude-directories=i386 \
    ${SOURCE}
rm -f rpms.adiscon.com/rsyslog.repo
rm -rf rpms.adiscon.com/index.html*
popd || exit
