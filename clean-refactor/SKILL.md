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

Refactoring changes structure. Patching leaves the old structure in place and bolts on new code.

- **If nothing references the original structure, delete it.** A class or module that exists only because it used to be there is dead code. Replace it with the smallest new structure that fits the current design.
- **Don't add new functions, classes, or modules just to satisfy a structural requirement.** An `OrderValidator` class next to an unchanged `OrderProcessor` is lazy structure, not clean design.
- **Redefine the semantics of existing code.** If a function's job changes, change the function — don't wrap it.
- **Treat the affected code like a rewrite.** Remove old pieces aggressively while tests pass, then add the smallest replacement.
- **If the old structure becomes a thin wrapper, delete it.** A class with one delegating method is dead code with extra syntax.

## A Refactor Must Simplify

If the result has more lines, files, deeper call chains, or public symbols, stop. The requirement is unclear or the approach is wrong. Clean refactor reduces surface area.

## The Rule

**Before adding any transition measure (deprecation, alias, shim, wrapper, TODO), answer one question:**

> Does anything depend on the old form RIGHT NOW?

- **Yes, with evidence** (imports found, tests reference it, external package consumes it) → Transition measure is justified. Document what depends on it and when the migration completes.
- **No** → Delete the old form. No deprecation, no alias, no shim, no TODO.

**There is no middle ground.** "Someone might use it" is not evidence. "It feels safer" is not evidence. The analysis already ran — use its results.

## Recursive Cleanup

Deleting the old form is not the end. Trace its dependency graph — types, helpers, config entries, test fixtures — and delete anything that was dedicated to it and has zero remaining consumers. Recurse until no orphans remain.

## Quick Reference

| Situation | Clean refactor | Fake transition (WRONG) |
|---|---|---|
| Dead export, zero importers | Remove `export` or delete function | Add `@deprecated` annotation |
| Renamed function, zero callers of old name | Delete old name | Keep old name as alias: `export const old = new` |
| Changed function signature, zero external callers | Change signature directly | Add wrapper with old signature that calls new one |
| Removed feature, zero references | Delete all code | Comment out "in case we need it later" |
| Removed enum/string values, zero current consumers | Remove constants, docs, tests, and all references | Add explicit guards like `case "old": return error` |
| Moved function to new module, updated all imports | Delete from old location | Re-export from old location "for compatibility" |
| Deleted function had a dedicated helper with zero other callers | Delete the helper too | Leave helper in place "it might be useful" |
| Removed type that had a dedicated validation function, zero other refs | Delete the validation function | Keep it "as a utility" |
| Refactor adds a new class/function just to patch structure | Redefine existing responsibilities and remove leftover scaffolding | Leave old structure in place and add a parallel helper/class |
| Refactor produces more LoC or deeper call chains | Stop and clarify the requirement or rethink the design | Add layers until the code "works" |
| Function/object semantics need to change | Change the existing function/object directly | Add a wrapper/adapter that preserves the old semantics |
| Old structure's responsibilities have moved out and nothing references it | Delete the old class/module and express what's left in the new shape | Keep the original class/module as a stripped-down coordinator |

## Red Flags — STOP and Refactor Cleanly

You are creating a fake transition if you are about to:

- Add `@deprecated` to code that has zero consumers
- Write `export const oldName = newName` when nothing imports `oldName`
- Create a wrapper function that just calls another function, "for backward compatibility"
- Add a TODO comment like "remove after migration" when there is nothing to migrate
- Leave dead code in place "for reference" instead of trusting version control
- Add a compatibility layer between old and new code when no external consumer exists
- Add a parser or validator branch that recognizes removed legacy values only to reject, translate, warn, or special-case them
- Keep an unused re-export in a barrel file "in case something needs it"
- Delete a function but leave its dedicated helper, type, or config entry behind
- Stop cleanup at the direct target without checking what it depended on
- Add a new function, class, or module just to satisfy a structure requirement while leaving the old structure intact
- Finish a refactor with more total code or deeper call chains than you started with
- Wrap an existing function instead of changing its semantics
- Extract code into a helper but leave the original duplicated logic in place
- Leave a class or object in place after it has become a thin wrapper around the new code
- Preserve the original class/module/function shape after its responsibilities have moved elsewhere

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
| "I'm not supporting it, only rejecting it cleanly" | Recognizing the old value is still a compatibility gate. If the old form has no current contract, delete knowledge of it and let the normal parser or error path handle it. |
| "I'm being cautious" | Caution with evidence is engineering. Caution without evidence is cargo cult. |
| "The helper might be useful elsewhere" | It has zero callers. If someone needs it, they'll write it — or find it in git history. |
| "I only needed to remove the one function" | You needed to remove the dead code. Its dedicated infrastructure is also dead code. |
| "I just extracted a helper" | Extraction without removing the duplicated original is duplication, not refactoring. |
| "The old class still works" | If its responsibilities moved elsewhere, it's dead code wearing a familiar name. |
| "I'll keep both shapes for now" | That's a compatibility layer. It is only justified for verified external consumers. |
| "Changing all callers is too risky" | Internal callers can be updated in the same change. Risk without evidence is cargo cult. |

## When Transition Measures ARE Justified

Real transitions have all of these:

1. **Verified consumers exist** — you found actual imports, call sites, or external packages that use the old form
2. **Breaking them is costly** — the consumers can't be updated atomically in the same change
3. **Completion criteria defined** — you know when the old form can be removed (specific PR, release, or date)

If any of these are missing, it's not a transition — it's procrastination wearing engineering clothes.
