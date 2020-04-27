#!/usr/bin/env bash

SPEC_FILE="/home/rpmbuild/rpmbuild/SPECS/${PICK_VERSION_SPEC_FILE}"

echo "Spec file is ${PICK_VERSION_SPEC_FILE}"

cp pick.spec.tmpl "$SPEC_FILE"

# Order here matters
sed -i -e "s/PICK_VERSION_TARBALL/$PICK_VERSION_TARBALL/g" "$SPEC_FILE"
sed -i -e "s/PICK_VERSION/$PICK_VERSION/g" "$SPEC_FILE"
