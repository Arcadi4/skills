---
name: learn-from-session
description: Use when extracting reusable patterns from session history to create skills, analyzing completed work to identify generalizable workflows, or when writing skill trigger descriptions that need to be concept-anchored rather than example-based.
license: CC-BY-SA-4.0
---

# Learning From Sessions

## Overview

Sessions contain concrete problem-solving patterns. When a workflow proves valuable, extract it into a reusable skill. This skill guides pattern identification from session history and skill document production.

## When to Use

**Triggers:**

- User says "learn from this session", "make a skill from this", "extract a pattern"
- You've solved a complex problem and the approach seems reusable
- Writing skill trigger descriptions or documentation rules
- Multiple sessions show the same problem-solving pattern

**Do NOT use when:**

- Creating skills from scratch without session examples
- One-off, context-specific work with no clear pattern
- User wants to generalize requirements for implementation (use `generalize` skill)

## Skill Trigger Writing

When writing skill descriptions, trigger lists, and documentation rules: **name the underlying condition first; keep examples as symptoms**. If trigger text lets a reader identify the user's examples as the use case, re-climb the abstraction ladder.

### Why This Matters

When examples remain recognizable, they anchor the output to the source case. Readers pattern-match the example instead of understanding the concept.

**Example:**

❌ **Example-anchored:** "Use when handling 401 errors on login"
✅ **Concept-anchored:** "Use when handling authentication failures across user-facing flows"

The second version covers login, signup, password reset, session refresh — all instances of the same concept. The first version only triggers when someone sees "401" and "login" together.

### Validation for Skill Triggers

After writing a trigger description, verify:

1. **Concept or rename?** Present trigger without examples. Would user recognize when to use it?
2. **Reader can't identify source examples.** If they can pick out the original case, restructure by concept.
3. **Concept stable through enumeration.** Every domain traces to the underlying capability, not the specific instance.

## Session Pattern Extraction

**Look for these patterns in session history:**

| Pattern Type | Session Signals | Skill Opportunity |
|---|---|---|
| **Repeated workflow** | Same tool sequence across multiple tasks | Codify the sequence |
| **Decision tree** | "If X then Y, else Z" logic you followed | Capture the branching |
| **Failure recovery** | You tried A, failed, then B worked | Document the diagnostic path |
| **Tool combination** | Specific tools used together effectively | Create combo workflow |
| **Validation sequence** | Checks you ran before claiming completion | Standardize verification |

### Extraction Process

**Step 1: Identify the trigger**

What user request or situation initiated the valuable work?

- Extract the **intent**, not the specific words
- Identify the **problem class**, not the instance
- Note **context clues** that signal this pattern applies

**Step 2: Trace the workflow**

What did you actually do? Chronological steps:

- Tool calls made
- Decisions at each branch point
- What you checked before proceeding
- How you validated results

**Step 3: Abstract the concept**

What capability does this workflow provide?

- Name it by the outcome, not the steps
- One sentence: "This skill helps you [achieve X] by [approach Y]"
- Test: Would someone searching for this capability find it by this name?

**Step 4: Generalize the context**

When else would this workflow apply?

- What varies between instances? (parameters)
- What stays constant? (structure)
- What are the boundaries? (when NOT to use this)

**Step 5: Structure the skill**

Convert to skill document format:

```markdown
---
name: [capability-name]
description: Use when [trigger patterns]. [One-line value prop].
---

# [Skill Name]

## Overview
[What this skill does, why it exists]

## When to Use
**Triggers:**
- [Specific request patterns - concept-anchored]
- [Context signals]

**Do NOT use when:**
- [Boundary conditions]

## Workflow
[Step-by-step process extracted from session]

## Validation
[How to verify the workflow succeeded]

## Examples
[Concrete cases from the session that inspired this]
```

**Step 6: Validate**

Test questions:

1. **Would this skill have helped at session start?** If you'd loaded this skill before the work, would it have guided you correctly?
2. **Is the trigger clear?** Can you identify when to load this skill without ambiguity?
3. **Is the workflow complete?** Does it cover the full path from trigger to completion?
4. **Are boundaries explicit?** Is it clear when NOT to use this?
5. **Can someone else follow it?** Is it concrete enough to execute without guessing?
6. **Trigger text concept-anchored?** Names the condition, not the examples.

## Common Pitfalls

**Rename-as-extract:** Your "skill" is just the session transcript reformatted. Test: Remove all session-specific details. Does a general workflow remain?

**Over-specific:** Skill only applies to the exact case you just solved. Test: Can you name 3 other situations where this skill would apply?

**Under-specific:** Skill is too vague to execute. Test: Could someone follow this without asking clarifying questions?

**Missing boundaries:** Skill doesn't say when NOT to use it. Test: Can you identify cases where this skill would mislead?

**Example-anchored triggers:** Trigger description lets readers identify the source case. Test: Remove examples from trigger. Does it still clearly indicate when to use?
