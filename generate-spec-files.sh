#!/usr/bin/env bash

copy_spec_file ()
{
  fname="pick-v${1}.spec"
  ofname="spec-files/${fname}"
  cp pick.spec.tmpl "$ofname"
  sed -i -e "s/PICK_VERSION_TARBALL/v${1}.tar.gz/g" "$ofname"
  sed -i -e "s/PICK_VERSION/$1/g" "$ofname"
}

#copy_spec_file_per_distro ()
#{
#  # $1 distro - $2 distro ver - $3 pick ver
#  fname="${1}-${2}-pick-v${3}.spec"
#  ofname="spec-files/${fname}"
#  cp pick.spec.tmpl "$ofname"
#  sed -i -e "s/PICK_VERSION_TARBALL/v${3}.tar.gz/g" "$ofname"
#  sed -i -e "s/PICK_VERSION/$3/g" "$ofname"
#}

main ()
{
  for pick_version in 4.0.0 3.0.1; do
    copy_spec_file $pick_version
  done

  #for pick_version in 4.0.0 3.0.1; do
  #  # Fedora RPMs
  #  for distro_version in 30 31 32; do
  #    copy_spec_file_per_distro fedora "$distro_version" "$pick_version"
  #  done

  #  # CentOS RPMs
  #  for distro_version in 8; do
  #    copy_spec_file_per_distro centos "$distro_version" "$pick_version"
  #  done
  #done
}

main
