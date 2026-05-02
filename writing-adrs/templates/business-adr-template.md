# ADR-XXXX: Short decision title

<!--
  BUSINESS / ENTERPRISE TEMPLATE — full governance.
  Formal review, multiple approvers, regulatory implications possible.
  Completeness matters more than brevity here.
-->

## Status

Proposed | Accepted | Rejected | Superseded by ADR-XXXX

## Date

YYYY-MM-DD

## Decision Maker

[Name / Title] — who owns the final call.

## Approvers

Whose sign-off is required? (Architecture review board, engineering lead, CTO, compliance officer.)

- [Name / Title]
- [Name / Title]

## Stakeholders

Who is affected by this decision? (Teams, business units, external parties.)

- [Team / Name]
- [Team / Name]

## Confidence

High | Medium | Low — required. If Low, explain what information would increase confidence.

## Cost Impact

Low | Medium | High — quantify if possible (engineering weeks, infrastructure spend, license costs).

## Compliance Notes

Does this decision affect regulatory posture, data handling, audit trails, or certification status? If yes, describe the impact. If no, state "None" to signal it was considered.

## Context

The situation, constraints, and forces that made this decision necessary. Include any prior decisions, architectural principles, or business requirements that shaped the landscape. Link to design docs, RFCs, or board minutes rather than duplicating them.

## Decision

The chosen option, stated clearly. What was the decisive factor? If this was a close call, acknowledge that. Ambiguity is honest — glossing over it erodes trust in the record.

## Alternatives Considered

Do not list strawmen. For each real alternative:

- **Option A:** Why it was a serious contender → why it lost. Quantify the tradeoff if possible (cost, risk, timeline).
- **Option B:** Why it was a serious contender → why it lost.

If the decision involved a formal evaluation framework (decision matrix, cost-benefit analysis), reference it.

## Consequences

- **Benefits gained** — what improves?
- **Costs accepted** — complexity, maintenance burden, learning curve, vendor lock-in.
- **Risks introduced** — what could go wrong? Include likelihood and severity if estimable.
- **Constraints created** — future choices this decision forecloses. What paths are now harder or impossible?
- **Migration / rollout considerations** — if this requires phased adoption, note it here (but keep implementation details in the plan).

## Revisit Triggers

Concrete, measurable conditions that should cause review or supersession:

- "When monthly active users exceed N"
- "When latency crosses Y ms at p99"
- "When the underlying platform announces end-of-life"
- "When a competing option reaches maturity milestone Z"

No "review later" without a trigger.

## Related

- Design documents, RFCs, board decisions, compliance filings
- Superseded or superseding ADRs
- Implementation PRs or rollout plans
