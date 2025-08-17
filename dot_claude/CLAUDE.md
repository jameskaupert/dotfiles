# CLAUDE.md - Project Assistant Configuration

## Search and File Discovery Preferences

### File Finding
- **ALWAYS use `fd` for file searches** instead of the Glob tool or `find` command
- **Default to case-insensitive searches** - always use the `-i` flag unless case-sensitivity is explicitly needed
- `fd` is installed and available on this system
- Common `fd` usage patterns:
  - Find by extension: `fd -e txt` or `fd -e js -e ts` for multiple
  - Find by name: `fd "pattern"`
  - Find in specific directory: `fd "pattern" /path/to/dir`
  - Find with regex: `fd -t f "^test.*\.py$"`
  - Exclude directories: `fd -E node_modules -E .git`
  - Find directories only: `fd -t d`
  - Find files only: `fd -t f`
  - Case insensitive: `fd -i "pattern"`

### Content Searching
- Use `rg` (ripgrep) for searching file contents when using Bash
- **Default to case-insensitive searches** - always use the `-i` flag unless case-sensitivity is explicitly needed

### Examples of Preferred Commands
```bash
# Instead of using Glob tool for "**/*.json"
fd -e json

# Instead of using Glob for finding config files
fd -t f "config"

# Find all Python files modified in last day
fd -e py --changed-within 1d

# Find files but exclude certain directories
fd -E target -E dist -E node_modules

# Find hidden files too
fd -H "pattern"

File Operations

- Check if parent directories exist before creating new files
- Use absolute paths when possible
- Quote file paths with spaces
