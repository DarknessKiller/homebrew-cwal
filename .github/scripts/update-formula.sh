#!/usr/bin/env bash
set -euo pipefail

UPSTREAM_OWNER="nitinbhat972"
UPSTREAM_REPO="cwal"
FORMULA_FILE="Formula/cwal.rb"

echo "Fetching latest release from $UPSTREAM_OWNER/$UPSTREAM_REPO..." >&2

LATEST=$(curl -sL "https://api.github.com/repos/$UPSTREAM_OWNER/$UPSTREAM_REPO/releases/latest")
TAG=$(echo "$LATEST" | jq -r '.tag_name')
VERSION="${TAG#v}"

echo "Latest tag: $TAG" >&2

CURRENT_VERSION=$(sed -n 's/.*url ".*\/archive\/refs\/tags\/v\(.*\)\.tar\.gz".*/\1/p' "$FORMULA_FILE")
echo "Current formula version: $CURRENT_VERSION" >&2

if [ "$CURRENT_VERSION" = "$VERSION" ]; then
  echo "No update needed (already at $VERSION)." >&2
  exit 0
fi

echo "Updating from v$CURRENT_VERSION to $TAG..." >&2

TARBALL_URL="https://github.com/$UPSTREAM_OWNER/$UPSTREAM_REPO/archive/refs/tags/$TAG.tar.gz"
echo "Downloading $TARBALL_URL ..." >&2
SHA256=$(curl -sL "$TARBALL_URL" | sha256sum | cut -d' ' -f1)
echo "SHA256: $SHA256" >&2

sed -i "s|url \".*\"|url \"$TARBALL_URL\"|" "$FORMULA_FILE"
sed -i "s|sha256 \".*\"|sha256 \"$SHA256\"|" "$FORMULA_FILE"

echo "Done! $FORMULA_FILE updated to $TAG" >&2
