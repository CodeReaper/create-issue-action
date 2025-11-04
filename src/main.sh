#!/bin/sh

# cspell:ignore endgroup

set -eu

MODE="${INPUT_MODE:-create}"
STATE="${INPUT_STATE:-open}"
TITLE="${INPUT_TITLE}"
LABELS="${INPUT_LABELS:-}"
ASSIGNEES="${INPUT_ASSIGNEES:-}"
BODY="${INPUT_BODY:-}"
COMMENT="${INPUT_COMMENT:-}"
REPO="${INPUT_REPO:-}"

BODY_PRESENCE=${BODY:+(set)}
COMMENT_PRESENCE=${COMMENT:+(set)}

echo "::group::Debug info:"
echo "  REPO:        ${REPO}"
echo "  MODE:        ${MODE}"
echo "  STATE:       ${STATE}"
echo "  TITLE:       ${TITLE}"
echo "  LABELS:      ${LABELS}"
echo "  ASSIGNEES:   ${ASSIGNEES}"
echo "  BODY:        ${BODY_PRESENCE:-(not set)}"
echo "  COMMENT:     ${COMMENT_PRESENCE:-(not set)}"
echo '::endgroup::'

ISSUE_NUMBER=$(gh issue list --repo "${REPO}" --state "${STATE}" --label "${LABELS}" --search "in:title \"${TITLE}\"" --limit 1 --json number --jq '.[].number' || true)

case "${MODE}" in
create)
  if [ -n "${ISSUE_NUMBER}" ]; then
    echo "Issue already exists (#${ISSUE_NUMBER}), updating instead."
    if [ -n "${COMMENT}" ]; then
      echo "Adding comment to existing issue..."
      gh issue comment "${ISSUE_NUMBER}" --repo "${REPO}" --body "${COMMENT}" --edit-last --create-if-none --yes
    else
      echo "Updating issue body..."
      gh issue edit "${ISSUE_NUMBER}" --repo "${REPO}" --title "${TITLE}" --body "${BODY}"
    fi
  else
    echo "Creating new issue..."
    gh issue create --repo "${REPO}" --title "${TITLE}" --body "${BODY}" --label "${LABELS}" --assignee "${ASSIGNEES}"
  fi
  ;;
close)
  if [ -z "${ISSUE_NUMBER}" ]; then
    echo "No matching issue found to close."
    exit 0
  fi
  if [ -n "${COMMENT}" ]; then
    echo "Closing issue #${ISSUE_NUMBER} with comment..."
    gh issue close "${ISSUE_NUMBER}" --repo "${REPO}" --comment "${COMMENT}"
  else
    echo "Closing issue #${ISSUE_NUMBER}..."
    gh issue close "${ISSUE_NUMBER}" --repo "${REPO}"
  fi
  ;;
*)
  echo "Invalid mode '${MODE}'. Valid options: create | close"
  exit 1
  ;;
esac

echo "Done."
