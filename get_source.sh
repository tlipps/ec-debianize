#!/bin/bash

DEB_VERSION="1.33"
DEB_ORIG="etherlabmaster_$DEB_VERSION.orig.tar.gz"

HG_REPOS="https://gitlab.com/etherlab.org/ethercat.git"
HG_COMMIT="990d48e6c1f38cbae0fccee3013d74cbce4c7ccb"
HG_DIR="ethercat"

# PATCH_REPOS="http://hg.code.sf.net/u/uecasm/etherlab-patches"
# PATCH_COMMIT=`(echo "$DEB_VERSION" | sed -rne 's/^[0-9.]+\+[0-9]*hg([0-9a-z]*)p([0-9a-z]*).*$$/\2/p')`

function cleanup {
  rm -rf "$HG_DIR"
}
trap cleanup EXIT
set -e

echo "Cloning HG commit $HG_COMMIT..."
git clone $HG_REPOS
cd "$HG_DIR"
git checkout $HG_COMMIT
cd ..

# echo "Cloning patchset commit $PATCH_COMMIT..."
# hg clone $PATCH_REPOS "$HG_DIR/.hg/patches" -r $PATCH_COMMIT

# echo "Apply patchset..."
# (cd $HG_DIR && hg qpush -a)

echo "Create source archive..."
tar czf $DEB_ORIG $HG_DIR

echo "Extracting source..."
(cd etherlabmaster && tar xfz "../$DEB_ORIG" --strip 1)

echo "DONE."

