---
name: fetch-checkout-docs
description: Fetch the checkout team's docs and code and answer from them — the storefront's cart-to-confirmation flow, checkout-service architecture and stack, its HTTP API and error codes, how it calls payments and inventory (timeouts, retries, idempotency), order states and data model, the order.placed / order.cancelled events and their consumers, SLOs and alerts, on-call and runbooks, ADRs, and known gaps.
---

# fetch-checkout-docs

1. **Fetch.** Run `bash ${CLAUDE_PLUGIN_ROOT}/shared/fetch.sh https://github.com/asierba/poc-context-mesh-checkout.git` and capture the cache path it prints.
2. **Answer.** Follow `${CLAUDE_PLUGIN_ROOT}/shared/instructions.md`.
