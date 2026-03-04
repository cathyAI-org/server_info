# Homelab Development Guidelines

These guidelines define the mandatory standards for all code, commits, documentation, and workflows in the cathyAI homelab projects.  
They must be followed by every developer and can be directly referenced when working with Amazon Q Developer (e.g., "Follow the cathyAI Homelab Development Guidelines for this change").

---

## Python Code Standards

### PEP 8 + Black Formatter
- All Python code must be fully compliant with PEP 8.
- Use **exactly 4 spaces** for indentation.
- Maximum line length is **88 characters** (Black formatter default).
- Functions and variables must use `snake_case`.
- Classes must use `PascalCase`.
- Every function and method must include **type hints** (Python 3.9+ syntax).  
  Avoid `Any` unless no better type exists.

### Documentation (reST format – mandatory template)

Every public function, class, and method must use this exact reStructuredText format:

```python
def example_function(param1: str, param2: int) -> bool:
    """Brief one-line description ending with a period.

    Longer explanation if needed (maximum 3-4 sentences).

    :param param1: Description of what param1 does.
    :param param2: Description of what param2 does.
    :return: Description of the return value.
    :raises ValueError: When invalid input is provided.
    """
```

Requirements:
- Document every parameter and the return value.
- Document every exception that the function can raise.
- Keep descriptions clear, concise, and factual.

---

## Testing Standards

- Shared resources (`characters/`, `public/`, etc.) must have tests in `tests/test_app.py`.
- Service-specific functionality (e.g., `webbui_chat`, `characters_api`) must have dedicated `test_*.py` files.
- Tests must validate file structure, API contracts, configuration consistency, and all new behaviour.
- All tests use `pytest` and must be independent (external services must be mocked).
- Before any commit, run:  
  ```bash
  black . && flake8 . && pytest
  ```

---

## Commit Message Format (mandatory – exact structure required)

Every commit must follow this **exact** format:

```
[type]: Title

Description:
  - Change 1
  - Change 2
  - Change 3

Additional info:
  - Additional context or notes
  - Related information
```

### Allowed commit types

| Type      | Purpose                              |
|-----------|--------------------------------------|
| `feat`    | New feature                          |
| `fix`     | Bug fix                              |
| `docs`    | Documentation changes only           |
| `style`   | Code style / formatting (no logic)   |
| `refactor`| Refactoring (no behaviour change)    |
| `test`    | Adding or updating tests             |
| `chore`   | Maintenance, CI, dependencies        |

**Correct example:**
```
[feat]: Add character import endpoint

Description:
  - Added POST /api/characters/import endpoint
  - Updated characters/ directory handling
  - Added corresponding tests

Additional info:
  - Related to #42
```

---

## Post-Change Requirements (mandatory)

After every change you **must**:
1. Update `README.md` so it always reflects the current file structure and behaviour.
2. Update or add the corresponding tests.
3. Keep all documentation 100% synchronized with the actual code.
4. Run the full test + lint suite before committing.

---

## Minimal Code Principle

**Write the absolute smallest amount of correct code needed.**

- Never add extra files, functions, classes, logging, comments, or error handling unless explicitly required.
- Avoid any code that does not directly solve the current requirement.
- "Future-proofing", premature optimisation, and unnecessary abstraction are forbidden, unless motivated.
- If a change can be done in 5 lines, never write 50.

---

## Repository-Specific Standards

- All services (`webbui_chat`, `characters_api`, etc.) must remain completely independent.
- Shared directories (`characters/`, `public/`) must be used exactly as currently structured.
- All services must follow the existing Docker containerization pattern.
- Configuration must only be managed via `.env.template` files (never hard-coded values).

---

## Secrets Management (zero tolerance)

**Never commit real secrets.**

- `.env` and `config.yaml`, or similar files must be in `.gitignore`.
- Use only placeholder values in `.env.template`.
- Generate keys with: `openssl rand -hex 32`
- One unique secret per service.
- Document the purpose of each secret with comments.

---

## Git Workflow

### Before starting work
1. `git pull origin main`
2. `git checkout -b type/short-description` (e.g. `feat/add-login`)

### During development
- Write minimal code only.
- Add or update tests immediately.
- Commit frequently using the exact commit format above.

### Before committing
1. Run `black . && flake8 . && pytest`
2. Update `README.md` if structure or behaviour changed
3. Review changes with `git diff`

---

**These guidelines ensure maximum consistency, maintainability, and minimal technical debt across all cathyAI homelab projects.**

When using GenAI, simply tell it:  
"Follow the Homelab Development Guidelines for this task" — and paste or reference this document.
