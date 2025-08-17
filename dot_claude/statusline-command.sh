#!/bin/bash

# Claude statusline configuration
# Displays: working directory, git branch with status, and Claude session time (when available)

# Read JSON input from stdin
input=$(cat)

# Extract values from JSON
current_dir=$(echo "$input" | jq -r '.workspace.current_dir')
project_dir=$(echo "$input" | jq -r '.workspace.project_dir')
model_name=$(echo "$input" | jq -r '.model.display_name')

# Calculate relative path from project to current directory
if [[ "$current_dir" == "$project_dir"* ]]; then
  rel_path="${current_dir#$project_dir}"
  rel_path="${rel_path#/}"
  if [[ -z "$rel_path" ]]; then
    # Show project directory name instead of "."
    rel_path="$(basename "$project_dir")"
  fi
else
  rel_path="$(basename "$current_dir")"
fi

# Get git information with optional locks skipped
git_info=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git branch --show-current 2>/dev/null || echo "detached")

  # Get git status with concise format
  git_status=""
  if git diff --quiet 2>/dev/null; then
    if git diff --cached --quiet 2>/dev/null; then
      if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
        git_status="?" # untracked files
      else
        git_status="clean" # clean
      fi
    else
      git_status="+" # staged changes
    fi
  else
    git_status="*" # modified files
  fi

  # Check for unpushed commits
  if git log --oneline @{u}.. 2>/dev/null | grep -q .; then
    git_status="${git_status}^"
  fi

  git_info=" git:$branch $git_status"
fi

# Get Claude session time remaining (only if available from ccusage)
session_time=""

# Try ccusage command if available
if command -v ccusage >/dev/null 2>&1; then
  usage_output=$(ccusage blocks --active 2>/dev/null)
  if [[ $? -eq 0 ]] && [[ -n "$usage_output" ]]; then
    # Extract time remaining from ccusage output
    time_remaining=$(echo "$usage_output" | grep -i "Time Remaining" | head -1 | sed 's/.*Time Remaining: *//' | xargs)
    if [[ -n "$time_remaining" ]]; then
      session_time=" $time_remaining"
    fi
  fi
fi

# Color codes (using printf for proper ANSI handling)
BLUE="\033[34m"
GREEN="\033[32m"
YELLOW="\033[33m"
RED="\033[31m"
PURPLE="\033[35m"
CYAN="\033[36m"
RESET="\033[0m"

# Build and print statusline with colors in a single line
printf "${CYAN}%s${RESET}" "$rel_path"

if [[ -n "$git_info" ]]; then
  case "$git_status" in
  "clean") printf "${GREEN}%s${RESET}" "$git_info" ;;
  "*" | "+") printf "${YELLOW}%s${RESET}" "$git_info" ;;
  "?") printf "${RED}%s${RESET}" "$git_info" ;;
  *) printf "${PURPLE}%s${RESET}" "$git_info" ;;
  esac
fi

if [[ -n "$session_time" ]]; then
  printf "${BLUE}%s${RESET}" "$session_time"
fi

echo
