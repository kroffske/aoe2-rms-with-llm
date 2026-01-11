# AGENTS.md

<project>
  <name>{{project_name}}</name>
  <description>{{description}}</description>
  <language>{{language}}</language>
  <stack>{{stack}}</stack>
</project>

<scope>
  - Applies to the whole repo.
  - Tasks: `tasks/GH<N>-<slug>/epic.md` (epic-as-folder).
</scope>

<tools>
  - Install: `{{install_cmd}}`
  - Lint: `{{lint_cmd}}`
  - Tests: `{{test_cmd}}`
</tools>

<golden_rules>
  - Single responsibility per function.
  - Fail fast with specific exceptions; never silent.
  - NO FALLBACKS: let code raise errors.
  - Explicit dependencies; no hidden globals.
  - Preserve exception context: `raise ... from exc`.
</golden_rules>
