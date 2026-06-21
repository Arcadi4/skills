---
name: commit
description: Use when about to make git commits, when tempted to bundle unrelated changes behind a single message, or when commit history needs to support git bisect, revert, and cherry-pick workflows. Also use when reviewing a branch before creating a PR. If you are writing a plan, specify that the executor must load this skill before start working.
license: CC-BY-SA-4.0
---

# Make Atomic Git Commits

## Core Principle

Each commit = one logical change, one intention. If you cannot describe the commit in one sentence without "and", split it.

- "Fix null pointer dereference in checkout flow" — passes
- "Fix cart quantity bug and update user model and add tests" — fails ("and") → three commits

Each commit must be **independent** (understandable alone), **buildable** (compiles, tests pass), and **complete** (no partial work).

Atomic ≠ tiny. A refactor touching 20 files can be one atomic commit if it does one thing. The test: can it be reverted independently?

### Red Flags — Split Now

- Subject contains "and" or two commit types apply (e.g. feat + fix)
- You're tempted to write "misc", "various", "cleanup", or "updates"
- The body describes unrelated effects
- Change A can be reverted independently from change B

### Revert-Boundary Gate

Before committing a large staged diff, list the independent revert boundaries in one-line phrases. If more than one phrase is required, split the commit — even if the changes are coupled or all tests only pass after the full refactor. "They are coupled" is not an atomicity argument; use transitional buildable commits or explain why no independent revert boundary exists.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "Only a few lines" | Size is irrelevant. Different intentions = different commits. |
| "Fixed it while working on X" | Work context ≠ commit boundary. Different reason-to-exist = different commit. |
| "Both are `chore:` type" | Same type ≠ same intention. `chore: update prettier` ≠ `chore: add dependency`. |
| "Splitting is pedantic" | Non-atomic commits break bisect, complicate reverts, confuse reviewers. |
| "Test file is too small" | No minimum line count. Tests are `test:` type — always separate. |
| "They are deeply coupled" | Coupling explains staging order, not commit boundaries. Separate intentions with separate revert boundaries = separate commits. Dependency between commits is normal. |
| "I'll just count the characters" | Manual counting fails. Always. Use the length gate script or inline gate — never eyeball it. |

## Message Rules

### Discover Convention First

Run `git log --oneline -20` and match the repo's existing format exactly:
- **Prefix format**: Conventional types (`feat:`, `fix:`)? Module names (`auth:`, `ui:`)? None?
- **Capitalization/punctuation**: Sentence case or lowercase? Trailing period?
- **Scopes**: If parenthesized scopes exist (`feat(auth):`), use existing ones. Never invent scopes. Never use commit types as scopes (`fix(perf):` is wrong when `perf` is intended as a type).

No commit history? Pick one convention and apply consistently. Conventional Commits (`type(scope): summary`) or plain prefix (`area: summary`).

### Subject Line

- Max 72 characters. **Always commit through the length gate script** — never call `git commit` directly. The script enforces the limit and is the only sanctioned commit command:
  ```bash
  ./commit-length-gate.sh "subject" "optional body paragraph"   # bash
  ./commit-length-gate.ps1 "subject" "optional body paragraph"  # pwsh
  ```
  If the script is not available in the repo, use the inline gate: `subject="..."; [ ${#subject} -le 72 ] && git commit -m "$subject" || echo "Too long: ${#subject}"`. Never count characters yourself — it does not work.
- Start with an imperative verb after any prefix: `add`, `fix`, `extract`, `remove`. Not `feature`, `make`, `let's`.
- Formal technical language. No conversational constructions ("make X Y, not Z", "do X instead of Y").

### Body

**Prefer no body.** Make the subject self-explanatory. Only add a body when the subject genuinely cannot carry the explanation.

Body explains **WHY**, not WHAT — the diff shows what changed. Write prose, never bullet points or checklists. A one-line why-statement is almost always sufficient; if you need more than 3 `-m` paragraphs, your commit isn't atomic.

| Body needed | No body needed |
|---|---|
| Bug fix with non-obvious cause | Typo, formatting, dead code removal |
| Refactor that changes structure (why?) | Self-explanatory rename |
| Performance improvement (bottleneck? gain?) | Single-line config or dependency bump |
| Breaking change or migration step | Subject fully describes the change |

### Forbidden in Messages

- **File lists**: Git tracks files. "3 files changed, 5 tests added" is noise.
- **Plan-internal terminology**: No task numbers ("Task 3"), wave/phase names, step labels. Commits must stand alone in `git log`. Reference ticket IDs from issue trackers, not planning artifacts.

## Commit Types

| Type | Description |
|------|-------------|
| feat | New user-facing feature |
| fix | User-facing bug fix |
| docs | Documentation or comments only |
| style | Formatting, whitespace, linting — no logic change (never CSS/design) |
| refactor | Code restructuring, no behavior change |
| perf | Performance improvement |
| test | Test-related changes (fixing tests = `test:`, not `fix:`) |
| chore | Build process, dependencies, tooling |
| ci | CI configuration and scripts |

When a change is both restructuring and performance, choose the emphasis.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| "Misc cleanup" commits | Each cleanup item = its own commit |
| Generated files mixed with hand-written code | Generated files go in a separate commit |
| Rename combined with semantic edits | Rename first (using `git mv`), then edit in next commit |
| Rename split across commits (delete old + add new) | Stage both in one commit — git needs old and new together for rename detection |
| One commit per file | Commit per logical change, not per file |
| Sub-agent output left uncommitted | Incorporate sub-agent changes and commit appropriately |
| Calling `git commit` directly | Always use the length gate script. Raw `git commit` bypasses the 72-char enforcement. |

## Emergency Exception

During active P1 outages, land the minimal fix first. Clean up history in a follow-up commit.
