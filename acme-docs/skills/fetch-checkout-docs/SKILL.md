---
name: fetch-checkout-docs
description: Fetch the checkout team's docs and answer from them — the storefront's cart-to-confirmation flow, checkout-service architecture and stack, how it calls payments and inventory, order creation, and the order.placed / order.cancelled events.
---

# fetch-checkout-docs

1. **Fetch.** Run `bash ${CLAUDE_PLUGIN_ROOT}/shared/fetch.sh checkout https://github.com/asierba/poc-context-mesh-checkout.git` and capture the cache path it prints.
2. **Answer.** Follow `${CLAUDE_PLUGIN_ROOT}/shared/instructions.md`.
