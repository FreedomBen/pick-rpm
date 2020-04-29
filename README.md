# pick-rpm

**If you are just looking for an RPM for [pick](https://github.com/mptre/pick), check the [Releases page](https://github.com/FreedomBen/pick-rpm/releases)**

This repository builds [pick](https://github.com/mptre/pick) RPMs for Fedora/RHEL/CentOS.


## Building the RPMs

There are a few scripts that will build RPMs.  You must have Podman installed to run them as the RPM build happens in a container.

build.sh:  This is the entrypoint for a single build.
build-all.sh:  Builds all versions of Pick for all supported distros.
build-all-pick-versions.sh:  Builds RPMs for specified version of Pick for all supported distros.
build-latest-version-f32.sh:  Builds latest pick version for Fedora 32.

## Will these be available in the repositories?

Yes hopefully.  That is the goal.  The todo list:

1.  Stand up COPR repo
1.  Meet all requirements for inclusion in Fedora
1.  Get package accepted into Fedora repositories
1.  Get package accepted into EPEL
