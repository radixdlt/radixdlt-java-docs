#!/bin/bash

# The repo we will be working with
REPO="git@github.com:radixdlt/radixdlt-java.git"

# Temporary output
TMP=tmp

set -eE

# Make sure we are in the same directory as the script.
cd $(dirname "$0")

# Make the directories here before the trap statement so we don't remove
# anything if the mkdir fails, i.e. there are existing files/directories
# with the same name.
mkdir "$TMP"
mkdir -p "docs/java"

function finish {
    rm -rf "$TMP"
}

trap finish EXIT ERR

# Clone the whole repo.  This seems likely to be the fastest way given that
# github doesn't appear to support git-archive.
( cd "$TMP"; git clone "$REPO" . )

# The tags from the repo.  Note that we only include tags with leading digits
# but not those with a leading zero.
TAGS=$(cd tmp; git tag -l | grep '^[0-9]' | grep -v '^0\.')

if [ -z "$TAGS" ]; then
    echo "No suitable tags found for documentation."
    exit 1
fi

for tag in $TAGS; do
    echo "Processing $tag"

    # Checkout the right tag
    ( cd tmp && git checkout -q "$tag" )

    # Run gradle to get the javadoc.  Note that we ignore errors here as our
    # javadoc is a bit crusty at the moment.
    ( cd tmp && ./gradlew -x compileJava javadoc || /usr/bin/true )

    # Remove old stuff, and copy new stuff over
    rm -rf "docs/java/$tag"
    mkdir -p "docs/java/$tag"
    cp -a "$TMP/radixdlt-java/build/docs/javadoc/" "docs/java/$tag/"
    rm -rf "$TMP"
done

echo "Please add, commit & push changed files and directories in docs/"

exit 0
