#!/bin/bash

set -eux

URL="https://www.bluesound.com/downloads/"

# Create temporary directory
tmp=$(realpath $(mktemp -d bluos-controller.XXX))
cleanup() {
    rm -rf "$tmp"
}
trap cleanup INT QUIT TERM 

# Find latest version
archive_url=$(lynx -dump -listonly -nonumbers "$URL" |
    grep -e '/BluOS-Controller-.*dmg' |
    sort -r |
    tail -n 1)

# Download
mkdir -p downloads
wget -N -P downloads "$archive_url"

# Unpack
7z e "downloads/${archive_url##*/}" -r app.asar -o"$tmp"
npx asar extract "$tmp/app.asar" "$tmp/app"

# Install dependencies
cd "$tmp/app"
npm install --save-dev electron-builder electron@^9.0.0 js-beautify

# Apply patches
npx js-beautify -r www/app.js
for patch_file in "$OLDPWD"/patches/*.patch
do
    patch -p0 < "$patch_file"
done

# Build
npx electron-builder -l AppImage

# Move results
mv dist "$OLDPWD"

# Cleanup
cleanup
