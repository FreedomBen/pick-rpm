#!/usr/bin/env bash

set -e

# Figure out that latest version
#PICK_VERSION=3.0.1
PICK_VERSION="$(curl https://github.com/mptre/pick/releases/latest | awk -F '<' '{ print $4 }' | sed -e 's/.*v//g' | sed -e 's/".*//g')"
PICK_VERSION_TARBALL="v${PICK_VERSION}.tar.gz"
PICK_VERSION_SPEC_FILE="pick-v${PICK_VERSION}.spec"

echo "Latest pick version is: ${PICK_VERSION}"
echo "Latest pick tarball is: ${PICK_VERSION_TARBALL}"

# Generate spec file from template
#cp pick.spec.tmpl "$PICK_VERSION_SPEC_FILE"
#sed -i -e "s/PICK_VERSION_TARBALL/$PICK_VERSION_TARBALL/g" "$PICK_VERSION_SPEC_FILE"
#sed -i -e "s/PICK_VERSION/$PICK_VERSION/g" "$PICK_VERSION_SPEC_FILE"

# Build container image
podman build \
  --build-arg PICK_VERSION=${PICK_VERSION} \
  --build-arg PICK_VERSION_TARBALL=${PICK_VERSION_TARBALL} \
  --build-arg PICK_VERSION_SPEC_FILE=${PICK_VERSION_SPEC_FILE} \
  --tag pick-rpm \
  --file Dockerfile \
  .

# Run rpmbuild
#podman run \
#  pick-rpm \
#  /home/rpmbuild/rpmbuild/RPMS/build-rpm.sh
#
## Extract RPM files
#podman cp pick-rpm:/home/rpmbuild/*.rpm ./
#
## Clean up exited container
#podman rm pick-rpm
#
#
## Download latest release
#wget "https://github.com/mptre/pick/archive/${PICK_VERSION_TARBALL}"
##tar xzvf "${PICK_VERSION_TARBALL}"
#
##cd "pick-${PICK_VERSION}"
##./configure
##make
