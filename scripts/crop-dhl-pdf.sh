#!/bin/bash
set -euo pipefail

input_file=$1

if [[ ! -f "$input_file" ]]; then
  echo "Input file '$input_file' does not exist or is unreadable, aborting." > /dev/stderr
  exit 1
fi

verbose=n

while getopts "v" opt; do
  case $opt in
    v)
      verbose=y
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND - 1))

echo "Options: verbose=$verbose"

GS_OPTS=""
if [[ $verbose == "n" ]]; then
  GS_OPTS="$GS_OPTS -q"
fi

echo "GS options: $GS_OPTS"

gs "$GS_OPTS" \
  -o out.pdf \
  -sDEVICE=pdfwrite \
  -dNOPAUSE \
  -dBATCH \
  -c "[/CropBox [0 420.945 595.28 841.89]" \
  -c " /PAGES pdfmark" \
  -f "$input_file"

declare VIEW_CMD
if [ "$(uname)" == "Darwin" ]; then
  VIEW_CMD="open"
else
  VIEW_CMD="evince"
fi
$VIEW_CMD out.pdf&
