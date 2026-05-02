# ADR-XXXX: Short decision title

<!--
  SOLO PROJECT TEMPLATE — minimal, no ceremony.
  Future-you is the only audience. Every section is optional.
  If something doesn't add clarity, delete the section.
-->

## Status

Proposed | Accepted | Rejected | Superseded by ADR-XXXX

## Date

YYYY-MM-DD

## Context

What situation made you stop and think? What forces or constraints were at play? One paragraph is plenty. If the decision is obvious from context, you can merge this into Decision.

## Decision

What did you choose? Include the one-sentence rationale inline — future-you doesn't need a separate section to understand why.

> "I chose SQLite over Postgres because this is a single-user local tool and the operational overhead of Postgres would slow me down more than SQLite's limits will constrain me."

## Alternatives Considered

Skip this section if the decision was obvious. If there were real alternatives, list them briefly:

- **Option A:** Why it was tempting, why you rejected it.
- **Option B:** Why it was tempting, why you rejected it.

## Consequences

A short paragraph on what this means going forward — what you gained, what you gave up, what might go wrong. No sub-bullets needed unless it helps you.

## Revisit Triggers

When would you reconsider? Keep it concrete and personal:

> "If the user count grows past 50" / "If I need multi-writer concurrency" / "If I onboard a co-maintainer"
