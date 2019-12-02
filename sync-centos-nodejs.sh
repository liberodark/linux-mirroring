#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/nodejs"
TMP="${HOME}/.tmp/nodejs"
LOCK="/tmp/rsync-nodejs.lock"

SOURCE="https://rpm.nodesource.com/pub_13.x/el/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

pushd "${TARGET}" || exit
wget --mirror \
    --no-parent \
    --cut-dirs=1 \
    --exclude-directories='/pub_13.x/el/6' \
    ${SOURCE}
sudo rm rpm.nodesource.com/index.html
popd || exit
