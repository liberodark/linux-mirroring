#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/shibboleth"
TMP="${HOME}/.tmp/shibboleth"
LOCK="/tmp/rsync-shibboleth.lock"

SOURCE="https://shibboleth-mirror.cdi.ti.ja.net/CentOS_7/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

pushd "${TARGET}" || exit
wget --mirror \
    --no-parent \
    --cut-dirs=1 \
    ${SOURCE}
sudo rm -r shibboleth-mirror.cdi.ti.ja.net/index.html*
popd || exit
