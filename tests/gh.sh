#!/bin/sh
set -eu

case "$*" in
*"issue list"*)
  # Simulate no issue found unless overridden
  if [ "${GH_FAKE_MODE:-none}" = "issue-exists" ]; then
    echo '42'
  else
    echo ''
  fi
  ;;
*"issue create"*)
  echo "FAKE: created issue"
  ;;
*"issue edit"*)
  echo "FAKE: edited issue"
  ;;
*"issue comment"*)
  echo "FAKE: added comment"
  ;;
*"issue close"*)
  echo "FAKE: closed issue"
  ;;
*)
  echo "FAKE: unknown gh command $*" >&2
  exit 1
  ;;
esac
