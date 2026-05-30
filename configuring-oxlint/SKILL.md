---
name: configuring-oxlint
description: Use when configuring or enhancing oxlint rules for a JavaScript/TypeScript project, when deciding which lint rules to enable beyond the default correctness category, or when evaluating whether a lint rule's autofix status and noise level make it worth enabling. Also use when bulk-enabling pedantic or style categories has produced excessive noise.
---

# Configuring Oxlint

Work in small batches. For each candidate rule: read docs → grep codebase → configure → lint → evaluate → iterate. Never bulk-enable categories.

## The Iteration Loop

For each rule (or small batch of related rules):

**1. Discover candidates.** Start at the [rules listing](https://oxc.rs/docs/guide/usage/linter/rules). Filter by category (Pedantic/Perf/Style) and scan for 🛠️ or 💡 fix icons. These are your best candidates — autofixable rules add value with zero cleanup cost. Then dive into individual rule pages (`.../rules/{plugin}/{rule-name}`) for candidates that look promising. From each page, extract: fix status, whether it requires type-aware linting (💭 — skip if not configured), and config options (many rules have conservative modes).

**2. Grep for noise.** Search the codebase for violations. Zero matches → free to enable. Many matches → check if autofixable; if not, weigh signal against cleanup cost.

**3. Configure & lint.** Add the rule with the most conservative config scope for a first pass. Run `pnpm lint`, check exit code and output volume.

**4. Evaluate.** Are warnings actionable? If autofixable, does `pnpm lint:fix` produce a safe diff? Noise? Tighten config or remove. Genuine bugs? Keep. Then pick the next rule.

**Framework conflicts to watch for:** `eslint/no-ternary` is fatal for JSX. `import/no-named-export` contradicts hooks patterns. `import/no-nodejs-modules` false-positives on API routes. Grep for these patterns before enabling — in most cases, skip these rules entirely.

## Decision Framework

| Fix status | Action |
|---|---|
| 🛠️ safe autofix | Always enable. `lint:fix` eliminates all noise. |
| 💡 suggestion | Enable. Low cost, manually accept. |
| No fix, zero violations in codebase | Enable. Free future protection. |
| No fix, moderate violations | Judge signal vs noise. Good signal, few hits → enable. Low signal, many hits → skip. |
| ⚠️🛠️ dangerous autofix | Only with conservative config options. |
| Arbitrary thresholds (`max-*`) | Skip unless explicitly desired. |

## Config Template

```jsonc
{
  "categories": {
    "correctness": "error",
    "perf": "warn",
    "suspicious": "warn"
    // Don't add pedantic or style — enable rules individually
  },
  "rules": {
    // Each rule added after the iteration loop above:
    "eslint/arrow-body-style": "warn",
    "eslint/curly": ["warn", "multi-line"]
  }
}
```

## Common Mistakes

- **Bulk-enabling pedantic/style, then silencing noise with 20+ overrides.** Each override is an untested disable. Evaluate individually.
- **Skipping the Configuration section of rule docs.** Options like `"smart"` mode or `"multi-line"` scope transform noisy rules into valuable ones.
- **Not grepping before enabling.** Zero-violation rules are free wins. High-violation non-fixable rules waste time.
- **One-pass configuration.** Rules interact — a rule that seems noisy alone might be fine after fixing another's warnings. Iterate in small batches.
