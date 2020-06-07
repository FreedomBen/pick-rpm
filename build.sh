#!/usr/bin/env bash

set -e

PODMAN="podman"

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

  if [ -z "$3" ] || ! [[ $3 =~ ^(latest|[0-9]\.[0-9]\.[0-9])$ ]]; then
    die "Third arg empty.  Should be pick version or 'latest'"
  fi
}

latest_pick_version ()
{
  curl https://github.com/mptre/pick/releases/latest \
    | awk -F '<' '{ print $4 }' \
    | sed -e 's/.*v//g' \
    | sed -e 's/".*//g'
}

is_valid_pick_version ()
{
  curl -L -I "https://github.com/mptre/pick/archive/v${1}.tar.gz" \
    | grep -E '^HTTP.*200 OK' \
    > /dev/null \
    2>&1
}

set_args ()
{
  if [ "$1" = "latest" ]; then
    export PICK_VERSION="$(latest_pick_version)"
    echo "Latest pick version identified as '$PICK_VERSION'"
  elif is_valid_pick_version "$1"; then
    export PICK_VERSION="$1"
    echo "Using pick version '$PICK_VERSION'"
  else
    die "Pick version does not appear valid.  Can you double check?"
  fi
  export PICK_VERSION_TARBALL="v${PICK_VERSION}.tar.gz"
  export PICK_VERSION_SPEC_FILE="pick-v${PICK_VERSION}.spec"
}

main ()
{
  ensure_args "$@"

  set_args "$3"

  # Build container image
  $PODMAN build \
    --build-arg DISTRO=${1} \
    --build-arg DISTRO_VER=${2} \
    --build-arg PICK_VERSION=${PICK_VERSION} \
    --build-arg PICK_VERSION_TARBALL=${PICK_VERSION_TARBALL} \
    --build-arg PICK_VERSION_SPEC_FILE=${PICK_VERSION_SPEC_FILE} \
    --tag pick-rpm \
    --file Dockerfile \
    .

  # Run rpmbuild
  $PODMAN run \
    -d \
    --name pick-rpm \
    pick-rpm

  ## Extract RPM files
  $PODMAN cp pick-rpm:/home/rpmbuild/rpms ./

  # Clean up container
  $PODMAN stop pick-rpm
  $PODMAN rm pick-rpm
}

main "$@"

