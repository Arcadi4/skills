---
description: Generalize from examples the user provides. Abstract to the real concept, then enumerate comprehensively.
---

# Generalize Command

When a user describes by listing instances ("for example X", "like Y", "such as Z"), they trust you to find the larger concept. Your job: abstract, then enumerate.

## The Inference Ladder

Always visit all six rungs. Which rung leads depends on context:

```
1. Detect marker     →  "for example" = illustrative, not exhaustive
2. Isolate example   →  what concept is this an instance of?
3. ▼ ABSTRACT ▼
   Identify concept  →  what ONE thing do all potential instances share?
4. Infer scope       →  architecture: all relevant items across the system
                        research: all matching items in the category
5. ENUMERATE CASES   →  always produced, never skipped
6. Confirm boundary  →  "Does this cover what you meant?"
```

## Context-Driven Priority

| Context | Lead With | Why |
|---|---|---|
| **Architecture / design** | **Abstract first** (rung 3) | Concept determines what to build |
| **Research / clarification** | **Enumerate first** (rung 5) | The list IS the deliverable; concept organizes it |

Both imperatives always active. Either way: enumerate. Concept is a structure multiplier, not a prerequisite.

## Signals to Generalize vs. Bound

**Generalize** when the user uses: "for example", "e.g.", "like", "such as", "including", "something like", "etc.", "and so on", "or whatever".

**Do NOT add** when the user signals closure: "exactly", "specifically", "only", "just", numbered exhaustive lists, cardinal words ("the three things").

## Abstraction Depth — Find the Concept, Not a Bigger Example

| Example (shadow) | Widening (still shadow) | Concept (the form) |
|---|---|---|
| "track response times" | "monitor all endpoints" | **Observability**: golden signals, dashboards, alerting |
| "use something like Redis" | "pick a cache" | **Caching layer strategy**: session store, query cache, rate limiter |
| "validate email format" | "validate other fields" | **Input integrity**: format, type, range, sanitization, business rules |

**Test**: present the concept without the example — would the user recognize it? Can you generate instances the example didn't give? If only variations of the original → renamed, not abstracted.

## Structure by Category, Not by Example

Output must reflect the abstraction, not the user's examples.

❌ Example-anchored: P1 = what they said, P2 = additions  
✅ Category-anchored: all items grouped by concept, user's examples nested within

## Meta-Application: Triggers and Descriptions

For skill descriptions, `When to Use`, trigger lists, rubrics, and documentation rules: name the condition first; keep examples as symptoms.

❌ Example-anchored trigger: lists artifact types as the primary signal  
✅ Concept-anchored trigger: names the pattern, e.g. `implementation mirrors request wording more than domain needs`

Gate: if trigger text lets a reader identify the user's examples as the use case, re-climb.

## Conflicting Signals

When multiple stakeholders give conflicting directives (e.g., one says "X, Y, etc." and another says "scope to X only"):

1. **Primary requester's closure directive** is a hard boundary
2. Other stakeholders' signals are context, not additional scope
3. Document the conflict; don't resolve by over-inclusion

## Abstraction Confidence

| Examples | Confidence | Action |
|---|---|---|
| 1 | Weak | Infer, **must confirm** before enumerating widely |
| 2-3 | Moderate | Enumerate, present as educated inference |
| 4+ | Strong | Present the category as the real ask |

## Validation Checklist

After generalizing, verify:

1. **Concept or rename?** Can you produce instances unlike the original? If not — re-climb.
2. **Reader can't identify user's items.** If they can — restructure by category.
3. **Trigger text concept-anchored?** If writing a description or `When to Use`, it names the condition, not the examples.
4. **Concept stable through enumeration.** Every domain traces back to the primary requester's examples.
5. **Confirm boundary.** "Does this cover what you meant?"

## Red Flags — Stop and Re-climb

- "I'll just do what they mentioned"
- Treating "for example X" as "only X"
- Elevating user's examples to priority 1
- Losing the concept mid-enumeration
- Pattern-matching syntax instead of interpreting signal
- Folding competing scopes by including everything

**All of these mean**: re-read the user's message, find the example marker, climb the ladder.

## Arguments

$ARGUMENTS: The user's message containing examples to generalize from.
