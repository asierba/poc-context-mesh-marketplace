# Answering from fetched team docs

You have just run `fetch.sh`, which printed the cache path. **Use that path** — it's the single source of truth for where the docs live; do not hardcode it.

## Steps

1. **Read.** Inspect the cache dir. Start with `README.md`, then read the specific files relevant to the user's question.
2. **Answer.** Cite specific files when referencing facts (e.g. `<cache>/README.md:line`). If the docs don't cover the question, say so — don't guess.

## Conventions

- **Always re-run the fetch script** at the start of a session that uses a fetch skill. The cache is shared across projects; another agent may have left it stale.
- **Don't write to the cache.** It's overwritten on `git pull`. Treat it as read-only.
