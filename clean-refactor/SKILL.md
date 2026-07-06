---
name: clean-refactor
description: Use when removing dead code, renaming symbols, or refactoring — any change with no external consumers. Triggers on deprecating dead code, wrapper shims, compatibility aliases, TODO-future-cleanup, or refactors that patch structure instead of simplifying.
license: CC-BY-NC 4.0
---

# Clean Refactor

## Overview

If nothing depends on the old form, delete it. No deprecation notice, no compatibility shim, no migration period.

A transition measure is earned by evidence of real consumers. Without that evidence, it is fake scaffolding that makes the codebase worse — it adds dead code while pretending to manage a migration that doesn't exist.

## Refactor, Don't Patch

Refactoring changes structure. Patching leaves the old structure in place and bolts on new code. Two tests distinguish them:

1. **Unreferenced structure is dead.** Delete it and replace with the smallest new structure that fits. A class that exists only because it used to, a thin wrapper with one delegating method, an `OrderValidator` added next to an unchanged `OrderProcessor` — all dead code regardless of form.
2. **Change in-place, don't layer.** If a function's job changes, change the function. Adding a new symbol alongside the old one is patching. Treat affected code like a rewrite: remove aggressively while tests pass, then add the smallest replacement.

A refactor that produces more lines, files, call depth, or public symbols than it started with is wrong. Stop and rethink.

## The Rule

**Before adding any transition measure (deprecation, alias, shim, wrapper, TODO), answer one question:**

> Does anything depend on the old form RIGHT NOW?

- **Yes, with evidence** (imports found, tests reference it, external package consumes it) → Transition measure is justified. Document what depends on it and when the migration completes.
- **No** → Delete the old form. No deprecation, no alias, no shim, no TODO.

**There is no middle ground.** "Someone might use it" is not evidence. "It feels safer" is not evidence. The analysis already ran — use its results.

## Recursive Cleanup

Deleting the old form is not the end. Trace its dependency graph — types, helpers, config entries, test fixtures — and delete anything that was dedicated to it and has zero remaining consumers. Recurse until no orphans remain.

## Red Flags

You are creating a fake transition if any of these are true:

1. **Any residual reference to the old form exists.** Removal means full elimination. An alias, wrapper, re-export, `@deprecated` annotation, TODO-remove-later comment, commented-out block, guard clause that rejects a removed value, or assertion that the old form does not exist — all are references. Delete them.
2. **Orphaned infrastructure survives.** Deleting code without tracing its dedicated helpers, types, config entries, test fixtures, and validation functions is an incomplete deletion. If it has zero remaining callers, it dies with its parent.
3. **The result is bigger or deeper.** More lines, files, public symbols, or deeper call chains than before means the requirement is unclear or the approach is wrong. Stop.
4. **Structure is layered instead of changed.** Wrapping a function instead of changing it, extracting a helper without removing the original, adding a class alongside the one it replaces, or preserving an empty shell whose responsibilities moved elsewhere — all are patching, not refactoring.

## Rationalizations and Their Rebuttals

Every excuse for keeping dead code falls into one of four categories:

1. **"Someone might need it"** → You just proved nobody does. Git history exists for recovery. Hypothetical future need is not evidence.
2. **"It's safer / standard practice / I'm being cautious"** → Deprecation is for published APIs with verified external consumers. Internal dead code gets deleted. Caution without evidence is cargo cult.
3. **"I'll clean it up later"** → No you won't. The TODO will rot. Delete it now.
4. **"I'm not keeping it, just [rejecting it cleanly / wrapping it / making it non-breaking]"** → If you recognize the old form at all — to reject, translate, warn, special-case, or delegate through — you are maintaining a compatibility gate. If no current contract references the old form, delete knowledge of it and let normal error paths handle unknown input.

## When Transition Measures ARE Justified

Real transitions have all of these:

1. **Verified consumers exist** — you found actual imports, call sites, or external packages that use the old form
2. **Breaking them is costly** — the consumers can't be updated atomically in the same change
3. **Completion criteria defined** — you know when the old form can be removed (specific PR, release, or date)

If any of these are missing, it's not a transition — it's procrastination wearing engineering clothes.
