#!/bin/bash
# claude symlink hash: {{ output "echo" "ai-assistant-claude-symlink-v1" | sha256sum }}

set -euo pipefail

# Only run inside devpod containers, not on host
if [ "${DEVPOD:-}" != "1" ]; then
  echo "Skipping .claude symlink setup (not in devpod container)"
  exit 0
fi

AI_ASSISTANT_PATH="$HOME/workspace/github.com/jameskaupert/ai-assistant"
CLAUDE_PATH="$AI_ASSISTANT_PATH/.claude"
SYMLINK_TARGET="$HOME/.claude"

echo "-- setting up .claude symlink to ai-assistant --"

# Check if ai-assistant exists
if [ ! -d "$AI_ASSISTANT_PATH" ]; then
  echo "WARNING: ai-assistant repository not found at $AI_ASSISTANT_PATH"
  echo "Please clone it with: git clone git@github.com:jameskaupert/ai-assistant.git $AI_ASSISTANT_PATH"
  exit 0
fi

# Check if .claude directory exists in ai-assistant
if [ ! -d "$CLAUDE_PATH" ]; then
  echo "WARNING: .claude directory not found in ai-assistant repository at $CLAUDE_PATH"
  exit 0
fi

# Remove existing .claude if it's not already the correct symlink
if [ -e "$SYMLINK_TARGET" ] || [ -L "$SYMLINK_TARGET" ]; then
  if [ -L "$SYMLINK_TARGET" ] && [ "$(readlink "$SYMLINK_TARGET")" == "$CLAUDE_PATH" ]; then
    echo ".claude symlink already correctly configured"
    exit 0
  fi
  echo "Removing existing .claude (will be replaced with symlink)"
  rm -rf "$SYMLINK_TARGET"
fi

# Create the symlink
ln -s "$CLAUDE_PATH" "$SYMLINK_TARGET"
echo "✓ Created symlink: $SYMLINK_TARGET -> $CLAUDE_PATH"

exit 0
