#!/usr/bin/env bash
# commit-length-gate.sh — Commit with subject length enforcement (max 72 chars).
# Usage: ./commit-length-gate.sh "subject" ["body paragraph 1" "body paragraph 2" ...]
# Each positional arg after the subject becomes a -m paragraph in the commit body.

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 \"subject\" [\"body\" ...]" >&2
  exit 1
fi

subject="$1"
shift

if [[ ${#subject} -gt 72 ]]; then
  echo "Subject too long: ${#subject} chars (max 72)" >&2
  echo "Subject: $subject" >&2
  exit 1
fi

args=(-m "$subject")
for body in "$@"; do
  args+=(-m "$body")
done

git commit "${args[@]}"
