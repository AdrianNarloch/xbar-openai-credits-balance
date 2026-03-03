# xbar-openai-credits-balance

see also: [xbar-anthropic-credits-balance](https://github.com/AdrianNarloch/xbar-anthropic-credits-balance)

macOS [xbar](https://xbarapp.com/) plugin that shows your OpenAI API credits balance in the macOS menu bar.

<img width="136" height="23" alt="xbar-openai-credits-balance" src="https://github.com/user-attachments/assets/60f6b4af-126b-41aa-bd7e-f8b580cf2590" />

## Prerequisites

- macOS with `bash`, `curl`, and `python3` available.
- An OpenAI account with billing access.
- A bearer token for the billing request:
  1. Log in to OpenAI Platform.
  2. Open https://platform.openai.com/settings/organization/billing/overview.
  3. Open Chrome DevTools (`View` -> `Developer` -> `Developer Tools`) and go to the `Network` tab.
  4. Filter requests by `credit_grants` and select the `XHR` request to the billing endpoint.
  5. In request headers, copy the `Authorization: Bearer ...` token value.

## Install

1. Install xbar from https://xbarapp.com/.
2. Download or clone this repository.
3. Copy [`openai_balance.1m.sh`](./openai_balance.1m.sh) into your xbar plugins folder.
4. Edit [`openai_balance.1m.sh`](./openai_balance.1m.sh) and set:
   - `AUTH_TOKEN` to your OpenAI bearer token.
5. Make the script executable:
   ```bash
   chmod +x openai_balance.1m.sh
   ```
6. Refresh xbar (or restart the app).

The plugin refreshes every minute (`1m`) and shows the `total_available` credit value from OpenAI billing API.
