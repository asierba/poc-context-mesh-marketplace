# poc-context-mesh-marketplace

A small Claude Code plugin marketplace that demonstrates the **fetch context skill** approach to sharing AI-consumable context across teams: each team keeps its docs in its own repo, and a thin plugin distributes a per-team skill that *fetches* those docs into a local cache on demand.

## What's in this POC

Three connected repos:

| Repo | Role |
|---|---|
| this one — `poc-context-mesh-marketplace` | Marketplace + the `acme-docs` plugin (one fetch skill per team) |
| [`poc-context-mesh-payments-docs`](https://github.com/asierba/poc-context-mesh-payments-docs) | Payments team's docs — fetched by `fetch-payments-docs` |
| [`poc-context-mesh-checkout`](https://github.com/asierba/poc-context-mesh-checkout) | Checkout team's docs — fetched by `fetch-checkout-docs` |

## Try it

1. **Add this marketplace** in any Claude Code session:

   ```
   /plugin marketplace add asierba/poc-context-mesh-marketplace
   ```

2. **Install the plugin:**

   ```
   /plugin install acme-docs@acme
   ```

3. **Start a fresh session** in any directory — no project setup needed.

4. **Ask a domain question.** The matching skill should auto-fire from its description, run its `scripts/fetch.sh`, clone the team's repo into `~/.cache/context-mesh/<team>/`, and cite specific files when answering. Try:

   Payments:
   - *"What HTTP status do I get if I reuse an idempotency key with a different body?"* (expect: 409)
   - *"What's a merchant currency lock?"*
   - *"Can I take payments in two different currencies for the same merchant?"*

   Checkout:
   - *"What does checkout check before capturing payment?"* (expect: inventory)
   - *"Which events does checkout emit?"* (expect: `order.placed` / `order.cancelled`)
   - *"Who's on call for checkout?"*

   The skill is provided entirely by the installed plugin — no `.claude/` config in the working directory.

## What this validates

- **Description-driven discovery.** The agent picks the skill from its description, not from a central index.
- **On-demand fetch.** Docs stay in each team's repo; the plugin only ships a thin cloner.
- **Decoupled publish cycle.** Doc edits land in the team's repo with no plugin re-release. The plugin re-releases only when the fetch behaviour itself changes.
- **Cache reuse.** First invocation clones; subsequent invocations fast-forward.

## Layout

```
.claude-plugin/marketplace.json     ← marketplace manifest
acme-docs/                          ← the plugin
├── .claude-plugin/plugin.json
└── skills/
    ├── fetch-payments-docs/
    │   ├── SKILL.md                ← description + agent instructions
    │   └── scripts/fetch.sh        ← clone-or-pull; CACHE_DIR is the single source of truth
    └── fetch-checkout-docs/        ← same shape, different REPO_URL
```

To add another team (e.g., inventory), drop a `fetch-inventory-docs/` skill alongside the others. Same shape, different `REPO_URL`.

## Addendum: background

Teams that own a domain should own its docs, and choose which part of them other teams can see. The question is how that public surface reaches consuming teams' agents. Common options, roughly in order of capability:

| Substrate | How context travels | Tradeoff |
|---|---|---|
| Monorepo filesystem | Direct reads of each team's `docs/` | Zero mechanics; breaks once teams split repos |
| Git submodule | Consumers submodule a shared or per-team docs repo | No registry; manual updates, no versioning |
| Plugin — **fetch context skill** *(this POC)* | Plugin ships a thin cloner; content stays in producer repos | Always fresh, no re-release on doc edits; not reproducible |
| Plugin — bundled content | Plugin ships versioned doc snapshots | Reproducible, atomic releases; content moves at plugin cadence |

This POC uses the **single plugin, one fetch skill per team** variant: one install gives access to every team, and adding a team means adding one more thin skill.
