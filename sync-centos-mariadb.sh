#!/bin/sh
# This is a sample mirroring script.
HOME="/var/www/mirror"
TARGET="${HOME}/mariadb"
TMP="${HOME}/.tmp/mariadb"
LOCK="/tmp/rsync-mariadb.lock"

SOURCE="http://yum.mariadb.org/10.4/centos7-amd64"

[ ! -d "${TARGET}" ] && mkdir -p "${TARGET}"
[ ! -d "${TMP}" ] && mkdir -p "${TMP}"

exec 9>"${LOCK}"
flock -n 9 || exit

if ! stty &>/dev/null; then
    QUIET="-q"
fi

wget --mirror \
    --no-parent \
    --exclude-directories='/10.4/centos6-amd64' \
    --exclude-directories='/10.4/centos7-aarch64' \
    --exclude-directories='/10.4/centos7-ppc64' \
    --exclude-directories='/10.4/centos7-ppc64le' \
    --exclude-directories='/10.4/centos73-ppc64' \
    --exclude-directories='/10.4/centos73-ppc64le' \
    --exclude-directories='/10.4/centos74-aarch64' \
    --exclude-directories='/10.4/centos8-ppc64le' \
    --exclude-directories='/10.4/fedora*' \
    --exclude-directories='/10.4/opensuse*' \
    --exclude-directories='/10.4/rhel*' \
    --exclude-directories='/10.4/sles*' \
    --exclude-directories='/10.4/centos/6*' \
    --exclude-directories='/10.4/centos/*/aarch64' \
    --exclude-directories='/10.4/centos/*/ppc64' \
    --exclude-directories='/10.4/centos/*/ppc64le' \
    ${SOURCE}

pushd yum.mariadb.org/10.4/ || exit
sudo mv * "${TARGET}"
popd || exit
sudo rm -r yum.mariadb.org