# pick-rpm

**If you are just looking for an RPM for [pick](https://github.com/mptre/pick), check the [Releases page](https://github.com/FreedomBen/pick-rpm/releases)**

If you run Fedora and want to install the latest:

Fedora 32 x86_64 - pick v4.0.0

```bash
wget 'https://github.com/FreedomBen/pick-rpm/releases/download/v4.0.0/pick-4.0.0-1.fc32.x86_64.rpm'
dnf install pick-4.0.0-1.fc32.x86_64.rpm
```

Fedora 31 x86_64 - pick v3.0.1

```bash
wget 'https://github.com/FreedomBen/pick-rpm/releases/download/v3.0.1/pick-3.0.1-1.fc31.x86_64.rpm'
dnf install pick-3.0.1-1.fc31.x86_64.rpm
```

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

## What about ARM?

~Coming soon, as long as pick will build on ARM~

ARM RPMs are now available!  Get them on the [releases](https://github.com/FreedomBen/pick-rpm/releases) page.

## Why aren't these packages signed?

Coming soon.  One step at a time.  Building RPMs is painful, slow, thankless work.

## Things that don't work all the way yet

1.  Man pages
