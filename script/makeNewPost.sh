#!/bin/bash
set -o pipefail

if [[ $# -eq 0 ]]; then
  TITLE="-h"
else
  TITLE="$*"
fi

if [[ "${TITLE}" == "-h" ]]; then
  echo "Generate a new Jekyll post"
  echo "Usage: ./$(basename $0) post title"
  exit 1
fi

SLUG=$( echo "${TITLE}" | awk '{print tolower($0)}' | sed -E s/[^[:alnum:]]+/-/g )
POST="_posts/$(date +%Y-%m-%d)-${SLUG}.md"

if [[ -f "${POST}" ]]; then
  echo "Post '${POST}' already exists"
else
  touch "${POST}"
  echo "---" >> ${POST}
  echo "layout: post" >> ${POST}
  echo "title: ${TITLE}" >> ${POST}
  echo "date: $(date +'%Y-%m-%d %H:%M:%S %z')" >> ${POST}
  echo "---" >> ${POST}
  echo "Created post '${TITLE}' as ${POST}"
fi