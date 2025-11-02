#!/bin/sh
set -eu

# shellcheck source=utils.sh
. tests/utils.sh

export INPUT_MODE="close"
export INPUT_TITLE="Hello world"
output=$(bash "${SCRIPT_PATH}" 2>&1)
assert_contains "$output" "No matching issue found to close."
echo "passed"
