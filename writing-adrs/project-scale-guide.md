# Project Scale Guide for ADRs

Detailed adaptation guidance for each project scale. See the Adaptive Metadata table in SKILL.md for the quick-reference decision framework.

## Solo Projects

One person is the decision-maker. Agents are analysis contributors, not authority.

**The rule:** Ask before writing. Never auto-apply an ADR. The human decides what gets recorded.

An ADR is successful if it preserves future understanding, not if it satisfies a template. Review is optional. Consensus does not apply.

> **Good:** "We just decided to use SQLite over Postgres. You're working solo — do you want me to capture that as an ADR? I can keep it minimal (2–3 lines of rationale) or include alternatives and tradeoffs. Your call."
>
> **Bad:** "Here's ADR-0001 with full metadata, alternatives analysis, and revisit triggers." (Agent auto-applied without asking.)

### Why agents fail at solo projects

Agents default to auto-applying templates. For solo projects, this is wrong. The human partner is the only stakeholder — their preferences override any template. Common failure: producing an ADR with Approvers, Stakeholders, and Cost Impact sections for a personal project with no approval chain.

> **Bad:** "I've written ADR-0001 with full metadata including Approvers, Stakeholders, Cost Impact, and Compliance Notes." (Solo project — no approval chain exists.)

## Hobby Groups

One or a few people making casual decisions together.

- Lightweight metadata only: Status, Date, Involved.
- Skip governance fields entirely.
- Review is informal and asynchronous.
- An ADR here is more like a shared note than a formal record.

## Small Teams

Startup, small company, or focused product team context.

- Consensus is helpful but not required for every ADR.
- Advisors can be other humans, prior docs, or coding agents used during design.
- Review can be asynchronous and lightweight.
- Include Confidence level if the decision has notable uncertainty.
- An ADR is successful if it preserves future understanding, not if it satisfies a governance ritual.

## Business / Enterprise

Regulated industry, multi-team organization, or formal governance context.

- Full governance: approvers, stakeholders, cost impact, compliance.
- Formal review process may apply.
- ADRs may be part of an architecture review board workflow.
- Supersession should reference the approving body or process.
- Compliance notes are expected when the decision affects regulatory posture.

## Cross-Cutting Rule

Treat coding agents as contributors to analysis, not as the authority behind the decision. The ADR should still make clear what the human decided and why. This applies at every scale.
