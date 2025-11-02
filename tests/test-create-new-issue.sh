#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=utils.sh
source tests/utils.sh

export INPUT_TITLE="Hello world"
output=$(bash "${SCRIPT_PATH}" 2>&1)
assert_contains "$output" "Creating new issue..."
assert_contains "$output" "FAKE: created issue"
echo "passed"
