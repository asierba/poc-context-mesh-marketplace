---
name: fetch-tech-standards
description: Fetch Acme's company-wide tech standards and answer from them — architecture principles, service tiers, tech radar (approved/banned tech), Kafka event conventions, ADR process, data classification, secrets management, authentication, HTTP API guidelines, and incident management. Use for any question about org-wide engineering rules or whether a team's design complies with them.
---

# fetch-tech-standards

1. **Fetch.** Run `bash ${CLAUDE_PLUGIN_ROOT}/shared/fetch.sh https://github.com/asierba/poc-context-mesh-tech-standards.git` and capture the cache path it prints.
2. **Answer.** Follow `${CLAUDE_PLUGIN_ROOT}/shared/instructions.md`.

The repo is an LLM wiki: start at `index.md`. The current rules are in `wiki/standards/`. For *why* a rule exists, follow its link to the meeting summary in `wiki/summaries/` and the transcript in `raw/` (transcripts win if a page disagrees). These standards win over team docs unless the team has an approved exception ADR.
