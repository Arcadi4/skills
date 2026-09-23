---
name: explain-code
description: Use when a user asks what code does, why software behaves a certain way, or how a feature works from its implementation.
---

# Explain Code

Explain the behavior the reader experiences and the rule that produces it. Reading source is evidence gathering, not the structure of the answer.

## Answer shape

1. Identify the practical question behind the wording. If the user asks whether an action achieves a result, begin with **yes**, **no**, or **it depends**, followed by the relevant scope. Do not substitute a discussion of the action's internals for that answer.
2. Explain the few rules or decisions that determine the result in plain language. Mention limits or exceptions only when they can change the user's decision or outcome.
3. Give concise source links for verification. Make clear which claims are directly established by code and which are inferences or still need a runtime check.

Organize by concepts or outcomes, not by file, function, or execution order. Use an answer-first summary of the normal case before any edge cases. Stop once the user's question is answered; do not narrate the whole control flow or history of a bug unless that history is requested or needed to qualify the answer.

## Language and source

- Translate implementation names into natural language whenever possible. When an exact symbol matters for locating or distinguishing a mechanism, explain its meaning on first mention.
- Do not use a list of raw symbols as a substitute for explaining behavior.
- Do not paste code snippets into an ordinary behavior explanation.
- If the user asks to find or show code, provide only the relevant excerpt or location. Annotate the excerpt and identify the lines that decide the behavior.
- Use examples when they make a rule easier to understand, especially for boundaries or surprising outcomes.

## Self-check

Could the reader act on the first sentence? Could they understand the answer without opening the source? If the answer merely restates what each function does, or postpones the verdict until after implementation details, rewrite it around the result and its governing rules.
