#!/bin/bash
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/mariadb"
TMP="${HOME}/.tmp/mariadb"
LOCK="/tmp/wget-mariadb.lock"

SOURCE="http://yum.mariadb.org/10.5/centos7-amd64"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

pushd "${TARGET}" || exit
wget --mirror \
    --no-parent \
    --cut-dirs=1 \
    --exclude-directories='/10.5/centos6-amd64' \
    --exclude-directories='/10.5/centos7-aarch64' \
    --exclude-directories='/10.5/centos7-ppc64' \
    --exclude-directories='/10.5/centos7-ppc64le' \
    --exclude-directories='/10.5/centos73-ppc64' \
    --exclude-directories='/10.5/centos73-ppc64le' \
    --exclude-directories='/10.5/centos74-aarch64' \
    --exclude-directories='/10.5/centos8-ppc64le' \
    --exclude-directories='/10.5/fedora*' \
    --exclude-directories='/10.5/opensuse*' \
    --exclude-directories='/10.5/rhel*' \
    --exclude-directories='/10.5/sles*' \
    --exclude-directories='/10.5/centos/6*' \
    --exclude-directories='/10.5/centos/*/aarch64' \
    --exclude-directories='/10.5/centos/*/ppc64' \
    --exclude-directories='/10.5/centos/*/ppc64le' \
    ${SOURCE}
sudo rm yum.mariadb.org/index.html
popd || exit
