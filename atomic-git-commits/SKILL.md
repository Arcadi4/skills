---
name: atomic-git-commits
description: Use when about to make git commits, when tempted to bundle unrelated changes behind a single message, or when commit history needs to support git bisect, revert, and cherry-pick workflows. Also use when reviewing a branch before creating a PR. If you are writing a plan, specify that the executor must load this skill before start working.
license: CC-BY-SA-4.0
---

# Make Atomic Git Commits

## Overview

Each commit = one logical change, one intention. Atomic commits make git bisect, revert, cherry-pick, and code review practical.

**Core principle**: If you cannot describe the commit in one sentence without "and", split it.

**Violating the spirit is violating the letter.** Every rationalization below leads to the same outcome: non-atomic history that breaks bisect, complicates reverts, and confuses reviewers.

## The "And" Test

Can you describe the commit in one sentence without using "and"?

- "Fix null pointer dereference in checkout flow" — passes, no "and"
- "Add email validation to registration form" — passes
- "Fix cart quantity bug and update user model and add tests" — fails, contains "and" → three commits

## Atomic Commit Properties

Each commit must be:

1. **Independent**: Understandable without reading other commits
2. **Buildable**: Project compiles and all tests pass
3. **Complete**: The change is fully implemented — no partial work

## Red Flags — Split This Commit

Your commit needs splitting when:

- The subject line contains "and"
- Two different commit types both apply (feat + fix in one commit)
- You are tempted to write "misc", "various", "cleanup", or "updates" in the message
- The body describes unrelated effects
- Change A can be reverted independently from change B
- You think "I'll clean this up later"

**All of these mean: split the commit now.**

## Common Rationalizations (and Why They Are Wrong)

| Rationalization | Why It Fails |
|---|---|
| "It is only a few lines" | Size does not matter. A 3-line DB config change and a 5-line README update are different intentions. |
| "I fixed it while working on X" | Work context is not commit boundaries. If the change has a different reason-to-exist, it is a different commit. |
| "They are both `chore:` type" | Same type ≠ same intention. `chore: update prettier` and `chore: add dependency` are different. |
| "Splitting is pedantic overhead" | The cost of non-atomic commits (broken bisect, messy reverts, confused reviewers) is paid by future you and your team. |
| "The test file is too small to deserve its own commit" | No minimum line count. Tests are a different concern (`test:` type) from implementation. Always separate. |
| "I am exhausted, nobody will care" | Fatigue is not a valid architecture decision. Future you will care when bisecting a bug at 2 AM. |

## Guidelines

### Atomicity Rules (Non-Negotiable)

1. Each commit = one logical change, one intention
2. Never a bulk commit that mixes unrelated changes
3. Never a fake bulk commit with a vague message hiding multiple changes
4. Revertible: each commit can be reverted independently
5. One plan task ≠ one commit — think about atomicity, not tasks
6. After dispatching sub-agents, commit on their behalf if they did not. Check this first.

### Message Rules (Non-Negotiable)

1. Subject line max 72 characters
2. Write a body explaining **why** for non-trivial commits (the code shows what)
3. Do not use `-m` for non-trivial commits — use an editor to write a proper multi-line message
4. Do not list the files changed in the commit body. Git already tracks that. The body exists to explain **why** the change was made.
5. Do not reference plan-internal identifiers (task numbers, step names) unless they correspond to a persistent issue tracker. "Implements task 3" is meaningless in `git log` six months later.

### Adaptive Rules

Match existing repository patterns. If none established, choose consistently:

- Capitalization of subject line
- Trailing period or not
- Scope usage (module name, directory, project concept). Do not invent scopes if the project already has established ones. Never use a commit type as a scope — `fix(perf):` or `refactor(perf):` is invalid. Performance improvements use `perf:` as the type.
- Commit types (feat, fix, docs, style, refactor, test, chore, perf, ci)
- Whether to avoid merge commits
- Prefer starting the commit title (after the type prefix) with an imperative verb: `feat: add login flow` not `feat: login feature`

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

### Renaming Files (`git mv`)

```bash
git mv old-name.ts new-name.ts
```

When renaming or moving a file, include the deletion and addition in the same commit so git detects the rename and preserves file history. Using `git mv` is the simplest way, but manually staging both the old (deleted) and new (added) file in one commit works equally well. This is common during refactors where a file is moved *and* lightly edited — as long as old and new are in the same commit, git detects the movement. Deleting the old file and adding the new one in separate commits breaks history.

## WIP Commit Strategy

WIP commits are acceptable during exploration. The pattern:

1. **During development**: Make messy WIP commits freely for safety
2. **Before PR**: Restructure into atomic commits using `git reset --soft` + `git add -p` + interactive rebase
3. **Never merge WIP commits**: Clean them before merging to main

## Over-Granularity Warning

Atomic ≠ tiny. A refactor touching 20 files can be one atomic commit if it does one thing. Atomizing into commits of 5 lines each creates noise. The test: can each commit be reverted independently without breaking the project?

## Emergency Exception

During active P1 outages, land the minimal fix first. Clean up history in a follow-up commit. Restoration time takes priority over commit hygiene.

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| "Misc cleanup" commits | Each cleanup item = its own commit |
| Mixing generated files with hand-written code | Generated files go in a separate commit |
| Combining a rename with semantic edits | Separate: rename first (using `git mv`), then edit |
| Renaming a file by deleting old and adding new in separate commits | Use `git mv` or do both in one commit — git needs to see old and new together to detect the rename |
| Tests in the same commit as unrelated implementation | Tests = `test:` type, separate commit |
| Fix-typo commits cluttering history | Use `git commit --amend` or `--fixup` instead |
| Using `-m` for non-trivial commits | Use an editor to write a proper multi-line message |
| One commit per file just because | Commit per logical change, not per file |
| Listing changed files in the commit body | Git already tracks files. Use body for **why**, not what |
| Referencing plan task numbers in commit messages | Describe the change itself, not the planning artifact. Write messages that make sense in `git log` without external context |
| Weak commit titles without a verb | Start descriptions after the type prefix with an action: `add`, `fix`, `update`, `remove`, `refactor`, `extract` |

## Appendix: Commit Types

Default definitions (adapt to your project's conventions):

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

When a change involves both restructuring and performance, choosing between `refactor:` and `perf:` is flexible — pick the aspect you want to emphasize. However, **never nest a commit type inside a scope**: `fix(perf):` and `refactor(perf):` are invalid. The scope field names a module or area, not another type.

## Real-World Impact

Atomic commits enable:

- **git bisect**: Pinpoint the exact commit that introduced a bug
- **git revert**: Roll back one change without losing others or causing conflicts
- **git cherry-pick**: Port specific fixes between branches cleanly
- **Code review**: Reviewers understand each change independently, catching issues faster
