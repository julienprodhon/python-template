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
poe format      # Format code
poe lint        # Lint code
poe lint-fix    # Lint and auto-fix
poe type-check  # Type check
poe test        # Run tests
poe check       # Run all checks
```

## Getting Started

```bash
cd my-project
uv run poe check
```
