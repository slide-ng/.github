#!/usr/bin/env bash
# Replaces the placeholder organization name in this repository.
#   scripts/set-org.sh my-org
# It rewrites org.env and the links "github.com/<old>/", "github.com/orgs/<old>/"
# and "<old>.github.io" in the markdown and yaml files. Check `git diff` afterwards.
# It does not touch other repositories; list-placeholders.sh shows what they need.
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
new="${1:-}"
[[ "$new" =~ ^[A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?$ ]] || { echo "usage: $0 <organization-name>" >&2; exit 2; }
# shellcheck source=../org.env
. "$root/org.env"
old="$ORG"
[ "$old" = "$new" ] && { echo "already $new"; exit 0; }

cd "$root"
sed -i "s/^ORG=.*/ORG=$new/" org.env
git ls-files -z -- '*.md' '*.yml' | xargs -0 sed -i \
  -e "s#github\.com/$old/#github.com/$new/#g" \
  -e "s#github\.com/orgs/$old/#github.com/orgs/$new/#g" \
  -e "s#$old\.github\.io#$new.github.io#g"
echo "organization name changed from $old to $new"
