# What is that?

This script repackages the latest version of the BluOS Controller to make it work on Linux.

See: https://support1.bluesound.com/hc/en-us/community/posts/360033533054-BluOS-controller-app-on-Linux

# How to build

## Using Docker or Podman (suggested)

Replace `docker` with `podman` if you prefer to use Podman.

```
podman build -t bs-bashpatch .
mkdir -p downloads output
podman run --rm -v $PWD/output:/output -v $PWD/downloads:/downloads bs-bashpatch
```

## Without using Docker or Podman

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

# How to run

## Default mode

Open the output directory and run the generated AppImage.

## Expert mode

Run the latest generated AppImage and print console messages:

```
ELECTRON_ENABLE_LOGGING=true "$(ls output/*.AppImage | sort | head -n1)"
```

# Common issues

## Program crashes when opened after few seconds

Try to delete the configuration and try again:

```
rm -rf ~/.config/BluOS\ Controller
```
