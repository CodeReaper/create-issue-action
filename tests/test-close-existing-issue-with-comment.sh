#!/bin/sh
set -eu

export GH_FAKE_MODE="issue-exists"
# shellcheck source=utils.sh
. tests/utils.sh

export INPUT_MODE="close"
export INPUT_TITLE="Hello world"
export INPUT_COMMENT="Hello comment of world"
output=$(bash "${SCRIPT_PATH}" 2>&1)
assert_contains "$output" "Closing issue #42 with comment..."
assert_contains "$output" "FAKE: closed issue"
echo "passed"

