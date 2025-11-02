#!/usr/bin/env bash
set -euo pipefail

SCRIPT_PATH=src/main.sh
TMPDIR=$(mktemp -d)
FAKE_GH="${TMPDIR}/gh"
PATH="${TMPDIR}:${PATH}"

# Assert helper
assert_contains() {
  local haystack="$1"
  local needle="$2"
  if ! grep -qF "$needle" <<<"$haystack"; then
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
