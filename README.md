# Python Project Setup Script

A bash script that creates Python projects with modern development tools using `uv`.

Make sure [uv](https://github.com/astral-sh/uv) is installed beforehand.

## Required Files

Place these configuration files in the same directory as the script:

```
├── start-project.sh
├── ruff.toml
├── ty.toml
├── pytest.toml
├── poe.toml
├── .gitignore
└── .pre-commit-config.yaml
```

## Usage

```bash
chmod +x start-project.sh
./start-project.sh
```

Enter a project name or path when prompted.

## What It Sets Up

- **uv** - Package management
- **ruff** - Formatting and linting
- **ty** - Type checking
- **pytest** - Testing
- **poethepoet** - Task runner
- **pre-commit** - Git hooks

## Available Commands

```bash
uv run poe format      # Format code
uv run poe lint        # Lint code
uv run poe lint-fix    # Lint and auto-fix
uv run poe type-check  # Type check
uv run poe test        # Run tests
uv run poe check       # Run all checks
```

## Getting Started

```bash
cd my-project
uv run poe check
```
