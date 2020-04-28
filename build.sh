#!/usr/bin/env bash

set -e

die ()
{
  echo "[FATAL]: $1" >&2
  exit 1
}

ensure_args ()
{
  if [ -z "$1" ] || ! [[ $1 =~ ^(fedora|centos)$ ]]; then
    die "First arg empty.  Should be distro:  fedora, centos"
  fi

  if [ -z "$2" ]; then
    die "Second arg empty.  Should be distro version:  31, 32, 8.1, 8.2"
  fi

  if [ -z "$3" ]; then
    die "Third arg empty.  Should be pick version or 'latest'"
  fi
}

main ()
{
  ensure_args "$@"

  # Build container image
  podman build \
    --build-arg DISTRO=${1} \
    --build-arg DISTRO_VER=${2} \
    --build-arg PICK_VERSION=${PICK_VERSION} \
    --build-arg PICK_VERSION_TARBALL=${PICK_VERSION_TARBALL} \
    --build-arg PICK_VERSION_SPEC_FILE=${PICK_VERSION_SPEC_FILE} \
    --tag pick-rpm \
    --file Dockerfile \
    .

  # Run rpmbuild
  podman run \
    -d \
    --name pick-rpm \
    pick-rpm

  ## Extract RPM files
  podman cp pick-rpm:/home/rpmbuild/rpms ./

  # Clean up container
  podman stop pick-rpm
  podman rm pick-rpm
}

main "$@"

