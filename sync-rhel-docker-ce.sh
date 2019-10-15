#!/bin/sh
# This is a sample mirroring script.
HOME="/tmp/http"
TARGET="${HOME}/docker"
TMP="${HOME}/.tmp/docker"
LOCK="/tmp/docker.lock"

SOURCE="https://download.docker.com/linux/centos/7/x86_64/stable/"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

wget --mirror \
    --no-parent \
    --cut-dirs=5 \
    ${SOURCE}

pushd download.docker.com || exit
sudo mv * "${TARGET}"
popd || exit
sudo rm -r download.docker.com