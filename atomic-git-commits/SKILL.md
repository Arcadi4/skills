---
name: atomic-git-commits
description: Use whenever you are about to make a git commit.
license: CC-BY-NC-4.0
---

# Make Atomic Git Commits

## Guidelines

### Atomic Commits

These rules ensures the atomicity of each commit:

1. Each commit should represent a single logical change and a single intention.
2. An atomic commit is never a bulk commit.
3. You should never make a fake bulk commit by grouping multiple changes together and write a vague commit message.
4. Revertible. Each commit should be able to be reverted without affecting other commits at any point in the future.
5. If you are working on a plan, one task does not always correspond to one commit. Think about the atomic principle. Ignore this rule if the plan specifies a commit strategy.
6. If you are dispatching sub-agents to work, you must commit on behalf of them if they didn't do so. This is always the first thing to check after retrieving the results.

### Other Mandatory Rules

All rules in this list are non-negotiable. Each commit you make must follow these rules:

1. 72 characters maximum character for the subject line (first line). If you want to add more information, you may do that in the body of the commit message.

### Adaptive Rules

These rules are adaptive to the repository you are working on. Look for existing patterns before you make commits. If no patterns are established, you may go free-form.

1. Whether to capitalize the subject line or not.
2. Whether to use a period at the end of the subject line or not.
3. Whether to add a scope of change or not. Be consistent if so. A scope is usually a module name, directory name, or an universal concept specific to the project. Do not come up with your own scope if the project already has established patterns.
4. What commit types are allowed and preferred (e.g., feat, fix, docs, style, refactor, test, chore).
5. Whether to avoid merge commits or not.

## Appendix: Commit Types

If your repository did not specify otherwise, you may take the following commit type definitions as a reference:

- feat: A new feature for the user.
- fix: A bug fix for the user.
- docs: Changes to the documentation/comments.
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc). Lint can count as well.
- refactor: Slightly beyond linting. Refactoring code that neither fixes a bug nor adds a feature, but changes the internal structure of the code.
- perf: A code change that improves performance. It's fine to mix up refactor and perf. This depends on the aspect of the change you want to emphasize.
- test: Changes related to testing. A fix on tests should be categorized as test, not fix.
- chore: Changes to the build process, auxiliary tools, dependencies, or any other change external to the source code.
- ci: Changes to any CI configuration files and scripts. You may use chore to cover this as well, but ci is more specific.
- wip: Work in progress. Use with caution. This is usually used for temporary commits that will be squashed later.
