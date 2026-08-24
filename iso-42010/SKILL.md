---
name: iso-42010
description: Use when explaining an existing system's architecture to your human partner — answering "how does this work?", onboarding them to an unfamiliar area, giving context before a decision, writing down what only lives in your head, or preventing cognitive debt by scoping explanations with ISO/IEC/IEEE 42010.
---

# ISO/IEC/IEEE 42010 for Explaining Systems

## Overview

**Cognitive debt** is what your partner pays every time understanding exists only in conversation or in your head: they re-ask, re-derive, or silently guess. 42010:2022 prevents it by structuring each explanation around who is asking and why (**stakeholder → concern → viewpoint → view → correspondences**).

Explain the system **as built**, from evidence — never as designed or as you assume.

## Concepts

| Concept | Meaning |
|---|---|
| Concern | What the partner needs to learn or decide right now; broader than a requirement |
| Viewpoint | Conventions for constructing a view that frames specific concerns |
| View | The explanation produced using those conventions |
| Model kind | Specification for a category of models (sequence diagram, dependency graph...) |
| View component | Separable part of a view; model or non-model content (2022 addition) |
| Correspondence | Named link between elements across views (component ↔ deployed node) |

Key distinction: **viewpoint = rules; view = result.**

## Explaining to Your Human Partner

1. **Partner is the stakeholder.** Establish their concern first — fixing a bug, reviewing a change, deciding where new work goes. If unclear, ask one targeted question.
2. **Pick the viewpoint that frames that concern**, and nothing else. Operators need failure paths; maintainers need coupling; security reviewers need trust boundaries. Do not document everything.
3. **Derive the view from evidence**: read the code, configs, manifests, runtime behavior. Mark anything inferred rather than observed as inferred.
4. **Size the view to the concern.** A focused answer beats a tour. One view rarely serves two different questions.
5. **Use correspondences** to connect what they already know to the new area ("this service ↔ the deploy pipeline you know"). Where links don't line up, say so — that's drift worth knowing.
6. **Write it down where they can revisit it** — doc, comment, ADR — not just chat. An explanation that evaporates recreates the debt.

## Common Mistakes

| Mistake | Fix |
|---|---|
| Answering the question asked, then firehosing everything else | Stop at the framed concern; offer follow-ups |
| Explaining only in chat, lost by tomorrow | Persist the view somewhere revisitable |
| Describing intent or stale docs instead of the system | Ground claims in code/config evidence; flag inference |
| One mega-diagram for every audience | Split views per concern under separate viewpoints |
