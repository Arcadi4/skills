---
name: generalize
description: Use when a user provides examples prefixed by "for example", "such as", "e.g.", "like", or ends a list with "etc." / "and so on". For architecture/design tasks, abstract first to identify the concept, then enumerate. For research/clarification tasks, enumerate first — the concept organizes the output but the list is the deliverable.
license: CC-BY-SA-4.0
---

# Generalizing From Examples

## Overview

Users describe by listing instances. "Like X" or "for example Y" means they trust you to find the larger concept. This skill applies during **design, planning, and clarification** — when you need to understand what to build before building it.

**Two imperatives; which leads depends on context:**

| Context | Lead Imperative | Why |
|---|---|---|
| **Architecture / design** | **Abstract first** | Concept determines what to build. "Add monitoring, for example track response times" → Observability, not latency tracking. |
| **Research / clarification** | **Enumerate first** | The list IS the deliverable. Concept organizes it. |

Enumeration always produced. Concept structures it.

## When to Use

**Triggers — load this skill when the user:**

- Uses example markers: "for example", "e.g.", "like", "such as", "including", "things like", "something like"
- Uses softening qualifiers: "or something", "and so on", "etc.", "and things like that"
- Names a tool when context signals the category: "use something like Redis" → caching, not Redis
- Gives one concrete case where the domain obviously contains many parallel cases

**Do NOT use when:**

- Closure language without example markers: "exactly", "specifically", "only", "precisely"
- Closure signals: numbered lists, cardinal words ("the three things"), final "and" without "etc."
- Inherently singular scope (one bug, one file, one function)
- You're guessing categories the user wouldn't recognize as related

## Core Pattern

### The Inference Ladder

Six rungs, always visited. Which rung drives the climb depends on context:

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

Architecture/design tasks driven from rung 3 (abstract first). Research/clarification from rung 5 (enumerate first).

**The ladder is recursive.** Re-climb on your own output. The most common failure is **rename-as-generalize**: your "concept" is just the example in disguise. Test: can you name instances the example didn't give? If your concept only produces variations of the original example, re-climb. See Validation for full checks.

### Closure Signals vs. Openness Signals

The user signals either a **closed set** (complete) or an **open set** (samples). Look for the signal, not the format.

**Closure signals (exhaustive — do NOT add):**

| Mechanism | Examples |
|---|---|
| Numbered lists | "1. auth, 2. rate limit, 3. logging" |
| Cardinal words | "the three things are", "both of these" |
| Definite quantifiers | "the complete list", "everything we need" |
| Closing conjunctions | "X, Y, and Z" (final "and" with NO "etc.") |
| Closure words | "specifically", "only", "exactly", "just", "that's it" |
| Finality language | "these are the ones", "nothing else" |

**Openness signals (illustrative — generalize freely):**

| Mechanism | Examples |
|---|---|
| Example markers | "for example", "e.g.", "like", "such as" |
| Softening qualifiers | "or something", "and so on", "etc.", "and things like that" |
| Indefinite quantifiers | "some", "a few", "several" |
| Hedging language | "maybe", "perhaps", "could include" |
| Tool-as-category | "use Redis" when context is caching strategy |

When both present, **primary requester wins**. If user says "X, Y, etc." and another stakeholder says "scope to X", enumerate the primary requester's concept and flag the conflict.

### Conflicting Signals (Multiple Stakeholders)

When a query contains conflicting signals from different stakeholders (e.g., one says "X, Y, etc." and another says "scope to X only"), the enumeration scope follows the **primary requester's directive**.

| Priority | Signal Type | Action |
|---|---|---|
| 1 | Primary requester's closure directive | Hard boundary. "Scope to what X asked for" → revert to X's examples only. |
| 2 | Legally-mandated requirements (GDPR, SOC2) | Flag separately with rationale. Do NOT silently fold into the primary concept. |
| 3 | Other stakeholders' openness signals | Additional context, not additional scope. Acknowledge, defer, don't enumerate into primary output. |

Another stakeholder's dimension is a **competing scope definition**, not another example. Document the conflict; don't resolve it by inclusion. **Test:** remove the primary requester's message — would your output still make sense? If yes, you've drifted.

### Abstraction Mechanics

**Concept identification (rung 3):**

The concept is the **invariant** across all instances. Not a category label, but the underlying capability or property.

**Abstraction depth:**

| Example (shadow) | Widening (still shadows) | Concept (the form) |
|---|---|---|
| "track response times" | "monitor all endpoints" | **Observability**: golden signals across all services |
| "use something like Redis" | "pick a cache" | **Caching layer strategy**: session store, query cache, rate limiter |
| "validate email format" | "validate other fields" | **Input integrity**: format, type, range, sanitization, business rules |

**Acid test:** present the concept without the example — would the user recognize it?

**Abstraction confidence gates:**

| Examples | Confidence | Action |
|---|---|---|
| 1 | Weak | Infer pattern, **must confirm** with user before enumerating widely. |
| 2-3 | Moderate | Abstract and enumerate. Present as educated inference. |
| 4-5 | Strong | Present the category as the real ask. Enumerate confidently. |
| 6+ | Very strong | The abstraction IS the request. Enumerate comprehensively. |

**Scope inference (rung 4):**

Architecture/design: Find all relevant instances across the system.
Research/clarification: Find all matching instances in the category.

**Enumeration (rung 5):**

Always produced. List concrete instances with enough detail to act on.

1. Name the abstract category
2. List candidates with user's examples nested within
3. Frame additions as educated inference: "Based on [category], also consider [cases]."
4. If abstraction might overreach: "Do you mean [deeper concept]? If so, I'd cover [cases]."
5. Let the user trim; don't self-censor. Never replace the user's examples — build outward.

**Structure output by category, not by example:**

The output structure must reflect the abstraction. Example-anchored output (P0 = what they said) means you've appended, not generalized.

❌ **Example-anchored:** `Caching Research → Priority 1: Redis (user mentioned), Priority 2: Memcached`
✅ **Category-anchored:** `Caching Layer Strategy → Session store: Redis, Memcached; Query cache: Redis (read-replica); Object cache: Hazelcast`

**Test:** can a reader identify which items the user mentioned? If yes, restructure.

## Common Failures

| Failure Mode | Why It's Wrong |
|---|---|
| Treating "for example X" as "only X" | The marker signals non-exhaustiveness. X is a starting point. |
| Generalizing without confirming | Enumerate and ask. Don't silently expand scope. |
| Asking the user to enumerate | The marker means the user expects YOU to enumerate. |
| Ignoring "etc." and "and so on" | Explicit signal the list is incomplete. MUST find more. |
| **Rename-as-generalize** | Your abstraction only produces variations of the example → renamed, not abstracted. Re-climb. |
| **Over-abstracting on research tasks** | User wants the list. Name concept briefly, then enumerate. |
| Pattern-matching syntax instead of signal | "User used commas" is format-matching, not interpretation. |
| **Folding competing scopes** | One says "X, Y etc.", another says "scope to X." Enumerate primary requester's concept; flag the rest. |

## Rationalizations (Stop)

| Rationalization | Reality |
|---|---|
| "The user specifically said X" | They said "for example X" — the marker IS an instruction to generalize. |
| "I don't want to over-engineer" | Under-scoping creates rework. Do it once. |
| "Better to be precise than wrong" | Precision on the example while missing the pattern is precisely wrong. |
| "If they wanted Y they would have said Y" | The example marker IS them saying Y. |
| "I'll start with X and they can ask for more" | Delegation upward. The user expects you to do the thinking. |

## Red Flags (Re-climb)

- "I'll just do what they mentioned" / "handle other cases if they ask"
- Losing the concept mid-enumeration, listing concrete implementations instead
- Returning to example-anchored language after category-anchored
- Adding domains from non-primary stakeholders
- Resolving conflicting directives by including everything
- "I'll start broad and narrow down" — you'll narrow to the examples (concept drift)

## Validation

After generalizing, verify:

1. **Concept or rename?** Present concept without example. Would user recognize it? Can you generate instances the example didn't give?
2. **All cases same concept?** No mixed categories.
3. **Reader can't identify user's items.** If they can pick them out, restructure by category.
4. **Concept stable through enumeration.** Every domain traces to primary requester's examples. Remove primary requester — output still makes sense? You drifted.

## Example Dialogues

**User:** "Add input validation to the form fields, for example the email field."

❌ *Adds validation only to email.*
✅ "I'll add validation to all form fields — email (format), password (strength), username (length/characters), phone (format). Both client and server. Sound right?"

**User:** "We should handle API errors better, e.g., the 401 on the login page."

❌ *Only handles 401 on login page.*
✅ "Structured error handling across the app. Login: 401, 429, 500, network failures. Same pattern on signup, password reset, settings — they share the API error surface."

**User:** "We should add monitoring, for example track response times on the user endpoints."

❌ *Adds response time tracking to all endpoints.* (Widened, didn't climb.)
✅ "Observability. Response times are one golden signal — I'll instrument latency (p50/p95/p99), error rate, throughput, and saturation across all services. For user endpoints: response times, error rate by endpoint, request volume, DB connection pool saturation. Scoped to latency for now, or full monitoring?"
