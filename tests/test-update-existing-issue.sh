#!/usr/bin/env bash
set -euo pipefail

export GH_FAKE_MODE="issue-exists"
# shellcheck source=utils.sh
source tests/utils.sh

export INPUT_TITLE="Hello world"
output=$(bash "${SCRIPT_PATH}" 2>&1)
assert_contains "$output" "Issue already exists (#42)"
assert_contains "$output" "FAKE: edited issue"
echo "passed"
