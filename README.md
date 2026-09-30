# poc-context-mesh-marketplace

A small Claude Code plugin marketplace that demonstrates the **fetch context skill** approach to sharing AI-consumable context across teams: producing teams keep their docs in their own repos, and a thin plugin distributes a per-team skill that *fetches* those docs into a local cache on demand.

## What's in this POC

Three connected repos:

| Repo | Role |
|---|---|
| this one — `poc-context-mesh-marketplace` | Marketplace + the `acme-docs` plugin (one fetch skill per team — currently just `fetch-payments-docs`) |
| [`poc-context-mesh-payments-docs`](https://github.com/asierba/poc-context-mesh-payments-docs) | Producer — Acme's payments team's public docs |
| [`poc-context-mesh-checkout`](https://github.com/asierba/poc-context-mesh-checkout) | Consumer — a checkout-service that needs to call the payments API |

## Try it

1. **Add this marketplace** in any Claude Code session:

   ```
   /plugin marketplace add asierba/poc-context-mesh-marketplace
   ```

2. **Install the plugin:**

   ```
   /plugin install acme-docs@acme
   ```

3. **Clone the consumer** and start a fresh session inside it:

   ```
   git clone https://github.com/asierba/poc-context-mesh-checkout.git
   cd poc-context-mesh-checkout
   claude
   ```

4. **Ask a payments-domain question.** The skill should auto-fire from its description, run `scripts/fetch.sh`, clone the producer repo into `~/.cache/context-mesh/payments-docs/`, and cite specific files when answering. Try:

   - *"What HTTP status do I get if I reuse an idempotency key with a different body?"* (expect: 409)
   - *"What's a merchant currency lock?"*
   - *"Can I take payments in two different currencies for the same merchant?"*

   The consumer repo itself contains **no `.claude/` config** — the skill is provided entirely by the installed plugin.

## What this validates

- **Description-driven discovery.** The agent picks the skill from its description, not from a central index.
- **On-demand fetch.** Docs stay in the producer repo; the plugin only ships a thin cloner.
- **Decoupled publish cycle.** Doc edits land in the producer's repo with no plugin re-release. The plugin re-releases only when the fetch behaviour itself changes.
- **Cache reuse.** First invocation clones; subsequent invocations fast-forward.

## Layout

```
.claude-plugin/marketplace.json     ← marketplace manifest
acme-docs/                          ← the plugin
├── .claude-plugin/plugin.json
└── skills/
    └── fetch-payments-docs/
        ├── SKILL.md                ← description + agent instructions
        └── scripts/fetch.sh        ← clone-or-pull; CACHE_DIR is the single source of truth
```

To add a second team (e.g., inventory), drop a `fetch-inventory-docs/` skill alongside `fetch-payments-docs/`. Same shape, different `REPO_URL`.

## Addendum: background

Teams that own a domain should own its docs, and choose which part of them other teams can see. The question is how that public surface reaches consuming teams' agents. Common options, roughly in order of capability:

| Substrate | How context travels | Tradeoff |
|---|---|---|
| Monorepo filesystem | Direct reads of each team's `docs/` | Zero mechanics; breaks once teams split repos |
| Git submodule | Consumers submodule a shared or per-team docs repo | No registry; manual updates, no versioning |
| Plugin — **fetch context skill** *(this POC)* | Plugin ships a thin cloner; content stays in producer repos | Always fresh, no re-release on doc edits; not reproducible |
| Plugin — bundled content | Plugin ships versioned doc snapshots | Reproducible, atomic releases; content moves at plugin cadence |

This POC uses the **single plugin, one fetch skill per team** variant: one install gives access to every team, and adding a team means adding one more thin skill.
