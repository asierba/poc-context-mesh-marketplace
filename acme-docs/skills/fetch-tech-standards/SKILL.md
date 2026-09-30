---
name: fetch-tech-standards
description: Fetch Acme's company-wide tech standards and answer from them — architecture principles, service tiers, tech radar (approved/banned tech), Kafka event conventions, ADR process, data classification, secrets management, authentication, HTTP API guidelines, and incident management. Use for any question about org-wide engineering rules or whether a team's design complies with them.
---

# fetch-tech-standards

1. **Fetch.** Run `bash ${CLAUDE_PLUGIN_ROOT}/shared/fetch.sh tech-standards https://github.com/asierba/poc-context-mesh-tech-standards.git` and capture the cache path it prints.
2. **Answer.** Follow `${CLAUDE_PLUGIN_ROOT}/shared/instructions.md`.

Docs are grouped under `architecture/`, `security/`, and `engineering/`. These standards win over team docs unless the team has an approved exception ADR.
