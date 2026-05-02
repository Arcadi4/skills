---
name: ui-unification-audit
description: Use when auditing a frontend codebase for duplicated UI components, inconsistent design-system usage, or hand-rolled variants of existing primitives. Triggers on "find duplicated components", "audit design system consistency", "find UI drift", or reviewing a component library for gaps.
---

# UI Unification Audit

## Overview

Systematically find UI components and layouts that were intended to be unified but diverged. The core distinction: **necessary layout variants** (justified by different data/interaction needs) vs **actual mismatches** (shared primitive exists but is bypassed or duplicated).

## When to Use

- Codebase has a `components/ui/` or design-system layer but pages still hand-roll equivalent markup
- Multiple files import a shared component AND re-declare its base styles
- Components live under a domain folder but are imported cross-domain
- You see repeated className clusters across route files (cards, badges, buttons, empty states)
- Before a design-system refactor to identify highest-impact targets

**Not for:** Greenfield projects without existing primitives, pure CSS audits, accessibility-only reviews.

## Core Pattern

```
1. INVENTORY  → Map shared primitives (components/ui/*, CSS utilities, global classes)
2. SEARCH     → Find all usages AND hand-rolled equivalents across routes/components
3. CLASSIFY   → For each candidate: necessary variant or actual mismatch?
4. RANK       → By confidence (primitive exists + bypassed = highest) and blast radius
```

## Quick Reference

| Signal | Likely Mismatch | Likely Justified Variant |
|--------|----------------|------------------------|
| File imports primitive AND re-declares its base classes | ✅ Mismatch | |
| Component in domain folder imported by other domains | ✅ Misplaced | |
| Same 4-corner-bracket divs rendered manually when `CornerBrackets` exists | ✅ Bypass | |
| Detail page header is richer than list page header | | ✅ Needs variant prop |
| Loading skeleton has different grid columns per page | | ✅ Geometry is page-specific |
| Empty state uses smaller padding in inline context | | ✅ Needs size variant |
| Selectable card in picker looks like button but isn't | | ✅ Different interaction model |
| Two components share 80%+ markup but differ in collapse/action slots | ✅ Extract shell | |

## Implementation

### Phase 1: Inventory Shared Primitives

```bash
# List all UI primitives
ls components/ui/
# Find CSS utility classes (page-container, section-label, mono-label, guide-line)
rg "@apply|@layer" app/globals.css
# Find component exports
rg "export (function|const)" components/ui/ -g '*.tsx'
```

### Phase 2: Search for Bypasses and Duplicates

Run all searches in parallel for maximum throughput.

**A. Imports of each primitive** — Identifies consumers. Files that import a primitive AND re-declare its styles are the strongest mismatch signal.

```bash
rg "from \"@/components/ui/" app components -g '*.tsx'
```

**B. Hand-rolled equivalents** — For each primitive identified in Phase 1, extract its signature className cluster (the 3-5 most distinctive utility classes or CSS properties that define its visual identity) and grep for those patterns. Files that render these class clusters WITHOUT importing the primitive are bypasses.

How to construct the grep for each primitive:
1. Read the primitive's source to identify its core visual classes (layout, border, typography, spacing)
2. Build a regex that matches the key classes in proximity, using `.*` between tokens to allow ordering variation
3. Exclude the primitive's own file from results
4. Also search for the primitive's CSS-in-JS equivalent if the codebase mixes approaches (e.g., `makeStyles`, `styled.div`, `sx={{`)

```bash
# Template — fill in per primitive:
rg "<key-class-1>.*<key-class-2>.*<key-class-3>" <search-paths> -g '*.tsx' -g '!<primitive-source-file>'
```

**C. Structural bypasses via AST** — Use `ast_grep_search` to find raw HTML elements that map to existing primitives. For each primitive, derive the HTML tag it renders and search for raw instances of that tag in page/component code.

```
# Templates — adapt per primitive:
pattern: <button $$$>$BODY</button>       # Potential button primitive bypasses
pattern: <dialog $$$>$BODY</dialog>       # Potential modal primitive bypasses
pattern: <table $$$>$BODY</table>         # Potential table primitive bypasses
pattern: <input $$$>                      # Potential input primitive bypasses
```

**D. Cross-domain imports** — Find components in domain-specific folders that are imported by other domains (misplaced shared components).

```bash
# For each domain folder, find its exports that are imported elsewhere:
rg "from \"@/app/(domains|features)/<domain>/components/" -g '*.tsx' --files-with-matches
```

### Phase 3: Classify Each Candidate

For each divergence found, ask:

1. **Does a shared primitive already exist for this role?** If yes → likely mismatch.
2. **Does the file already import the primitive?** If yes → strong mismatch signal.
3. **Is the divergence in styling or in structure/behavior?** Styling-only → mismatch. Different slots/interactions → may need variant.
4. **Is the component in the wrong directory?** Domain component imported cross-domain → misplaced.
5. **Would adding a variant prop to the existing primitive cover this?** If yes → mismatch (missing variant). If no → may be justified separate component.

### Phase 4: Rank and Report

Order by:
1. **Primitive exists + bypassed** (highest confidence)
2. **Primitive exists + needs variant** (high confidence)
3. **No primitive exists + pattern repeated 3+ times** (medium confidence)
4. **Architectural misplacement** (cross-domain imports)

## Common Mistakes

- **Treating all visual differences as defects.** A detail page header being richer than a list page header is not a bug — it needs a variant, not flattening.
- **Ignoring unused props on existing primitives.** Props like `color`/`pattern` defined but never wired up indicate abandoned unification intent.
- **Only searching imports.** The worst mismatches are files that DON'T import the primitive — they hand-roll it entirely.
- **Conflating loading skeletons with real components.** Skeleton geometry is page-specific by nature; only the primitive toolkit location and bracket/overlay reuse are audit targets.
- **Reporting without classification.** A flat list of "these look similar" is not actionable. Always classify: mismatch vs justified variant vs needs-new-primitive.
