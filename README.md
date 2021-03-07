# What is that?

This script repackages the latest version of the BluOS Controller to make it work on Linux.

See: https://support1.bluesound.com/hc/en-us/community/posts/360033533054-BluOS-controller-app-on-Linux

# Build using Podman

Podman is an alternative to Docker, which does not require any daemon or special permissions to run.

```
mkdir -p downloads output
podman run --rm -v ./output:/output:Z -v ./downloads:/downloads:Z ghcr.io/frafra/bs-bashpatch
```

Open the output directory and run the generated AppImage.

# Common issues

## Program crashes when opened after few seconds

Try to delete the configuration and try again:

```
rm -rf ~/.config/BluOS\ Controller
```

# Advanced topics

## Build container image with Podman

```
podman build -t bs-bashpatch-custom .
mkdir -p downloads output
podman run --rm -v ./output:/output:Z -v ./downloads:/downloads:Z bs-bashpatch-custom
```

## Build without using containers

### Install dependencies

- bash
- wget
- lynx
- jq
- p7zip
  - Debian: p7zip-full
  - OpenSUSE Tumbleweed: p7zip-full
  - OpenSUSE Leap 15: p7zip
  - Fedora: p7zip-plugins
- patch
- npm
  - OpenSUSE: npm10

### Run the script

```
./bs-bashpatch.sh
```

### Remove temporary files

In case the script fails, a temporary directory will be kept, which can be removed with this command:

```
rm -r bluos-controller.*
```

## Electron logging

Run the latest generated AppImage and print console messages:

```
ELECTRON_ENABLE_LOGGING=true "$(ls output/*.AppImage | sort | tail -n1)"
```
