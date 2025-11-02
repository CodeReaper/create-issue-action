#!/bin/sh
set -eu

SCRIPT_PATH=src/main.sh
TMPDIR=$(mktemp -d)
FAKE_GH="${TMPDIR}/gh"
PATH="${TMPDIR}:${PATH}"

# Assert helper
assert_contains() {
  haystack="$1"
  needle="$2"

  # if ! eval printf "%s" "$haystack" | grep -qF "$needle"; then
  # if ! grep -qF "$needle" <<<"$haystack"; then
  if ! printf '%s' "$haystack" | grep -qF "$needle"; then
    echo "Expected output to contain '$needle' but it didn't"
    echo "-----"
    echo "$haystack"
    echo "-----"
    exit 1
  fi
}

trap 'rm -rf $TMPDIR' EXIT
cp tests/gh.sh "${FAKE_GH}"
chmod +x "${FAKE_GH}"

export TMPDIR
export FAKE_GH
export PATH
export SCRIPT_PATH
