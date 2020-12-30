#!/usr/bin/env bash

serial_build ()
{
  for pick_version in 4.0.0 3.0.1; do
    # Fedora RPMs
    #for distro_version in 30 31 32 33 34; do
    for distro_version in 32 33 34; do
      ./build.sh fedora "$distro_version" "$pick_version"
    done

    # CentOS RPMs
    for distro_version in 8; do
      ./build.sh centos "$distro_version" "$pick_version"
    done
  done
}

# Use GNU Parallel to do multiple at a time
parallel ./build-all-pick-version.sh {} ::: 4.0.0 3.0.1 2.0.2

# Build serially
#serial_build
