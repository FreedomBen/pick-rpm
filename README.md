# pick-rpm

This repository builds an RPM for Fedora/RHEL/CentOS for [pick](https://github.com/mptre/pick).

*If you're just looking for an RPM:  *


## Building

There are a few scripts that will build RPMs.  You must have Podman installed to run them as the RPM build happens in a container.

build.sh:  This is the entrypoint for a single build.
build-all.sh:  Builds all versions of Pick for all supported distros.
build-all-pick-versions.sh:  Builds RPMs for specified version of Pick for all supported distros.
build-latest-version-f32.sh:  Builds latest pick version for Fedora 32.
