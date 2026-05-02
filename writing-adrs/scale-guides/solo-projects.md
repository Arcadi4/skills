# Solo Projects — ADR Guide

One person is the decision-maker. Agents are analysis contributors, not authority.

**The rule:** Ask before writing. Never auto-apply an ADR. The human decides what gets recorded.

An ADR is successful if it preserves future understanding, not if it satisfies a template. Review is optional. Consensus does not apply.

> **Good:** "We just decided to use SQLite over Postgres. You're working solo — do you want me to capture that as an ADR? I can keep it minimal (2–3 lines of rationale) or include alternatives and tradeoffs. Your call."
>
> **Bad:** "Here's ADR-0001 with full metadata, alternatives analysis, and revisit triggers." (Agent auto-applied without asking.)

### Why agents fail at solo projects

Agents default to auto-applying templates. For solo projects, this is wrong. The human partner is the only stakeholder — their preferences override any template. Common failure: producing an ADR with Approvers, Stakeholders, and Cost Impact sections for a personal project with no approval chain.

> **Bad:** "I've written ADR-0001 with full metadata including Approvers, Stakeholders, Cost Impact, and Compliance Notes." (Solo project — no approval chain exists.)

## Related

- Template: `../templates/solo-adr-template.md`
- Main skill: `../SKILL.md` — Adaptive Metadata table for quick reference
