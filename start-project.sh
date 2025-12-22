#!/bin/bash

set -e

TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

read -p "Enter project name or path: " PROJECT_INPUT

PROJECT_NAME=$(basename "$PROJECT_INPUT")
PROJECT_PATH="$PROJECT_INPUT"

echo "Creating project: $PROJECT_NAME at $PROJECT_PATH"
echo ""

mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"

echo "Initializing project with uv..."
uv init --name "$PROJECT_NAME"
echo ""

echo "Installing development tools..."
uv add --dev -q ruff
uv add --dev -q ty
uv add --dev -q poethepoet
uv add --dev -q pytest
uv add --dev -q pre-commit
echo ""

echo "Adding tool configurations to pyproject.toml..."

{
    echo ""
    cat "$TEMPLATE_DIR/ruff.toml"
    echo ""
    cat "$TEMPLATE_DIR/ty.toml"
    echo ""
    cat "$TEMPLATE_DIR/pytest.toml"
    echo ""
    cat "$TEMPLATE_DIR/poe.toml"
    echo ""
} >> pyproject.toml

echo "Configuration files merged into pyproject.toml"
echo ""

cp "$TEMPLATE_DIR/.pre-commit-config.yaml" .

echo "Installing pre-commit hooks..."
uv run pre-commit install
echo ""

echo "Setting up .gitignore"
cp "$TEMPLATE_DIR/.gitignore" .
echo ""

echo "Creating tests directory..."
mkdir -p tests
touch tests/__init__.py

cat > tests/test_true.py << 'EOF'
def test_true():
    """Remove this test once you add real tests."""
    assert True
EOF

echo "✨ Project '$PROJECT_NAME' created successfully at: $PROJECT_PATH"
echo ""
echo "Available poe tasks:"
echo "  poe format     - Format code with ruff"
echo "  poe lint       - Lint code with ruff"
echo "  poe lint-fix   - Lint and auto-fix issues"
echo "  poe type-check - Run type checking with ty"
echo "  poe test       - Run tests with pytest"
echo "  poe check      - Run all checks (format, lint, type-check, test)"
echo ""
echo "Pre-commit hooks installed and will run on git commit."
echo ""
echo "To get started:"
echo "  cd $PROJECT_PATH"
echo "  uv run poe check"
