---
name: clean-refactor
description: Use when removing dead code, renaming symbols, deleting unused exports, or refactoring — any change where nothing external depends on the old form. Triggers on deprecation annotations added to dead code, wrapper shims around renamed functions, compatibility aliases with zero consumers, or TODO-future-cleanup comments instead of cleaning now.
license: CC-BY-NC 4.0
---

# Clean Refactor

## Overview

If nothing depends on the old form, delete it. No deprecation notice, no compatibility shim, no migration period.

A transition measure is earned by evidence of real consumers. Without that evidence, it is fake scaffolding that makes the codebase worse — it adds dead code while pretending to manage a migration that doesn't exist.

## The Rule

**Before adding any transition measure (deprecation, alias, shim, wrapper, TODO), answer one question:**

> Does anything depend on the old form RIGHT NOW?

- **Yes, with evidence** (imports found, tests reference it, external package consumes it) → Transition measure is justified. Document what depends on it and when the migration completes.
- **No** → Delete the old form. No deprecation, no alias, no shim, no TODO.

**There is no middle ground.** "Someone might use it" is not evidence. "It feels safer" is not evidence. The analysis already ran — use its results.

## Quick Reference

| Situation | Clean refactor | Fake transition (WRONG) |
|---|---|---|
| Dead export, zero importers | Remove `export` or delete function | Add `@deprecated` annotation |
| Renamed function, zero callers of old name | Delete old name | Keep old name as alias: `export const old = new` |
| Changed function signature, zero external callers | Change signature directly | Add wrapper with old signature that calls new one |
| Removed feature, zero references | Delete all code | Comment out "in case we need it later" |
| Moved function to new module, updated all imports | Delete from old location | Re-export from old location "for compatibility" |

## Red Flags — STOP and Refactor Cleanly

You are creating a fake transition if you are about to:

- Add `@deprecated` to code that has zero consumers
- Write `export const oldName = newName` when nothing imports `oldName`
- Create a wrapper function that just calls another function, "for backward compatibility"
- Add a TODO comment like "remove after migration" when there is nothing to migrate
- Leave dead code in place "for reference" instead of trusting version control
- Add a compatibility layer between old and new code when no external consumer exists
- Keep an unused re-export in a barrel file "in case something needs it"

**All of these mean: delete the code and move on.**

## Rationalization Table

| Excuse | Reality |
|---|---|
| "Someone might depend on it" | You just proved nobody does. If someone needs it later, git has the history. |
| "Deprecation is standard practice" | Deprecation exists for published APIs with external consumers. Internal dead code gets deleted. |
| "It's safer to deprecate first" | It's not safer — it's more code to maintain, more surface area to confuse future readers, and it never gets cleaned up. |
| "I'll clean it up later" | No you won't. The TODO will rot. Delete it now. |
| "What if we need to revert?" | That's what version control is for. The old code is one `git log` away. |
| "The wrapper makes the refactor non-breaking" | There's nothing to break — zero consumers. The wrapper is dead code on arrival. |
| "I'm being cautious" | Caution with evidence is engineering. Caution without evidence is cargo cult. |

## When Transition Measures ARE Justified

Real transitions have all of these:

1. **Verified consumers exist** — you found actual imports, call sites, or external packages that use the old form
2. **Breaking them is costly** — the consumers can't be updated atomically in the same change
3. **Completion criteria defined** — you know when the old form can be removed (specific PR, release, or date)

If any of these are missing, it's not a transition — it's procrastination wearing engineering clothes.
