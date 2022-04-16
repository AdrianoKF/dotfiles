set -euo pipefail

input_file=$1

if [[ ! -f "$input_file" ]]; then
  echo "Input file '$input_file' does not exist or is unreadable, aborting." > /dev/stderr
  exit 1
fi

OPTIONS=v
PARSED_OPTS=$(getopt --options=$OPTIONS --name "$0" -- "$@")
eval set -- "$PARSED_OPTS"

verbose=n
while true; do
  case "$1" in
    -v)
      verbose=y
      shift
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Programming error"
      exit 3
      ;;
    esac
done

echo "Options: verbose=$verbose"

GS_OPTS=""
if [[ $verbose == "n" ]]; then
  GS_OPTS="$GS_OPTS -q"
fi

echo "GS options: $GS_OPTS"

gs $GS_OPTS \
  -o out.pdf \
  -sDEVICE=pdfwrite \
  -dNOPAUSE \
  -dBATCH \
  -c "[/CropBox [0 420.945 595.28 841.89]" \
  -c " /PAGES pdfmark" \
  -f $input_file
