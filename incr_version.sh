#!/bin/bash

set -e

# Git check

(git diff --quiet && git diff --staged --quiet) || (
    echo "Git not clean.. not continuing" >&2
    exit 1)


# Calculate next version

version_line=$(sed -n '/^\s*\<VERSION\> [0-9]/p' CMakeLists.txt)

if [[ ! $version_line =~ ([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
    echo "Couldn't find version string" >&2
    exit 1
fi

major=${BASH_REMATCH[1]}
minor=${BASH_REMATCH[2]}
patch=${BASH_REMATCH[3]}

case "$1" in
    major) ((++major)); minor=0; patch=0 ;;
    minor) ((++minor)); patch=0 ;;
    patch) ((++patch)) ;;
    *) echo "Unknown version component '$1'"; exit 1 ;;
esac

new_version="$major.$minor.$patch"
echo "Next version: $new_version"


# Build check

./do.sh || (echo "Couldn't perform build" >&2; exit 1)


# Todos

todo() {
    while true; do
        echo "TODO: $1" [y]

        read -r input
        case "$input" in
            y) return
        esac
    done
}

todo "Check ImGui version number & release"
todo "Check that this version is actually working"
todo "Beta components file up to date?"
todo "Main components file up to date?"


# Apply changes in repo

sed -i "s/^\(\s*\<VERSION\> \)[0-9.]*$/\1$new_version/" CMakeLists.txt

git add CMakeLists.txt
git commit -m "Release $new_version"
git tag "release-$new_version"

./do.sh

echo
echo git push origin HEAD --tags
