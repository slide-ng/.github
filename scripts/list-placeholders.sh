#!/usr/bin/env bash
# Lists the placeholders that have to change before launch, in the sibling
# repositories (slide.ng, themes, starter, ...).
#
#   scripts/list-placeholders.sh [--summary] [parent-folder]
#
# Prints a markdown table: category, file:line, text. With --summary it prints
# only the counts per repository and per category. The parent folder defaults to
# the folder that holds this repository. It only reads; it changes nothing.
#
# Categories:
#   org-url      links to the placeholder organization (github.com/slide-ng/..., slide-ng.github.io, SLIDE_NG_REPO)
#   npm-scope    the package scope @slide-ng/ that must exist on npm
#   private      "private": true in a package.json (flip before publishing)
#   todo         TODO and FIXME comments
#   placeholder  comments or prose that call an address or origin a placeholder
set -euo pipefail

summary=0
parent=""
for arg in "$@"; do
  case "$arg" in
    --summary) summary=1 ;;
    -h | --help) sed -n '2,17p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'; exit 0 ;;
    *) parent="$arg" ;;
  esac
done
here="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
parent="${parent:-$(dirname "$here")}"

repos=(slide.ng themes starter docs docker vscode-extension skills showcases)
tab=$'\t'

scan() { # category, extended regex, [grep -v filter], [file glob]
  local cat="$1" re="$2" drop="${3:-^$}" inc="${4:-*}"
  for r in "${repos[@]}"; do
    [ -d "$parent/$r" ] || continue
    (cd "$parent" && grep -rnIiE "$re" "$r" \
      --exclude-dir=node_modules --exclude-dir=.git --exclude-dir=dist --exclude-dir=.angular \
      --exclude-dir=.slide-ng --exclude-dir=coverage --include="$inc" \
      --exclude=package-lock.json --exclude=pnpm-lock.yaml --exclude=yarn.lock \
      --exclude='*.vsix' --exclude='*.zip' --exclude='*.map' 2>/dev/null || true) |
      grep -v 'docs/public/demos/' | grep -vE "$drop" |
      sed -E 's/^([^:]+):([0-9]+):[[:space:]]*(.*)$/\1:\2\t\3/' |
      awk -v cat="$cat" -F'\t' '{ t=$2; if (length(t)>110) t=substr(t,1,107) "..."; print cat "\t" $1 "\t" t }'
  done
}

rows="$(
  {
    scan org-url 'github\.com/(orgs/)?slide-ng|slide-ng\.github\.io|SLIDE_NG_REPO'
    scan npm-scope '@slide-ng/'
    scan private '"private": *true' '/(examples|tests|template)/' package.json
    scan todo '\b(TODO|FIXME)\b' '\[ \] todo'
    scan placeholder 'placeholders? (until|origin|address|url|domain|organi[sz]ation)|are placeholders|is a placeholder'
  } | sort -t"$tab" -k2,2V -u
)"

if [ "$summary" = 1 ]; then
  echo "total: $(grep -c . <<<"$rows")"
  echo "by category:"; cut -f1 <<<"$rows" | sort | uniq -c | awk '{printf "  %-12s %d\n",$2,$1}'
  echo "by repository:"; cut -f2 <<<"$rows" | cut -d/ -f1 | sort | uniq -c | awk '{printf "  %-18s %d\n",$2,$1}'
  exit 0
fi

echo "| category | file:line | text |"
echo "| --- | --- | --- |"
while IFS="$tab" read -r cat loc text; do
  [ -n "$cat" ] || continue
  text="${text//|/\\|}"
  printf '| %s | `%s` | `%s` |\n' "$cat" "$loc" "${text//\`/\'}"
done <<<"$rows"
