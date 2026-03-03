#!/bin/bash
# <xbar.title>OpenAI Credits Balance</xbar.title>
# <xbar.version>1.0</xbar.version>
# <xbar.author>Adrian Narloch (narloch.dev)</xbar.author>
# <xbar.desc>Displays OpenAI credit balance.</xbar.desc>
# <xbar.dependencies>bash,curl,python3</xbar.dependencies>
# <xbar.author.github>AdrianNarloch</xbar.author.github>
# <xbar.abouturl>https://github.com/AdrianNarloch/xbar-openai-credits-balance</xbar.abouturl>

set -u

readonly PROVIDER_NAME="OpenAI"
readonly ENDPOINT_URL="https://api.openai.com/dashboard/billing/credit_grants"
readonly AUTH_TOKEN="<your-session-token-here>" # ⚠️ Your dashboard session token (NOT API key)

print_error() {
  local message="$1"
  local raw_json="${2:-}"

  echo "${PROVIDER_NAME}: -- | color=red"
  echo "---"
  echo "Error: ${message}"

  if [[ -n "${raw_json}" ]]; then
    echo "Raw: ${raw_json}"
  fi
}

fetch_json() {
  curl -fsS --max-time 5 \
    -H "Authorization: Bearer ${AUTH_TOKEN}" \
    "${ENDPOINT_URL}" 2>/dev/null
}

build_title() {
  local json_input="$1"

  printf '%s' "${json_input}" | python3 -c '
import json
import sys

try:
    payload = json.load(sys.stdin)
    available = payload.get("total_available")
    if available is None:
        print("")
    else:
        formatted = f"{available:.2f}".rstrip("0").rstrip(".")
        print(f"OpenAI: ${formatted}")
except Exception:
    print("")
'
}

main() {
  local json_response
  local title

  json_response="$(fetch_json)"
  if [[ -z "${json_response}" ]]; then
    print_error "empty response"
    exit 0
  fi

  title="$(build_title "${json_response}")"
  if [[ -z "${title}" ]]; then
    print_error "failed to parse JSON or missing 'total_available'" "${json_response}"
    exit 0
  fi

  echo "${title}"
  echo "---"
  echo "Refresh now | refresh=true"
}

main
