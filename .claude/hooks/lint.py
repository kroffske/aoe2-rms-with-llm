#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Universal Python Standards Linter for Claude Code.

Layer: presentation (dev tooling)
IO: yes (reads repository files)
External deps: none (stdlib only)

Checks universal Python best practices:
- HAZ001: hasattr() usage (error)
- GET001: getattr() with default (error)
- EXC001: bare except (error)
- EXC002: too many broad except Exception (warning, >5 per file)
- EXC003: raise ... from None (error)
- TODO001: TODO without task reference (warning)
- LEN001: file too long (warning, 500+ lines)
- LEN002: function too long (warning, 50+ lines)

All rules are universal and work with any Python project.
"""

from __future__ import annotations

import argparse
import ast
import json
import re
import sys
from collections.abc import Iterator
from dataclasses import dataclass
from pathlib import Path
from typing import TextIO

# =============================================================================
# Models
# =============================================================================


@dataclass(frozen=True, slots=True)
class Violation:
    """Single lint violation."""

    code: str
    level: str  # "error" | "warning"
    message: str
    path: str
    line: int
    col: int

    def to_text(self) -> str:
        return f"{self.path}:{self.line}:{self.col} [{self.level.upper()}] {self.code} {self.message}"

    def to_dict(self) -> dict[str, str | int]:
        return {
            "code": self.code,
            "level": self.level,
            "message": self.message,
            "path": self.path,
            "line": self.line,
            "col": self.col,
        }


# =============================================================================
# Configuration
# =============================================================================

# Length thresholds (warnings only, don't block)
FILE_LENGTH_THRESHOLD = 500  # lines
FUNC_LENGTH_THRESHOLD = 50  # lines


# =============================================================================
# Noqa Parsing
# =============================================================================

_NOQA_PATTERN = re.compile(r"#\s*noqa(?::\s*([A-Za-z0-9_,\-\s]+))?", re.IGNORECASE)


def parse_noqa(line_text: str) -> set[str] | bool | None:
    """Parse noqa directive from line."""
    match = _NOQA_PATTERN.search(line_text)
    if not match:
        return None
    codes_str = match.group(1)
    if not codes_str:
        return True  # plain # noqa suppresses all
    return {c.strip().upper() for c in re.split(r"[\s,]+", codes_str) if c.strip()}


def is_suppressed(noqa: set[str] | bool | None, code: str) -> bool:
    """Check if code is suppressed by noqa directive."""
    if noqa is None:
        return False
    if noqa is True:
        return True
    return code.upper() in noqa


# =============================================================================
# AST Visitor
# =============================================================================


class LintVisitor(ast.NodeVisitor):
    """AST visitor that collects universal Python violations."""

    def __init__(self, path: str, source_lines: list[str]) -> None:
        self.path = path
        self.source_lines = source_lines
        self.violations: list[Violation] = []
        self._noqa_cache: dict[int, set[str] | bool | None] = {}
        self._broad_except_count = 0  # Count of except Exception/BaseException

    def _get_noqa(self, line: int) -> set[str] | bool | None:
        if line in self._noqa_cache:
            return self._noqa_cache[line]
        text = (
            self.source_lines[line - 1] if 1 <= line <= len(self.source_lines) else ""
        )
        result = parse_noqa(text)
        self._noqa_cache[line] = result
        return result

    def _add(
        self, node: ast.AST, code: str, message: str, level: str = "error"
    ) -> None:
        line = node.lineno
        col = node.col_offset + 1
        noqa = self._get_noqa(line)
        if not is_suppressed(noqa, code):
            self.violations.append(
                Violation(
                    code=code,
                    level=level,
                    message=message,
                    path=self.path,
                    line=line,
                    col=col,
                )
            )

    # -------------------------------------------------------------------------
    # Call checks: HAZ001, GET001
    # -------------------------------------------------------------------------

    def visit_Call(self, node: ast.Call) -> None:
        func_name = self._get_func_name(node.func)

        if func_name == "hasattr":
            self._add(
                node,
                "HAZ001",
                "hasattr() hides AttributeError bugs; access attribute directly or use explicit check",
            )

        elif func_name == "getattr" and len(node.args) >= 3:
            self._add(
                node,
                "GET001",
                "getattr() with default hides bugs; use explicit attribute access or validation",
            )

        self.generic_visit(node)

    def _get_func_name(self, func: ast.expr) -> str | None:
        if type(func) is ast.Name:
            return func.id
        if type(func) is ast.Attribute:
            return func.attr
        return None

    # -------------------------------------------------------------------------
    # Exception checks: EXC001, EXC003
    # -------------------------------------------------------------------------

    def visit_Try(self, node: ast.Try) -> None:
        for handler in node.handlers:
            if handler.type is None:
                self._add(
                    handler,
                    "EXC001",
                    "Bare except catches SystemExit/KeyboardInterrupt; catch specific exceptions (ValueError, TypeError, etc.)",
                )
            else:
                exc_name = self._get_exception_name(handler.type)
                if exc_name in {"Exception", "BaseException"}:
                    self._broad_except_count += 1
        self.generic_visit(node)

    def _get_exception_name(self, typ: ast.expr) -> str | None:
        if type(typ) is ast.Name:
            return typ.id
        if type(typ) is ast.Attribute:
            return typ.attr
        return None

    def check_broad_except_threshold(self) -> None:
        """Add warning if too many broad except clauses."""
        if self._broad_except_count > 5:
            self.violations.append(
                Violation(
                    code="EXC002",
                    level="warning",
                    message=f"File has {self._broad_except_count} broad 'except Exception/BaseException' clauses (>5); consider catching specific exceptions",
                    path=self.path,
                    line=1,
                    col=1,
                )
            )

    def visit_Raise(self, node: ast.Raise) -> None:
        if node.cause is not None:
            if type(node.cause) is ast.Constant and node.cause.value is None:
                self._add(
                    node,
                    "EXC003",
                    "'raise ... from None' hides original exception; use 'from exc' to preserve context",
                )
        self.generic_visit(node)

    # -------------------------------------------------------------------------
    # Length checks: LEN002
    # -------------------------------------------------------------------------

    def visit_FunctionDef(self, node: ast.FunctionDef) -> None:
        self._check_function_length(node)
        self.generic_visit(node)

    def visit_AsyncFunctionDef(self, node: ast.AsyncFunctionDef) -> None:
        self._check_function_length(node)
        self.generic_visit(node)

    def _check_function_length(
        self, node: ast.FunctionDef | ast.AsyncFunctionDef
    ) -> None:
        if node.end_lineno is None:
            return
        length = node.end_lineno - node.lineno + 1
        if length > FUNC_LENGTH_THRESHOLD:
            self._add(
                node,
                "LEN002",
                f"Function '{node.name}' is {length} lines (>{FUNC_LENGTH_THRESHOLD}); consider splitting",
                level="warning",
            )


# =============================================================================
# Text-based checks
# =============================================================================

# Match TODO in comments, not followed by TASK- or tasks/ or issue reference
_TODO_IN_COMMENT = re.compile(
    r"#.*\bTODO\b(?!.*(?:TASK-|tasks/|#\d+|issue))", re.IGNORECASE
)


def check_todos(path: str, text: str) -> list[Violation]:
    """Check for TODOs in comments without task references."""
    violations: list[Violation] = []
    for i, line in enumerate(text.splitlines(), start=1):
        match = _TODO_IN_COMMENT.search(line)
        if match:
            noqa = parse_noqa(line)
            if not is_suppressed(noqa, "TODO001"):
                comment_start = line.index("#")
                todo_pos = line.upper().index("TODO", comment_start)
                violations.append(
                    Violation(
                        code="TODO001",
                        level="warning",
                        message="TODO without linked task (add TASK-..., tasks/..., or #issue)",
                        path=path,
                        line=i,
                        col=todo_pos + 1,
                    )
                )
    return violations


def check_file_length(path: str, text: str) -> list[Violation]:
    """Check if file exceeds length threshold."""
    lines = text.splitlines()
    line_count = len(lines)
    if line_count > FILE_LENGTH_THRESHOLD:
        return [
            Violation(
                code="LEN001",
                level="warning",
                message=f"File is {line_count} lines (>{FILE_LENGTH_THRESHOLD}); consider splitting into modules",
                path=path,
                line=1,
                col=1,
            )
        ]
    return []


# =============================================================================
# File Operations
# =============================================================================

SKIP_DIRS = frozenset(
    {
        ".git",
        ".hg",
        ".svn",
        ".venv",
        "venv",
        "__pycache__",
        "node_modules",
        ".tox",
        "dist",
        "build",
        ".eggs",
    }
)


def iter_python_files(paths: list[str]) -> Iterator[Path]:
    """Iterate over Python files, skipping non-code directories."""
    for path_str in paths:
        path = Path(path_str)
        if path.is_file() and path.suffix == ".py":
            yield path
        elif path.is_dir():
            for py_file in path.rglob("*.py"):
                if not any(part in SKIP_DIRS for part in py_file.parts):
                    yield py_file


def lint_file(path: Path) -> list[Violation]:
    """Lint a single Python file."""
    try:
        text = path.read_text(encoding="utf-8")
    except (UnicodeDecodeError, OSError):
        return []

    violations: list[Violation] = []
    path_str = str(path)

    # AST-based checks
    try:
        tree = ast.parse(text, filename=path_str)
        visitor = LintVisitor(path=path_str, source_lines=text.splitlines())
        visitor.visit(tree)
        visitor.check_broad_except_threshold()
        violations.extend(visitor.violations)
    except SyntaxError as e:
        violations.append(
            Violation(
                code="PARSE",
                level="error",
                message=f"Syntax error: {e.msg}",
                path=path_str,
                line=e.lineno or 1,
                col=e.offset or 1,
            )
        )
        return violations

    # Text-based checks
    violations.extend(check_todos(path_str, text))
    violations.extend(check_file_length(path_str, text))

    return violations


# =============================================================================
# Hook Mode
# =============================================================================


def extract_path_from_hook_payload(payload: dict) -> str | None:
    """Extract file_path from Claude Code PostToolUse JSON payload."""
    for root_key in ("tool_input", "inputs", "response"):
        root = payload.get(root_key)
        if type(root) is dict:
            for path_key in ("file_path", "path", "filename"):
                fp = root.get(path_key)
                if type(fp) is str and fp.endswith(".py"):
                    return fp
    return None


def run_hook_mode(stdin: TextIO) -> int:
    """
    Hook mode: read JSON from stdin, lint single file.
    Exit codes: 0 = no errors, 2 = errors found (alerts Claude)
    """
    data_raw = stdin.read()
    try:
        payload = json.loads(data_raw) if data_raw.strip() else {}
    except json.JSONDecodeError:
        return 0

    file_path = extract_path_from_hook_payload(payload)
    if not file_path:
        return 0

    path = Path(file_path)
    if not path.exists():
        return 0

    violations = lint_file(path)
    if not violations:
        return 0

    has_errors = any(v.level == "error" for v in violations)
    output = "\n".join(v.to_text() for v in violations)

    if has_errors:
        sys.stderr.write(output + "\n")
        return 2
    else:
        print(output)
        return 0


# =============================================================================
# CLI
# =============================================================================


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        description="Universal Python Standards Linter",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Rules:
  HAZ001  hasattr() usage (error)
  GET001  getattr() with default (error)
  EXC001  bare except (error)
  EXC002  too many except Exception (warning, >5/file)
  EXC003  raise ... from None (error)
  TODO001 TODO without task reference (warning)
  LEN001  file >500 lines (warning)
  LEN002  function >50 lines (warning)

Examples:
  %(prog)s src tests
  %(prog)s --strict src
  %(prog)s --only HAZ001,EXC001 src
  %(prog)s --hook  # read from stdin (Claude Code PostToolUse)
""",
    )
    parser.add_argument(
        "paths",
        nargs="*",
        default=["."],
        help="Paths to scan (default: current directory)",
    )
    parser.add_argument(
        "--format", choices=["text", "json"], default="text", help="Output format"
    )
    parser.add_argument(
        "--strict", action="store_true", help="Treat warnings as errors (exit 1)"
    )
    parser.add_argument("--only", help="Only check these rules (comma-separated)")
    parser.add_argument("--ignore", help="Ignore these rules (comma-separated)")
    parser.add_argument(
        "--hook",
        action="store_true",
        help="Hook mode: read PostToolUse JSON from stdin",
    )

    args = parser.parse_args(argv)

    if args.hook:
        return run_hook_mode(sys.stdin)

    only_codes: set[str] | None = None
    if args.only:
        only_codes = {c.strip().upper() for c in args.only.split(",")}

    ignore_codes: set[str] = set()
    if args.ignore:
        ignore_codes = {c.strip().upper() for c in args.ignore.split(",")}

    all_violations: list[Violation] = []
    for path in iter_python_files(args.paths):
        for v in lint_file(path):
            if only_codes is not None and v.code.upper() not in only_codes:
                continue
            if v.code.upper() in ignore_codes:
                continue
            all_violations.append(v)

    if args.format == "json":
        print(
            json.dumps(
                [v.to_dict() for v in all_violations], ensure_ascii=False, indent=2
            )
        )
    else:
        for v in all_violations:
            print(v.to_text())

    has_errors = any(v.level == "error" for v in all_violations)
    has_warnings = any(v.level == "warning" for v in all_violations)

    if has_errors:
        return 1
    if args.strict and has_warnings:
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
