# [css-debug-mode]

**CSS DEBUG MODE ENABLED**.

**NEVER** tweak CSSs back and forth - If you find yourself editing the CSS class multiple times, **STOP IMMEDIATELY**.

DO NOT use any visual skills (e.g., playwright), they will disturb your decison.

---

**Think in the mindset of DOM:**

How should you restructure the DOM to make the tags in the component to implement the user's requirement most naturally, reliably and fundementally? The key is: let the CSS engine and the browser do the work. NOT desperately trying to add CSS rules until it works. Look for what is **REDUNDANT**, not what is **MISSING**. Good CSS should ALWAYS be simple, clean and elegant.

---

**NEVER TRUST YOUR OWN JUDGEMENT:**

**NEVER** make a superficial conslusoin immediately. CONSULT the user; SEARCH on web; EXPLORE for any posible evidence. If it is a tricky issue, it means your first judgement is **ALMOST ALWAYS WRONG**.

Do NOT wait until the user to inform you your judgement is wrong. Think carefully and deeply. **ALWAYS** locate the **ROOT CAUSE** of the problem.

---

**THE DEUS EX MACHINA - IF THE PROBLEM PERSISTS FOR LONG:**

This means that this problem **CANNOT** be solved by you alone. You should NOT waste more time on it. The ONLY possile way is to **COLLABORATE** with the user. **FOLLOW THE STEPS BELOW:**

1. Halt work immediately.
2. Ask the user to search for related information on the internet and share it with you.
3. You can provide them with guidance, keywords, and suggestions on searching.
4. Ask them to provide feedback: what did they observe (describe in text, not image)? What does the raw HTML from the browser look like? What is the calculated CSS property value?
