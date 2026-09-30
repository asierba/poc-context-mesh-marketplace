---
name: fetch-tech-standards
description: Fetch Acme's company-wide tech standards and answer from them — architecture principles, service tiers, tech radar (approved/banned tech), Kafka event conventions, ADR process, data classification, secrets management, authentication, HTTP API guidelines, and incident management. Use for any question about org-wide engineering rules or whether a team's design complies with them.
---

# fetch-tech-standards

Pulls Acme's company-wide tech standards from the platform team's repo on demand and surfaces them to answer questions about org-wide engineering rules.

## Steps

1. **Fetch.** Run `scripts/fetch.sh` — path is relative to this SKILL.md; resolve to an absolute path before invoking via bash. The script clones (first invocation) or fast-forwards (subsequent invocations) the docs into a local cache, then prints the cache path on stdout. **Capture that path** — it's the single source of truth for where the docs live; do not hardcode it.
2. **Read.** Inspect the cache dir from step 1. Start with `README.md` (the index), then read the specific files relevant to the user's question under `architecture/`, `security/`, or `engineering/`.
3. **Answer.** Cite specific files when referencing facts (e.g. `<cache>/security/secrets.md:line`). If the docs don't cover the question, say so — don't guess.

## Conventions

- **Always re-run the fetch script** at the start of a session that uses this skill. The cache is shared across projects; another agent may have left it stale.
- **Don't write to the cache.** It's overwritten on `git pull`. Treat it as read-only.
- **These standards win over team docs** unless the team has an approved exception ADR.
