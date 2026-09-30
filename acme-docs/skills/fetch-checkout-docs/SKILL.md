---
name: fetch-checkout-docs
description: Fetch the checkout team's docs and answer from them — the storefront's cart-to-confirmation flow, checkout-service architecture and stack, how it calls payments and inventory, order creation, and the order.placed / order.cancelled events.
---

# fetch-checkout-docs

Pulls the checkout team's docs from their repo on demand and surfaces them to answer questions about the checkout domain.

## Steps

1. **Fetch.** Run `scripts/fetch.sh` — path is relative to this SKILL.md; resolve to an absolute path before invoking via bash. The script clones (first invocation) or fast-forwards (subsequent invocations) the docs into a local cache, then prints the cache path on stdout. **Capture that path** — it's the single source of truth for where the docs live; do not hardcode it.
2. **Read.** Inspect the cache dir from step 1. Start with `README.md`, then read any other files relevant to the user's question.
3. **Answer.** Cite specific files when referencing facts (e.g. `<cache>/README.md:line`). If the docs don't cover the question, say so — don't guess.

## Conventions

- **Always re-run the fetch script** at the start of a session that uses this skill. The cache is shared across projects; another agent may have left it stale.
- **Don't write to the cache.** It's overwritten on `git pull`. Treat it as read-only.
