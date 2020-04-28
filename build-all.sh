#!/usr/bin/env bash

set -e

for pick_version in 4.0.0 3.0.1 2.0.2; do
  # Fedora RPMs
  for distro_version in 30, 31, 32; do
    ./build.sh fedora "$distro_version" "$pick_version"
  done

  # CentOS RPMs
  for distro_version in 7, 8; do
    ./build.sh centos "$distro_version" "$pick_version"
  done
done

