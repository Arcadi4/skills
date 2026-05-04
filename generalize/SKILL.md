---
name: generalize
description: Use when a user provides examples prefixed by "for example", "such as", "e.g.", "like", or ends a list with "etc." / "and so on". For architecture/design tasks, abstract first to identify the concept, then enumerate. For research/clarification tasks, enumerate first — the concept organizes the output but the list is the deliverable. Most valuable for documentation, planning, and research; less necessary for direct implementation with sufficient domain context.
license: CC-BY-SA-4.0
---

# Generalizing From Examples

## Overview

Users describe by listing instances. "Like X" or "for example Y" means they trust you to find the larger concept. This skill applies to documentation, planning, and research — contexts where output structure depends on the concepts you identify.

**Two imperatives; which leads depends on context:**

| Context | Lead Imperative | Why |
|---|---|---|
| **Architecture / design** | **Abstract first** | Concept determines what to build. "Add monitoring, for example track response times" → Observability, not latency tracking. |
| **Research / clarification** | **Enumerate first** | The list IS the deliverable. Concept organizes it. |

Both imperatives always active. Output is a decision → concept leads. Output is a list → enumeration leads. Either way: enumerate. Concept is a structure multiplier, not a prerequisite.

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

**The ladder is recursive.** Re-climb on your own output. The most common failure is **rename-as-generalize**: your "concept" is just the example in disguise. Test: can you name instances the example didn't give? If your concept only produces variations of the original example, re-climb.

**Post-abstraction checks:**
- "What IS this concept, not what is it called?" If someone read only the concept name, would they generate the same instances?
- "What would I produce if the user gave a DIFFERENT instance?" Answer changes radically → example-bound, not concept-bound.

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
| Example markers | "for example", "e.g.", "such as", "like", "including" |
| Open-ended qualifiers | "etc.", "and so on", "and things like that" |
| Softening language | "kind of like", "something like", "or whatever" |
| Trailing openness | "X, Y, Z, etc." — the "etc." overrides the list form |
| Hedging | "maybe", "probably", "I'm not sure but" |

### Conflicting Signals (Multiple Stakeholders)

When a query contains conflicting signals from different stakeholders (e.g., one says "X, Y, etc." and another says "scope to X only"), the enumeration scope follows the **primary requester's directive**.

| Priority | Signal Type | Action |
|---|---|---|
| 1 | Primary requester's closure directive | Hard boundary. "Scope to what X asked for" → revert to X's examples only. |
| 2 | Legally-mandated requirements (GDPR, SOC2) | Flag separately with rationale. Do NOT silently fold into the primary concept. |
| 3 | Other stakeholders' openness signals | Additional context, not additional scope. Acknowledge, defer, don't enumerate into primary output. |

Another stakeholder's dimension is a **competing scope definition**, not another example. Document the conflict; don't resolve it by inclusion. **Test:** remove the primary requester's message — would your output still make sense? If yes, you've drifted.

### Abstraction Confidence Gates

| Examples | Confidence | Action |
|---|---|---|
| 1 | Weak | Infer pattern, **must confirm** with user before enumerating widely. |
| 2-3 | Moderate | Abstract and enumerate. Present as educated inference. |
| 4-5 | Strong | Present the category as the real ask. Enumerate confidently. |
| 6+ | Very strong | The abstraction IS the request. Enumerate comprehensively. |

### Enumeration Step

1. Name the abstract category
2. List candidates with user's examples nested within
3. Frame additions as educated inference: "Based on [category], also consider [cases]."
4. If abstraction might overreach: "Do you mean [deeper concept]? If so, I'd cover [cases]."
5. Let the user trim; don't self-censor. Never replace the user's examples — build outward.

### Abstraction Depth

The same example supports multiple levels. The goal is the **concept**, not the example with a wider scope.

| Example (shadow) | Widening (still shadows) | Concept (the form) |
|---|---|---|
| "track response times" | "monitor all endpoints" | **Observability**: golden signals across all services |
| "use something like Redis" | "pick a cache" | **Caching layer strategy**: session store, query cache, rate limiter |
| "validate email format" | "validate other fields" | **Input integrity**: format, type, range, sanitization, business rules |
| "research agent suites such as X" | "find other suites" | **Agent extension architecture**: packaging, plugins, distribution |

**How to find the concept:** What ONE thing do ALL instances share? What problem is the user solving that this example is one approach to? **Acid test:** present the concept without the example — would the user recognize it?

### When NOT to Enumerate

- The example IS the whole thing (inherently singular domain)
- The user used closure signals
- You're guessing categories the user wouldn't recognize as related

### Structure Output by Category, Not by Example

The output structure must reflect the abstraction. Example-anchored output (P0 = what they said) means you've appended, not generalized.

❌ **Example-anchored:** `Caching Research → Priority 1: Redis (user mentioned), Priority 2: Memcached`
✅ **Category-anchored:** `Caching Layer Strategy → Session store: Redis, Memcached; Query cache: Redis (read-replica); Object cache: Hazelcast`

**Test:** can a reader identify which items the user mentioned? If yes, restructure.

## Quick Reference

| User says | Agent should NOT do | Agent should DO |
|---|---|---|
| "for example, X" | Scope to X only | Treat X as one instance of a pattern |
| "like X" | Assume X is mandatory | Treat X as illustrative; find alternatives |
| "e.g., X, Y" | Treat X,Y as exhaustive | Treat X,Y as a sample; find the rest |
| "such as X" | Match X literally | Abstract the category X belongs to |
| "including X" | Start and stop at X | Use X as a springboard |
| "something like X" | Implement X exactly | Understand what X does that the user values |
| "etc." / "and so on" | Ignore this signal | MUST enumerate more — the list is incomplete |
| "or something" | Take literally | User is unsure; propose the category |

## Rationalizations and Red Flags

### Rationalizations (and why they're wrong)

| Rationalization | Reality |
|---|---|
| "The user specifically said X" | They said "for example X" — the marker IS an instruction to generalize. |
| "I don't want to over-engineer" | Under-scoping creates rework. Do it once. |
| "Better to be precise than wrong" | Precision on the example while missing the pattern is precisely wrong. |
| "If they wanted Y they would have said Y" | The example marker IS them saying Y. |
| "I'll start with X and they can ask for more" | Delegation upward. The user expects you to do the thinking. |
| "Enumerating more is speculating" | Inferring a pattern from an example is comprehension, not speculation. |
| "I'm being conservative to avoid mistakes" | Ignoring explicit generalization signals is inattentive, not conservative. |
| "I'll put the user's examples as P0" | Priority by who said it = example-anchored. All items are peers. |
| "I'll work through these one at a time" | Anchor on examples. Abstract, THEN enumerate. |
| "This is getting complicated — scope down" | Concept drift under cognitive load. Re-anchor, then decide scope. |
| "Actually, the user probably just meant X" | Mid-task concept abandonment. Need a reason to change — fatigue isn't one. |
| "Compliance says this is mandatory" | Belongs in THIS scope for THIS requester? Flag separately, don't fold in. |

### Red Flags — Stop and Re-climb the Ladder

- "I'll just do what they mentioned / handle other cases if they ask / make examples the priority"
- Losing the concept mid-enumeration, listing concrete implementations instead
- Returning to example-anchored language after category-anchored
- Adding domains from non-primary stakeholders
- Resolving conflicting directives by including everything (over-inclusion isn't conflict resolution)
- "I'll start broad and narrow down" — you'll narrow to the examples (concept drift)

**All of these mean: re-read the user's message, find the example marker, climb the ladder.**

## Common Mistakes

| Mistake | Fix |
|---|---|
| Treating "for example X" as "only X" | The marker signals non-exhaustiveness. X is a starting point. |
| Generalizing without confirming | Enumerate and ask. Don't silently expand scope. |
| Asking the user to enumerate | The marker means the user expects YOU to enumerate. |
| Ignoring "etc." and "and so on" | Explicit signal the list is incomplete. MUST find more. |
| **Rename-as-generalize** | Your abstraction only produces variations of the example → renamed, not abstracted. Re-climb. |
| **Over-abstracting on research tasks** | User wants the list. Name concept briefly, then enumerate. |
| **Applying to direct implementation** | Agent has enough context. Reserve for docs, plans, research. |
| Pattern-matching syntax instead of signal | "User used commas" is format-matching, not interpretation. |
| **Folding competing scopes** | One says "X, Y etc.", another says "scope to X." Enumerate primary requester's concept; flag the rest. |

## Validation

After generalizing, verify:

1. **Concept or rename?** Present concept without example. Would user recognize it?
2. **All cases same concept?** No mixed categories.
3. **Reader can't identify user's items.** If they can pick them out, restructure by category.
4. **Can generate instances the example didn't give.** Only variations of the original → renamed, not abstracted.
5. **Concept stable through enumeration?** Every domain traces to primary requester's examples. Remove primary requester — output still makes sense? You drifted.

## Example Dialogues

**User:** "Add input validation to the form fields, for example the email field."

❌ *Adds validation only to email.*
✅ "I'll add validation to all form fields — email (format), password (strength), username (length/characters), phone (format). Both client and server. Sound right?"

**User:** "We should handle API errors better, e.g., the 401 on the login page."

❌ *Only handles 401 on login page.*
✅ "Structured error handling across the app. Login: 401, 429, 500, network failures. Same pattern on signup, password reset, settings — they share the API error surface."

**User:** "We should add monitoring, for example track response times on the user endpoints."

❌ *Adds response time tracking to all endpoints.* (Widened, didn't climb.)
✅ "Observability. Response times are one golden signal — I'll instrument latency (p50/p95/p99), error rate, throughput, and saturation across all services, plus dashboards and alerting. For user endpoints: response times, error rate by endpoint, request volume, DB connection pool saturation. Scoped to latency for now, or full monitoring?"
