#!/usr/bin/env bash
# Creates or updates the labels of labels.yml in every repository of org.env.
#
#   scripts/sync-labels.sh            dry run: print the gh commands (default)
#   scripts/sync-labels.sh --dry-run  the same, spelled out
#   scripts/sync-labels.sh --apply    run them (needs `gh auth login` with write access)
#
# It never deletes a label. `gh label create --force` updates the colour and
# description of a label that exists.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# shellcheck source=../org.env
. "$root/org.env"

mode=dry
for arg in "$@"; do
  case "$arg" in
    --apply) mode=apply ;;
    --dry-run) mode=dry ;;
    -h | --help)
      sed -n '2,10p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "unknown option: $arg" >&2
      exit 2
      ;;
  esac
done

# One tab-separated line per label: name, colour, description.
labels="$(python3 - "$root/labels.yml" <<'PY'
import sys, yaml
for label in yaml.safe_load(open(sys.argv[1])):
    print("\t".join([label["name"], str(label["color"]), label["description"]]))
PY
)"

if [ "$mode" = apply ]; then
  command -v gh >/dev/null || { echo "gh is not installed" >&2; exit 1; }
else
  echo "# dry run: nothing is changed. Use --apply to run these commands."
fi

count=0
for repo in $REPOS; do
  while IFS=$'\t' read -r name color description; do
    cmd=(gh label create "$name" --repo "$ORG/$repo" --color "$color" --description "$description" --force)
    if [ "$mode" = apply ]; then
      "${cmd[@]}"
    else
      printf '%q ' "${cmd[@]}"
      printf '\n'
    fi
    count=$((count + 1))
  done <<<"$labels"
done
echo "# $count label commands for $(wc -w <<<"$REPOS" | tr -d ' ') repositories ($mode)" >&2
