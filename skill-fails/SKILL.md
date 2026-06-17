---
name: skill-fails
description: Use when an agent violates a loaded skill despite it being present in context — a gap exists between what the skill says and what the agent did. Also use when reviewing skill effectiveness after a violation, or when deciding whether a skill needs enhancement vs the failure is tolerable.
license: CC-BY-NC-4.0
---

# Identify Skill Failures

## Overview

When an agent violates a loaded skill, a gap exists between the skill's instructions and the agent's behavior. This skill provides a 4-step post-mortem to close that gap with a targeted enhancement — or decide the failure is tolerable.

## When to Use

- Agent violated a skill that was loaded in context
- Mismatch between skill recommendation and agent action
- Deciding: enhance the skill, or tolerate?

**Do NOT use when:** skill wasn't loaded (teach, don't fix), agent followed skill but got wrong result (skill is wrong, not unenforced), or context couldn't contain the skill at all.

## Core Pattern — 4-Step Post-Mortem

| Step | Question |
|---|---|
| 1. **Capture violation** | What did the agent do vs what does the skill say? Quote both. |
| 2. **Classify gap** | Why did the instruction fail to prevent the behavior? Use taxonomy below. |
| 3. **Assess tolerability** | Context window % at failure × severity. Fix or tolerate? |
| 4. **Propose enhancement** | One targeted edit to close that specific gap. |

## Gap Taxonomy

| Gap | Symptom | Fix |
|---|---|---|
| **Passive language** | Rule stated but no enforcement gate. Agent reads, doesn't internalize. | Add a concrete check. |
| **Missing anti-pattern** | Skill shows correct behavior, never wrong. Agent violates without recognizing it. | Add counter-example. |
| **Rationalization loophole** | Agent's excuse not covered in prevention table. | Add the excuse + counter. |
| **Cognitive-load bypass** | Rule buried in prose. Agent under pressure skims past it. | Move to scannable position (red flag, bold, gate). |
| **Contradictory guidance** | Two rules conflict. Agent picks the easier one. | Resolve contradiction. |
| **Context-window attenuation** | Skill loaded early, details lost by action time. | Rarely a skill fix. Move critical rules earlier or add gate. |

## Tolerability

Context window fullness at failure time is the primary toleration factor.

| Context % | Minor severity | Severe severity |
|---|---|---|
| < 50% | Fix — agent had room | Fix — no excuse |
| 50–80% | Judgment call | Fix — severity demands it |
| > 80% | Tolerate — context explains it | Fix anyway |

Severe = security, data loss, irreversible, user-visible breakage. Minor = style, verbosity, suboptimal structure.

## Enhancement Format

One edit, not a rewrite:

```
Gap: [type]
Skill says: "[quote]"
Agent did: "[quote]"
Proposed fix: [one edit — gate, counter-example, rationalization row, or reorder]
```

## Example: Checklist Body (skill commit)

**Violation:** Agent wrote bullet-point checklist as commit body: "Merged: - A + B - C..."

**Skill said:** "Body tells a story, not a checklist."

**Gap:** Passive language. No enforcement — just "read aloud."

**Context:** ~60%. Fix needed.

**Fix:** Added concrete body gate rejecting bullets/lists/headers. Added to Rationalizations and Common Mistakes.

## Common Mistakes

| Mistake | Fix |
|---|---|
| Rewriting the skill instead of a targeted edit | One edit, one gap. |
| Blaming the agent | Skills prevent failures. If it didn't, the skill has a gap. |
| Fixing context-window failures in the skill | Long context is environmental. Only fix if severe. |
| Adding a rule without a gate | Rules without enforcement are passive. |

## Validation

After proposing an enhancement:
1. Would this have prevented the specific violation?
2. Does the fix address the gap type, or just restate the rule?
3. Did you avoid rewriting unrelated sections?
4. If context >80%, is this a skill fix or a loading/positioning fix?
