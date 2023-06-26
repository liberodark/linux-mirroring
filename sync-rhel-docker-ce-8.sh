#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/docker/centos/8"
TMP="${HOME}/.tmp/docker"
LOCK="/tmp/docker.lock"
USER="apache"

SOURCE="https://download.docker.com/linux/centos/8/x86_64/stable/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

wget --mirror \
    --no-parent \
    --cut-dirs=5 \
    ${SOURCE}

pushd download.docker.com || exit
sudo cp -a * "${TARGET}" || exit
popd || exit
sudo rm -r download.docker.com
chown -R "$USER":"$USER" "$HOME" || exit
