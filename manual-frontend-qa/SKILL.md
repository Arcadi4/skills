---
name: manual-frontend-qa
description: Use when the partner asks for manual frontend QA, hand-testing, or step-by-step UI verification — especially when Playwright/Cypress/Selenium is unavailable, not worth setup, or the partner said "just check it manually." Requires direct communication with the human partner.
license: CC-BY-NC-4.0
---

# Manual Frontend QA

## Overview

Guide the human partner through manual verification with step-by-step instructions they execute in a browser. You provide the checklist, expected outcomes, and answerable questions — the partner does the clicking.

**Core principle:** You are a QA instructor, not a tester. Violating the letter is violating the spirit.

## When to Use

- Partner explicitly asks for manual QA, hand-testing, or "can you verify this works?"
- Automated testing isn't worth the setup effort (one-off check, prototype, quick fix)
- The environment lacks Playwright, Cypress, or Selenium
- Partner says "just check it manually" or "don't write tests for this"

## When NOT to Use

- Pure backend/data/logic change with no visible UI — use systematic-debugging instead
- Automated tests already cover the change — run those
- Partner explicitly asked for automated tests — use the appropriate testing tool
- You cannot describe expected behavior concretely — clarify requirements first

## Process

**Never use Playwright, Cypress, Selenium, or Chrome DevTools scripting during manual QA.**

### 1. Start with what you know

Provide instructions for everything you can infer. Do not wait for perfect information.

> **Good:** "Here are the QA steps. I assumed the form is at /login — if different, let me know."
> **Bad:** "Where is the login form?" (stops and waits — partner hasn't seen any instructions yet)

### 2. Scope missing pieces alongside instructions

If you need a fact (URL, component name, expected behavior), ask one targeted question — but alongside the instructions, not before them. Information-gathering about facts is fine:
- "What URL should I give you steps for?"
- "Is this React, Vue, or plain HTML?"
- "Should the error clear on blur or only on correction?"

### 3. Provide step-by-step instructions

Each step must be executable (partner knows exactly what to click), measurable (concrete expected outcome), and ordered (builds on previous steps). Include edge cases the partner won't think of: long input, special characters, rapid clicks, browser back button, Enter key behavior.

### 4. Ask answerable verification questions

Prefer questions with clear answers. The partner shouldn't need paragraphs to describe what they see.

> **Good:** "After submitting with an empty email field, do you see an error next to the email input? (yes/no)"
> **Good:** "Which describes the button after submit? A) Disabled B) Disappeared C) Still enabled D) Other (describe briefly)"
> **Bad:** "What happens when you submit the form?" (vague — partner doesn't know what to look for)

### 5. Analyze feedback, decide next step

- All checks pass → Summarize what was verified. QA complete.
- Some checks fail → Debug that failure first (DOM inspection, console check). Do not start a new QA cycle.
- Behavior unclear → Ask for specific evidence (screenshot, error text, console output).

## Gathering Evidence on Failures

| Method | Instructions to partner |
| ------ | ----------------------- |
| Temporary logging | Add `console.log()`, ask for output. **Never commit.** Remove after QA. |
| DOM inspection | Right-click → Inspect on the element, share HTML structure or attributes. |
| CSS inspection | Inspect computed properties (`display`, `position`, `white-space`), share values. |
| Screenshot | Share a screenshot of the problematic area. |

## Rationalization Prevention

| Excuse | Reality |
| ------ | ------- |
| "Just quickly check with DevTools" | Any automated checking is prohibited. Partner executes, you instruct. |
| "It's faster to use Playwright" | If the partner wanted automation, they would have asked for it. |
| "I can combine manual and automated" | No automated tools whatsoever during manual QA mode. |
| "It's just one small test" | Even one automated check violates. Consistency matters more than convenience. |
| "I'll ask one more question before giving instructions" | Stalling is the most common failure. Give instructions first, clarify in parallel. |
| "The partner didn't specify edge cases, so I'll skip them" | The partner relies on you to think of what they didn't. |
| "Let me verify expected behavior with the partner first" | If the description is clear enough, start. Clarify alongside, not before. |
| "This is too simple to need a full checklist" | A 30-second checklist beats a 30-minute bug hunt. |
| "I already know what the partner will say" | You are not the partner. Do not answer your own verification questions. |

## Red Flags — STOP

**Automation:** thinking about Playwright/Cypress/Selenium, writing test code, asking partner to install testing libraries, considering "just this once" exceptions.

**Paralysis:** asking a third clarification question before any QA steps, thinking "I need to understand the whole system first," searching the codebase when manual QA was requested, rewriting the same step trying to make it perfect.

**Incomplete:** steps that assume the partner knows what to look for, no edge cases, no expected outcomes stated, vague verification questions ("what happens?"), no clear "QA complete" signal.

**All of these mean: give the partner executable instructions now.**

## Quick Reference

| Situation | What to do |
| --------- | ---------- |
| Partner asks for manual QA | Provide step-by-step instructions immediately. Clarify missing facts alongside. |
| You don't know the URL | Assume a reasonable URL, add: "If different, let me know." |
| Expected behavior is unclear | State your assumption, then give instructions. |
| A check fails | Switch to debugging: DOM inspection, console output, or screenshot. |
| All checks pass | Summarize what was verified. Offer to capture as a test case if relevant. |
| Partner asks you to run the checks | "Manual QA means you execute, I instruct. I cannot click for you." |

## Common Mistakes

| Mistake | Fix |
| ------- | --- |
| Stalling — "Where is the form?" before any instructions | Give instructions first, clarify in parallel |
| Using Playwright/Cypress/Selenium/DevTools scripting | Never during manual QA. Partner executes, you instruct |
| Vague verification: "What happens?" | Ask: "Is the button disabled after clicking?" |
| Assuming the partner sees what you expect | Wait for their answer. Never answer your own questions |
| Skipping edge cases (happy path only) | Include: long input, special chars, rapid clicks, back button, Enter key |
| Forgetting to remove temporary `console.log()` | Ask partner to clean up after QA |
| Continuing QA after a check fails | Stop and debug that failure. The form is already broken |
| Yes/no after every single click | Group related checks, ask one question at the end of the group |
| Treating manual QA as a downgrade | Manual QA is legitimate verification. Be as thorough as an automated test |
