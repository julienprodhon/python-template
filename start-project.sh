#!/bin/bash

set -e

TEMPLATE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

read -p "Enter project name or path: " PROJECT_INPUT

PROJECT_NAME=$(basename "$PROJECT_INPUT")
PROJECT_PATH="$PROJECT_INPUT"

if [ -d "$PROJECT_PATH" ] && [ "$(ls -A "$PROJECT_PATH")" ]; then
    echo "Warning: Directory $PROJECT_PATH already exists and is not empty"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

mkdir -p "$PROJECT_PATH"
cd "$PROJECT_PATH"

echo
echo "Initializing $PROJECT_NAME at $PROJECT_PATH with uv..."
uv init --name "$PROJECT_NAME"
echo

echo "Installing development tools..."
uv add --dev -q ruff ty poethepoet pytest pre-commit
echo "✓ Installed: ruff, ty, poethepoet, pytest, pre-commit"
echo

echo "Adding tool configurations..."
echo >> pyproject.toml
for file in "$TEMPLATE_DIR"/*.toml; do
    echo "$(basename "$file")"
    cat "$file" >> pyproject.toml
    echo >> pyproject.toml
done
echo "Configuration files merged into pyproject.toml"
echo

echo "Setting up .gitignore"
cp "$TEMPLATE_DIR/.gitignore" .
cp "$TEMPLATE_DIR/.pre-commit-config.yaml" .
uv run pre-commit install
echo "Pre-commit will run on git commit!"
echo

mkdir -p tests
touch tests/__init__.py
echo "Tests directory created."

cat > tests/test_true.py << 'EOF'
def test_true():
    """Remove this test once you add real tests."""
    assert True
EOF

echo
echo "✨ Project '$PROJECT_NAME' created successfully!"
echo
echo "To get started:"
echo "  cd $PROJECT_PATH"
echo "  uv run main.py        # Run the application"
echo "  uv run poe check      # Run all checks"
echo "  uv run poe            # Show all tasks"
