---
name: writing-adrs
description: Use when a design discussion has produced a real architecture decision, when future readers would ask "why did we do it this way?", when capturing tradeoffs and rejected alternatives matters, or when the user asks to document a design choice. Not for implementation notes, brainstorming dumps, or unsettled decisions.
license: CC-BY-NC-4.0
---

# Writing ADRs

## Overview

Write Architecture Decision Records as lightweight decision snapshots, not mini design docs.

**Core principle:** Record one meaningful decision, why it was chosen, what tradeoffs came with it, and what should trigger reconsideration later.

This skill adapts to project scale — solo maintainers, hobby groups, small teams, and business-level projects — instead of assuming a committee.

## When to Use

Use this skill when:

- A design or planning discussion has produced a real decision
- The user asks to capture, document, or formalize a design choice
- A decision will likely be questioned later
- A choice affects structure, quality attributes, tooling, interfaces, deployment shape, or a hard-to-reverse workflow
- You need a durable record of why one option beat another

Use it **after** design discussion, not before. If the decision is still unsettled, keep designing.

Do **not** use this skill for:

- Implementation notes or rollout checklists
- Obvious local edits with no lasting tradeoff
- Broad solution designs containing multiple independent decisions
- Meeting transcripts or brainstorming dumps

## Adaptive Metadata by Project Scale

The ADR header is not one-size-fits-all. Choose metadata based on project context.

**Determine the scale BEFORE writing the ADR.** If uncertain, ask the human partner.

| Scale | Typical context | Metadata to include | Key rule |
|---|---|---|---|
| **Solo** | One developer, personal projects, no stakeholders | Status, Date | **Ask the human first.** Do not auto-apply a template. Ask: "Do you want an ADR for this? What level of detail?" Let them decide. |
| **Hobby group** | Friends, open-source side projects, loose collaboration | Status, Date, Involved | Keep it lightweight. No governance ceremony. |
| **Small team** | Startup, small company, focused product team | Status, Date, Decision maker, Advisors | Include Confidence if the decision has notable uncertainty. |
| **Business** | Enterprise, regulated industry, multi-team org | Status, Date, Decision maker, Approvers, Stakeholders, Confidence, Cost impact | Full governance. Add Compliance notes when applicable. |

**If you don't know the scale, ask.** Guessing produces either overengineered ceremony or missing accountability.

### Solo projects: the failure mode

Agents default to auto-applying templates. For solo projects, this is wrong. The human partner is the only stakeholder — their preferences override any template.

> **Good:** "We just decided to use SQLite over Postgres. You're working solo — do you want me to capture that as an ADR? I can keep it minimal (2–3 lines of rationale) or include alternatives and tradeoffs. Your call."
>
> **Bad:** "Here's ADR-0001 with full metadata, alternatives analysis, and revisit triggers." (Agent auto-applied without asking.)

## Scope Sizing

Right-size the ADR to the scope of the decision.

| Scope | Use when | Expected size |
|---|---|---|
| Microscopic / local | A focused decision inside one component, module, or workflow | 3–6 short bullets or paragraphs, ~0.25 page |
| Mid-level / cross-cutting | A decision affects several modules, one service, or a repeated team workflow | ~1 page |
| Holistic / global / major | Changes system shape, platform direction, interfaces, or an expensive-to-reverse constraint | 1–2 pages with sharper tradeoff detail |

**Scale by blast radius, reversibility, and downstream impact — not by importance theater.**

Even major ADRs stay concise. Link to design docs; keep the ADR focused on the decision.

## Core Pattern

Each ADR should answer these questions, in this order:

1. What decision are we making?
2. What context or forces made this decision necessary?
3. Which serious alternatives were considered?
4. Why did this option win?
5. What consequences or tradeoffs follow from it?
6. What would cause us to revisit or supersede it?

If the ADR cannot answer these questions, even briefly, the thinking is not done yet.

## ADR Anatomy

Keep one ADR per file and one decision per ADR. Use the metadata appropriate to your project scale.

```markdown
# ADR-XXXX: Short decision title

## Status

Proposed | Accepted | Rejected | Superseded by ADR-XXXX

## Date

YYYY-MM-DD

[Additional metadata per Adaptive Metadata table — see above]

## Context

The situation, forces, constraints, and problem that made this decision necessary.

## Decision

The chosen option, stated plainly.

## Alternatives Considered

- Option A: why it was plausible, why it lost
- Option B: why it was plausible, why it lost

## Consequences

- Benefits gained
- Costs accepted
- Risks introduced
- Constraints created

## Revisit Triggers

- Conditions that should cause review or supersession

## Related

- Links to design docs, issues, PRs, or superseding ADRs
```

Do not add sections just to look complete. Include only fields that clarify the decision.

## Writing Rules

- Put the decision near the top
- Write in plain, assertive language
- Capture rationale, not just outcome
- Name real alternatives, not strawmen
- State tradeoffs honestly
- Include concrete revisit triggers, not "review later"
- Keep accepted ADRs append-only; supersede with a new ADR instead of rewriting history
- Store ADRs near the code or docs they govern

## Project Scale Adaptation

### Solo projects

One person is the decision-maker. Agents are analysis contributors, not authority.

- **Ask before writing.** Never auto-apply an ADR. The human decides what gets recorded.
- An ADR is successful if it preserves future understanding, not if it satisfies a template.
- Review is optional. Consensus does not apply.

### Hobby groups

- One or a few people making casual decisions.
- Lightweight metadata only. Skip governance fields.
- Review is informal and asynchronous.

### Small teams

- Consensus is helpful but not required for every ADR.
- Advisors can be other humans, prior docs, or coding agents used during design.
- Review can be asynchronous and lightweight.

### Business / enterprise

- Full governance: approvers, stakeholders, cost impact, compliance.
- Formal review process may apply.
- ADRs may be part of an architecture review board workflow.
- Supersession should reference the approving body or process.

Treat coding agents as contributors to analysis, not as the authority behind the decision. The ADR should still make clear what the human decided and why.

## Quick Reference

| Situation | Action |
|---|---|
| Decision will shape later implementation | Write an ADR |
| Reversing it would be annoying, risky, or expensive | Write an ADR |
| Multiple plausible options existed | Write an ADR |
| Tradeoff discussion matters more than the final label | Write an ADR |
| Just a task breakdown | Do not write an ADR |
| One tiny code tweak with no lasting design meaning | Do not write an ADR |
| Choice is still being explored | Do not write an ADR — keep designing |
| Document would just repeat the design doc | Do not write an ADR — link to the doc |
| Working solo — unsure if this matters | Ask the human partner |

## Common Mistakes

| Mistake | Fix |
|---|---|
| Writing a design document instead of a decision record | ADRs capture the decision and rationale, not the full solution |
| Recording several decisions in one ADR | One decision per ADR. Split them. |
| Listing only the winner, hiding the alternatives | Name real alternatives and why they lost |
| Saying "we can revisit later" without triggers | Name concrete conditions: "when traffic exceeds X", "if latency crosses Y" |
| Solo or duo project with committee-level ceremony | Use solo-scale metadata. Ask the human what they want. |
| Mixing implementation rollout steps into the ADR | Action items belong in plans or tasks |
| Rewriting old ADRs instead of superseding them | Write a new ADR that supersedes the old one |
| Making microscopic decisions sound global | Right-size to actual blast radius |
| Auto-applying ADR template to solo project without asking | Ask first. Template is a tool, not a mandate. |

## Rationalization Prevention

| Excuse | Reality |
|---|---|
| "This is too small to document" | If the tradeoff will matter later, a short ADR is enough |
| "We already have a design doc" | Design docs explain the solution; ADRs preserve the decision and rationale |
| "I will remember why we chose this" | Future-you usually remembers the winner, not the losing options or constraints |
| "I will just update the old ADR later" | Accepted ADRs should be superseded, not rewritten |
| "There were no real alternatives" | If nothing else was plausible, you probably do not need an ADR |
| "I should add rollout steps so it is actionable" | Action items belong in plans or tasks, not in the ADR itself |
| "I'm working alone — ADRs are overkill" | A 3-line ADR preserves rationale. It is future-proofing, not ceremony. |
| "The template requires all metadata fields" | The template adapts to project scale. See Adaptive Metadata section. |

## Red Flags — Stop and Fix

**Metadata misuse:**
- Auto-applying full governance metadata to a solo project without asking
- Using solo-level metadata for a regulated business decision
- Guessing the project scale instead of asking

**Content problems:**
- More than one real decision in the same ADR
- No rejected alternatives listed
- No tradeoffs or downsides acknowledged
- No concrete revisit trigger
- Status is unclear or missing

**Scope problems:**
- The document reads like a migration plan or implementation checklist
- Scope inflated far beyond the actual blast radius

**If any of these are true, tighten the ADR before considering it done.**

## Workflow

1. **Confirm the decision is settled.** If still exploring, keep designing.
2. **Determine project scale.** Solo? Hobby group? Small team? Business? If unsure, ask.
3. **For solo: ask the human partner** whether to capture the decision and at what level of detail.
4. **Right-size the record** to local, cross-cutting, or global scope.
5. **Write one concise ADR** for one decision, using the metadata appropriate to the scale.
6. **Link supporting design material** instead of copying it.
7. **If the decision changes later**, write a new ADR that supersedes the old one.

> **Good:** "You're a solo developer and we just chose SQLite over Postgres for local dev. Want me to write a quick ADR? I'd keep it minimal: decision, 2-line rationale, and a revisit trigger for when user count grows past 100."
>
> **Bad:** "I've written ADR-0001 with full metadata including Approvers, Stakeholders, Cost Impact, and Compliance Notes." (Solo project — no approval chain exists.)

## Default Agent Behavior After Design Decisions

When you and your human partner reach a meaningful decision, offer to capture it as an ADR. Adapt the offer to the project scale.

Use a short prompt such as:

> "We just made a meaningful design decision. Want me to capture it as an ADR so the rationale and tradeoffs do not get lost?"

For solo projects, add scale-awareness:

> "We just made a design decision. Since you're working solo, would you like me to capture it as an ADR? I can keep it minimal or include full rationale — your call."

Offer an ADR when the decision is:
- Important enough to revisit later
- Likely to affect future implementation choices
- Hard to reverse
- The result of real tradeoff discussion

Do not interrupt every tiny choice with ADR ceremony. Offer it when the future reader would reasonably ask, "Why did we do it this way?"
