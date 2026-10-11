#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_TARGET="$HOME/.local/bin/vscode-icon"

echo "Installing vscode-icon CLI..."
mkdir -p "$HOME/.local/bin"
ln -sf "$SCRIPT_DIR/vscode-icon" "$BIN_TARGET"
chmod +x "$SCRIPT_DIR/vscode-icon"

echo "Applying custom icon..."
"$BIN_TARGET" apply

echo "Enabling boot automation..."
"$BIN_TARGET" automate enable

echo ""
echo "Installation complete!"
echo "You can now run 'vscode-icon' directly from any terminal."
