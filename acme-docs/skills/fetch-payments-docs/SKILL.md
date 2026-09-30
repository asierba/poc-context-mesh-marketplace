---
name: fetch-payments-docs
description: Fetch the payments team's docs and answer from them — the API contract, integration rules, and glossary for the platform's payments domain (charges, refunds, idempotency, merchant currency, settlement, vault).
---

# fetch-payments-docs

1. **Fetch.** Run `bash ${CLAUDE_PLUGIN_ROOT}/shared/fetch.sh payments-docs https://github.com/asierba/poc-context-mesh-payments-docs.git` and capture the cache path it prints.
2. **Answer.** Follow `${CLAUDE_PLUGIN_ROOT}/shared/instructions.md`.

Relevant files are typically `payments-api.md` and `glossary.md`.
