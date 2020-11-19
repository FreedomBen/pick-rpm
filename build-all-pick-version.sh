#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Must pass pick version as first arg"
else
  parallel ./build.sh fedora {} "$1" ::: 30 31 32 33
  parallel ./build.sh centos {} "$1" ::: 8
fi
