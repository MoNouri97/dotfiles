#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "usage: $0 <tag> <ios|android|apk|all>..." >&2
  echo "env: CM_API_TOKEN, CM_APP_ID" >&2
  exit 1
}

[[ $# -lt 2 ]] && usage
: "${CM_API_TOKEN:?CM_API_TOKEN not set}"
: "${CM_APP_ID:?CM_APP_ID not set}"

tag=$1
shift

if ! git ls-remote --exit-code --tags origin "refs/tags/$tag" >/dev/null; then
  echo "tag $tag not on origin, push it first: git push origin $tag" >&2
  exit 1
fi

workflows=()
for target in "$@"; do
  case $target in
  ios) workflows+=(ios-auvilain) ;;
  android) workflows+=(android-auvilain) ;;
  apk) workflows+=(android-auvilain-apk) ;;
  all) workflows+=(ios-auvilain android-auvilain android-auvilain-apk) ;;
  *) usage ;;
  esac
done

for wf in "${workflows[@]}"; do
  res=$(curl -sS -w '\n%{http_code}' https://api.codemagic.io/builds \
    -H 'Content-Type: application/json' \
    -H "x-auth-token: $CM_API_TOKEN" \
    -d "{\"appId\":\"$CM_APP_ID\",\"workflowId\":\"$wf\",\"tag\":\"$tag\"}")
  code=${res##*$'\n'}
  body=${res%$'\n'*}
  if [[ $code != 2* ]]; then
    echo "$wf: failed ($code) $body" >&2
    exit 1
  fi
  id=$(sed -E 's/.*"buildId" *: *"([^"]+)".*/\1/' <<<"$body")
  echo "$wf: https://codemagic.io/app/$CM_APP_ID/build/$id"
done
