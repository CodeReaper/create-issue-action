#!/usr/bin/env bash
set -euo pipefail

export GH_FAKE_MODE="issue-exists"
# shellcheck source=utils.sh
source tests/utils.sh

export INPUT_MODE="close"
export INPUT_TITLE="Hello world"
export INPUT_COMMENT="Hello comment of world"
output=$(bash "${SCRIPT_PATH}" 2>&1)
assert_contains "$output" "Adding closure comment..."
assert_contains "$output" "FAKE: added comment"
assert_contains "$output" "Closing issue #42..."
assert_contains "$output" "FAKE: closed issue"
echo "passed"
