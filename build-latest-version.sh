#!/usr/bin/env bash

set -e

# Figure out that latest version
#PICK_VERSION=3.0.1
PICK_VERSION="$(curl https://github.com/mptre/pick/releases/latest | awk -F '<' '{ print $4 }' | sed -e 's/.*v//g' | sed -e 's/".*//g')"
PICK_VERSION_TARBALL="v${PICK_VERSION}.tar.gz"
PICK_VERSION_SPEC_FILE="pick-v${PICK_VERSION}.spec"

echo "Latest pick version is: ${PICK_VERSION}"
echo "Latest pick tarball is: ${PICK_VERSION_TARBALL}"

# Build container image
podman build \
  --build-arg DISTRO=fedora \
  --build-arg DISTRO_VER=31 \
  --build-arg PICK_VERSION=${PICK_VERSION} \
  --build-arg PICK_VERSION_TARBALL=${PICK_VERSION_TARBALL} \
  --build-arg PICK_VERSION_SPEC_FILE=${PICK_VERSION_SPEC_FILE} \
  --tag pick-rpm \
  --file Dockerfile \
  .

# Run container
podman run \
  -d \
  --name pick-rpm \
  pick-rpm

## Extract RPM files
podman cp pick-rpm:/home/rpmbuild/rpms ./

# Clean up container
podman stop pick-rpm
podman rm pick-rpm
