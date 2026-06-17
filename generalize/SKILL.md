---
name: generalize
description: Use when a user provides examples prefixed by "for example", "such as", "e.g.", "like", or ends a list with "etc." / "and so on". For architecture/design tasks, abstract first to identify the concept, then enumerate. For research/clarification tasks, enumerate first — the concept organizes the output but the list is the deliverable.
license: CC-BY-SA-4.0
---

# Generalizing From Examples

## Overview

Users describe by listing instances. "Like X" or "for example Y" means they trust you to find the larger concept.

**Two imperatives; which leads depends on context:**

| Context | Lead With | Why |
|---|---|---|
| **Architecture / design** | **Abstract first** | Concept determines what to build. "Add monitoring, for example track response times" → Observability, not latency tracking. |
| **Research / clarification** | **Enumerate first** | The list IS the deliverable. Concept organizes it. |

Enumeration is always produced. The context determines which imperative drives.

## When to Use

**Triggers:**

- Example markers: "for example", "e.g.", "like", "such as", "including", "things like", "something like"
- Softening qualifiers: "or something", "and so on", "etc.", "and things like that"
- Tool-as-category: "use something like Redis" → caching, not Redis
- One concrete case where the domain obviously contains many parallel cases

**Do NOT use when:**

- Closure language: "exactly", "specifically", "only", "precisely"
- Closed-set signals: numbered lists, cardinal words ("the three things"), final "and" without "etc."
- Inherently singular scope (one bug, one file, one function)
- You're guessing categories the user wouldn't recognize as related

## Core Pattern

### The Inference Ladder

1. **Detect marker** — "for example" = illustrative, not exhaustive
2. **Isolate example** — what concept is this an instance of?
3. **Identify concept** — what ONE thing do all potential instances share?
4. **Infer scope** — architecture: all items across system; research: all items in category
5. **Enumerate cases** — always produced, never skipped
6. **Confirm boundary** — "Does this cover what you meant?"

**The ladder is recursive.** Re-climb on your own output. The most common failure is **rename-as-generalize**: your "concept" is just the example in disguise. Test: can you name instances the example didn't give? If not, re-climb.

### Closure vs. Openness Signals

The user signals either a **closed set** (complete) or an **open set** (samples). Look for the signal, not the format.

**Closure (exhaustive — do NOT add):**

| Signal | Examples |
|---|---|
| Numbered lists / cardinal words | "1. auth, 2. rate limit", "the three things are" |
| Definite quantifiers / finality | "the complete list", "nothing else", "that's it" |
| Closing conjunctions | "X, Y, and Z" (final "and" with NO "etc.") |
| Closure words | "specifically", "only", "exactly", "just" |

**Openness (illustrative — generalize freely):**

| Signal | Examples |
|---|---|
| Example markers | "for example", "e.g.", "like", "such as" |
| Softening qualifiers | "or something", "and so on", "etc." |
| Indefinite / hedging | "some", "a few", "maybe", "could include" |
| Tool-as-category | "use Redis" when context is caching strategy |

**When both present:** primary requester's directive wins. Another stakeholder's dimension is a competing scope definition, not another example — document the conflict, don't resolve by inclusion. Legal requirements (GDPR, SOC2) get flagged separately. **Drift test:** remove the primary requester's message — would your output still make sense? If yes, you've drifted.

### Abstraction Mechanics

The concept is the **invariant** across all instances — the underlying capability, not a category label.

**Abstraction depth:**

| Example (shadow) | Widening (still shadows) | Concept (the form) |
|---|---|---|
| "track response times" | "monitor all endpoints" | **Observability**: golden signals across all services |
| "use something like Redis" | "pick a cache" | **Caching layer strategy**: session store, query cache, rate limiter |
| "validate email format" | "validate other fields" | **Input integrity**: format, type, range, sanitization, business rules |

**Acid test:** present the concept without the example — would the user recognize it?

**Confidence:** 1 example = confirm before enumerating widely. 2–3 = enumerate as educated inference. 4+ = the abstraction IS the request.

### Enumeration Rules

1. Name the abstract category
2. List candidates with user's examples nested within
3. Frame additions as inference: "Based on [category], also consider [cases]."
4. If abstraction might overreach: "Do you mean [deeper concept]? If so, I'd cover [cases]."
5. Let the user trim; don't self-censor. Never replace the user's examples — build outward.

**Structure by category, not by example.** Example-anchored output means you've appended, not generalized.

❌ `Caching Research → Priority 1: Redis (user mentioned), Priority 2: Memcached`
✅ `Caching Layer Strategy → Session store: Redis, Memcached; Query cache: Redis (read-replica); Object cache: Hazelcast`

Test: can a reader identify which items the user mentioned? If yes, restructure.

## Stop and Re-climb

| What You're Doing | Why It's Wrong |
|---|---|
| Treating "for example X" as "only X" | The marker signals non-exhaustiveness. X is a starting point. |
| Asking the user to enumerate | The marker means the user expects YOU to enumerate. |
| Ignoring "etc." / "and so on" | Explicit signal the list is incomplete. MUST find more. |
| Rename-as-generalize | Abstraction only produces variations of the example. Re-climb. |
| Over-abstracting on research tasks | User wants the list. Name concept briefly, then enumerate. |
| Pattern-matching syntax not signal | "User used commas" is format-matching, not interpretation. |
| Folding competing scopes | One says "X, Y etc.", another says "scope to X." Enumerate primary requester's concept; flag the rest. |
| "The user specifically said X" | They said "for example X" — the marker IS the instruction. |
| "I don't want to over-engineer" | Under-scoping creates rework. Do it once. |
| "Better to be precise than wrong" | Precision on the example while missing the pattern is precisely wrong. |
| "I'll start with X, they can ask for more" | Delegation upward. The user expects you to do the thinking. |
| "I'll start broad and narrow down" | You'll narrow to the examples (concept drift). |

## Validation Checklist

After generalizing, verify:

1. **Concept or rename?** Can you generate instances the example didn't give?
2. **All cases same concept?** No mixed categories.
3. **Reader can't identify user's items.** If they can pick them out, restructure.
4. **Concept stable through enumeration.** Every item traces to primary requester's concept.

## Example Dialogues

**User:** "Add input validation to the form fields, for example the email field."

❌ *Adds validation only to email.*
✅ "I'll add validation to all form fields — email (format), password (strength), username (length/characters), phone (format). Both client and server. Sound right?"

**User:** "We should handle API errors better, e.g., the 401 on the login page."

❌ *Only handles 401 on login page.*
✅ "Structured error handling across the app. Login: 401, 429, 500, network failures. Same pattern on signup, password reset, settings — they share the API error surface."
