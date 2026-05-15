---
name: atomic-git-commits
description: Use when about to make git commits, when tempted to bundle unrelated changes behind a single message, or when commit history needs to support git bisect, revert, and cherry-pick workflows. Also use when reviewing a branch before creating a PR. If you are writing a plan, specify that the executor must load this skill before start working.
license: CC-BY-SA-4.0
---

# Make Atomic Git Commits

## Core Principle

Each commit = one logical change, one intention. Atomic commits enable git bisect, revert, cherry-pick, and code review. If you cannot describe the commit in one sentence without "and", split it.

### The "And" Test

- "Fix null pointer dereference in checkout flow" — passes
- "Add email validation to registration form" — passes
- "Fix cart quantity bug and update user model and add tests" — fails ("and") → three commits

### Commit Properties

Each commit must be:

1. **Independent**: Understandable without reading other commits
2. **Buildable**: Project compiles and all tests pass
3. **Complete**: The change is fully implemented — no partial work

### Red Flags — Split Now

- The subject line contains "and"
- Two different commit types both apply (feat + fix in one commit)
- You are tempted to write "misc", "various", "cleanup", or "updates" in the message
- The body describes unrelated effects
- Change A can be reverted independently from change B
- You think "I'll clean this up later"

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "It is only a few lines" | Size is irrelevant. Different intentions = different commits. |
| "I fixed it while working on X" | Work context is not commit boundaries. Different reason-to-exist = different commit. |
| "They are both `chore:` type" | Same type ≠ same intention. `chore: update prettier` ≠ `chore: add dependency`. |
| "Splitting is pedantic overhead" | Non-atomic commits break bisect, complicate reverts, confuse reviewers. Future you pays. |
| "The test file is too small" | No minimum line count. Tests are `test:` type — always separate from implementation. |
| "I am exhausted, nobody will care" | Fatigue is not an architecture decision. Future you will care when bisecting at 2 AM. |
| "I need to document every change I made" | The diff documents changes. The body explains WHY you made them — the intention behind the diff. |
| "Bullet points are the clearest way to list changes" | A bullet-point body is a checklist, not a narrative. Summarize the intent in prose; the diff lists what changed. |

## Guidelines

### Atomicity Rules (Non-Negotiable)

1. Each commit = one logical change, one intention
2. Never a bulk commit mixing unrelated changes
3. Never a vague message hiding multiple changes
4. Each commit must be independently revertible
5. One plan task ≠ one commit — think about atomicity, not tasks
6. If you used sub-agents that produced changes, incorporate their output and commit it appropriately; do not leave uncommitted work attributed to agents.

### Message Rules (Non-Negotiable)

1. Subject line max 72 characters. Use an imperative verb. Match the repo's existing subject format — run `git log --oneline -20` to discover the convention before composing your message. If the repo uses `area: description`, use that; don't impose a `type(area): description` format the repo doesn't use.
2. Write a body if non-trivial. Use multiple `-m` flags (each adds a paragraph) for a multi-line message.
3. **The body is for a human reader.** Summarize the change. Note the intention. Justify the decision. Write in natural language — the body tells a story, not a checklist. The body is never a response to a plan task; it describes the change on its own terms.
4. **Do not list files changed.** Git already tracks files. "3 files changed, 5 tests added, build passes" is machine output masquerading as a commit message. Forbidden.
5. **Do not reference plan-internal terminology.** Commits must be self-contained and meaningful in `git log` without external context. Forbidden in commit messages: plan task numbers ("Task 3", "T-14"), wave/phase names ("Wave 2", "Phase 1"), step labels ("Step 4b"), or any language implying the commit is a completion of a planning artifact. If the plan task maps to a persistent issue tracker, reference the ticket ID — not the plan task.

### Commit Body Guidelines

**Prefer no body. Make the subject self-explanatory.** If the diff alone doesn't make the intent clear, see if you can sharpen the subject first. Only add a body when the subject genuinely cannot carry the explanation.

When a body is unavoidable, use one line: a single `-m` with a brief justification. Multi-paragraph bodies are a last resort — if you need more than 3 `-m` paragraphs, your commit isn't one atomic unit or your subject is failing.

The body explains WHY, not WHAT — the diff already shows what changed.

| Body needed | No body needed |
|---|---|
| Bug fix with non-obvious cause | Typo, formatting, dead code removal |
| Feature with behavioral implications | Single-line config or dependency bump |
| Refactor that changes structure (why?) | Self-explanatory rename |
| Performance improvement (bottleneck? gain?) | Trivial cleanup with clear intent |
| Workaround or temporary fix (why not proper?) | Subject fully describes the change |
| Breaking change or migration step | The subject fully describes the change |
| Change touching 5+ files | Only one file changed, and the intent is crystal clear |

**Body form:** prose paragraphs, never bullet points. A body that lists changes is a diff summary, not an intention. If your body reads like a todo list, delete it and either sharpen the subject or write a one-line why-statement.

### Adaptive Rules

**Discover the repo's convention before composing a message.** Run `git log --oneline -20` and analyze:

1. **Prefix format**: What comes before the colon? Conventional types (`feat:`, `fix:`)? Skill or module names (`auth:`, `ui:`)? No prefix at all? Copy the pattern exactly. If the repo uses `skill-name: summary`, use that — not `type(skill-name): summary`.

2. **Capitalization and punctuation**: Sentence case (`Add login flow`) or lowercase (`add login flow`)? Trailing period or not?

3. **Scope usage**: Are parenthesized scopes used (`feat(auth):`)? If so, what scopes exist? Never invent new ones.

4. **Subject length and tone**: Spot-check existing subjects — all ≤ 72 chars, all use formal technical language. Avoid conversational constructions ("make X Y, not Z", "do X instead of Y", "let's X"). Use a single imperative verb describing the change: `infer`, `derive`, `discover`, not `make`.

**If the repo has no commit history**, choose one convention and apply it consistently:

- Conventional Commits (`type(scope): summary`) with types: feat, fix, docs, style, refactor, test, chore, perf, ci
- Or a plain prefix (`area: summary`) where area = skill name, module, component
- **Do not** use commit types as scopes: avoid `fix(perf):` where `perf` is intended as a commit type; scopes should name modules, components, or areas.
- Start the subject (after any prefix) with an imperative verb: `feat: add` not `feat: feature`

### Before You Commit

Run these checks before finalizing:

1. `git log --oneline -5` — does your subject format match existing commits?
2. Always use the length gate to enforce ≤ 72 chars. Also, do not count characters by yourself.
3. Is the subject formal? No conversational "X, not Y", "let's X", "make X better". Use a single precise verb.
4. **Body gate:** If you wrote a body, ask: can the subject be sharpened to eliminate it? If not, is this one line or does it genuinely need more? If the body has bullet points, numbered lists, or section headers — delete and rewrite as prose. A one-line why-statement is almost always better than a multi-paragraph checklist.

Gate commit on subject length:

```bash
subject="your subject"; [ ${#subject} -le 72 ] && git commit -m "$subject" -m "$body" || { echo "Subject too long: ${#subject} chars (max 72)"; exit 1; }
```

Each `-m` adds a paragraph to the body. If the subject exceeds 72 chars, the commit is blocked and the length is printed. Use this command template well, never count the characters by yourself, this is inefficient and never works. If the command rejects, immediately iterate on the subject until it passes. Even during iteration, you should not be counting characters by yourself.

## Practical Techniques

### Splitting Mixed Changes in One File (`git add -p`)

```bash
git add -p
```

| Key | Action |
|-----|--------|
| `y` | Stage this hunk |
| `n` | Skip this hunk |
| `s` | Split hunk into smaller ones |
| `e` | Edit hunk manually |
| `q` | Quit |

### Splitting an Existing Large Commit (`git reset --soft`)

```bash
git reset --soft HEAD~1       # Undo commit, keep changes staged
git restore --staged .         # Unstage everything
git add -p                     # Stage first atomic unit
git commit -m "first change"
git add -p                     # Stage second atomic unit
git commit -m "second change"
```

### Fixing a Commit In-Place (`--fixup` + `--autosquash`)

```bash
git commit --fixup <SHA>       # Create fixup commit targeting <SHA>
git rebase -i --autosquash     # Auto-squash fixups into originals
```

Use for addressing review feedback: reviewers see only the fixup, autosquash before merge.

### Cleaning History Before a PR (Interactive Rebase)

```bash
git rebase -i HEAD~5
# pick   → keep as-is
# squash → fold into previous commit
# reword → edit message only
# drop   → remove entirely
```

**Safe**: On local branches, before pushing, before PR.
**Unsafe**: Rewriting history others have already pulled. Never force-push to main/master.

### File Moves and Renames

When moving or renaming a file, the deletion (old path) and addition (new path) must be in the same commit. Git detects the rename and preserves file history. Splitting them across separate commits breaks rename detection and loses lineage.

`git mv old-path new-path` handles this automatically. Manually staging the deleted old file and added new file in one commit works equally well.

## WIP Strategy

1. **During development**: Make messy WIP commits freely for safety
2. **Before PR**: Restructure into atomic commits (`git reset --soft` + `git add -p` + interactive rebase)
3. **Never merge WIP commits**: Clean before merging to main

## Over-Granularity Warning

Atomic ≠ tiny. A refactor touching 20 files can be one atomic commit if it does one thing. Atomizing into 5-line commits creates noise. The test: can each commit be reverted independently?

## Emergency Exception

During active P1 outages, land the minimal fix first. Clean up history in a follow-up commit. Restoration time takes priority over commit hygiene.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| "Misc cleanup" commits | Each cleanup item = its own commit |
| Mixing generated files with hand-written code | Generated files go in a separate commit |
| Combining a rename with semantic edits | Separate: rename first (using `git mv`), then edit |
| Renaming by deleting old and adding new in separate commits | Use `git mv` or stage both in one commit — git needs old and new together to detect the rename |
| Tests in the same commit as unrelated implementation | Tests = `test:` type, separate commit |
| Fix-typo commits cluttering history | Use `git commit --amend` or `--fixup` |
| Using `-m` for non-trivial commits | Write a proper multi-line message |
| One commit per file just because | Commit per logical change, not per file |
| Listing changed files in the commit body | Git already tracks files. "3 files changed, 5 tests added" is noise. Use body to summarize the change and explain the intention in natural language |
| Referencing plan task numbers in commit messages | Describe the change itself, not the planning artifact. "Implements task 4" is meaningless in `git log`. Write messages that stand alone without external context. Forbidden: task numbers, wave names, phase labels, step IDs |
| Weak commit titles without a verb | Start descriptions after the type prefix with an action: `add`, `fix`, `update`, `remove`, `refactor`, `extract` |
| Attempting to count characters manually | Use the length gate command to enforce ≤ 72 chars, never try to count by yourself |
| Writing a bullet-point checklist as the body | Rewrite as prose. "Merged A, shortened B, compressed C" → "Three overlapping sections repeated the same guidance. Consolidated them while preserving all rules." |

## Appendix: Commit Types

| Type | Description |
|------|-------------|
| feat | New user-facing feature |
| fix | User-facing bug fix |
| docs | Documentation or comments only |
| style | Formatting, whitespace, linting — no logic change |
| refactor | Code restructuring, no behavior change |
| perf | Performance improvement |
| test | Test-related changes (fixing tests = `test:`, not `fix:`) |
| chore | Build process, dependencies, tooling — external to source |
| ci | CI configuration and scripts |
| wip | Work in progress — temporary, squash before merge |

When a change is both restructuring and performance, choose the emphasis. Do not use commit types as scopes: `fix(perf):` is confusing when `perf` is intended as a type; instead choose a scope that names a module or area.

Conventionally, `style:` used as a commit type never refers to a CSS/design change.
