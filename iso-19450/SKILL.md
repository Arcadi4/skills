---
name: iso-19450
description: Use when explaining how an existing system works by modeling it as objects and processes — answering "what does this thing actually do?", writing down system knowledge that only lives in your head, onboarding your human partner onto a fast-growing system, or preventing cognitive debt with Object-Process Methodology (ISO 19450:2024).
---

# ISO 19450:2024 (Object-Process Methodology) for Explaining Systems

## Overview

Cognitive debt compounds when the system grows faster than shared understanding. OPM counters it with **one ontology** — everything is an **object** (exists, holds states) or a **process** (transforms objects) — and **one bimodal representation**: Object-Process Diagrams (OPDs, graphics) plus Object-Process Language (OPL, a controlled subset of English), semantically equivalent by construction. Your partner verifies the picture by reading sentences, not decoding notation.

Explain the system **as built**, from evidence — never as designed or assumed.

## Concepts

| Concept | Meaning |
|---|---|
| Object | Thing that exists; can hold states (`Healthy` / `Failing`) |
| Process | Transformation: generates, consumes, or changes an object's state |
| State | Condition or value an object can be in |
| Structural link | Existence relation: aggregation, generalization, exhibition (features) |
| Procedural link | Behavior relation: agent, instrument, consumption, result, effect, event, condition |
| OPD | One diagram page; models form a tree (SD → SD1 → SD1.3 …) |
| OPL | Auto-generated English sentences, one per model fact |
| In-zooming | New diagram deepening one process's internal time/logic |
| Unfolding | New diagram spreading out one thing's parts |

Completeness rule: **every process must transform at least one object.**

## Explaining to Your Human Partner

1. **Scope with iso-42010 first** — whose concern is this? Model only that slice.
2. **Extract objects and processes from code evidence**: stores, services, queues, files ↔ objects; deploy, sync, handle-request ↔ processes. Heuristic: nouns that persist are objects, verbs that change them are processes.
3. **Apply the transformation rule while reading code**: if you cannot say what a step generates, consumes, or changes, you have not understood it yet — keep digging instead of writing vague prose.
4. **Lead with OPL sentences**, add the OPD only if the partner wants geometry. Sentences are checkable: each one maps to a fact in the model.
5. **Grow by in-zooming and unfolding, never by fattening one document.** The top-level OPD stays one page forever; each new subsystem becomes a child diagram. Documentation size scales with system structure, not with accumulated explanation.
6. **Persist the model where the partner can revisit it**, next to the code it describes. An explanation that evaporates recreates the debt.

OPL sample (reads as English, backed by the model):

```
Build Pipeline requires Source Repository.
Building consumes Source Repository and yields Image.
Image can be Untested, Promoted, or Rolled Back.
Promoting changes Image from Untested to Promoted.
```

## Common Mistakes

| Mistake | Fix |
|---|---|
| Modeling intent or stale design docs | Derive objects/processes from code, config, runtime behavior |
| One mega-document growing with the system | Fixed one-page top OPD; in-zoom/unfold per question |
| Diagram-only explanation the partner must decode | Give OPL sentences; they carry identical semantics |
| Vague "processes" transforming nothing ("handles requests") | Name what it consumes/generates/changes, or drop it |
| Duplicate vocabulary with iso-42010 | 42010 picks the viewpoint/concern; OPM is the model kind filling that view |
