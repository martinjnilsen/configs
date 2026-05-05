#!/usr/bin/env bash
# Obsidian vault setup script
# Run from the root of your Obsidian vault.
# Requires: Obsidian app running with a vault window open, CLI enabled and registered in PATH.

set -euo pipefail

PLUGINS_RAW_URL="https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/community-plugins.json"
FOLDERS_RAW_URL="https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/vault-folders.json"
CONFIG_GIT_URL="https://github.com/martinjnilsen/configs.git"
TMP_DIR=".obsidian-setup-tmp"
VERBOSE=false
DEBUG=false
DRY_RUN=false

# ── Flags ─────────────────────────────────────────────────────────────────────

for arg in "$@"; do
  case "$arg" in
    --verbose) VERBOSE=true ;;
    --debug)   DEBUG=true ;;
    --dry-run) DRY_RUN=true ;;
    help)
      echo "Usage: bash setup.sh [--verbose] [--debug] [--dry-run] [help]"
      echo ""
      echo "  --verbose   Print all steps and output during setup."
      echo "  --debug     Print debug information for troubleshooting."
      echo "  --dry-run   Preview what would happen without making any changes."
      echo "  help        Show this help message."
      echo ""
      echo "Run from the root of your Obsidian vault with the app open."
      exit 0
      ;;
    *)
      echo "[error] Unknown argument: $arg"
      echo ""
      echo "Usage: bash setup.sh [--verbose] [--debug] [--dry-run] [help]"
      echo ""
      exit 1
      ;;
  esac
done

# ── Helpers ───────────────────────────────────────────────────────────────────

cmd()     { $VERBOSE && echo "> $*" || true; }
info()    { $VERBOSE && echo "[info] $*" || true; }
warning() { $VERBOSE && echo "[warning] $*" || true; }
error()   { echo "[error] $*"; echo ""; exit 1; }
item()    { $VERBOSE && echo "  - $*" || true; }
debug()   { $DEBUG && echo "[debug] $*" || true; }
dryrun()  { $DRY_RUN && echo "[dry-run] $*" || true; }

# run <description> <cmd...>
# In dry-run mode: prints what would run. Otherwise: executes the command.
run() {
  local desc="$1"; shift
  if $DRY_RUN; then
    echo "[dry-run] $desc"
  else
    "$@"
  fi
}

git_quiet() { "$@" > /dev/null 2>&1; }

debug "Flags: VERBOSE=$VERBOSE DEBUG=$DEBUG DRY_RUN=$DRY_RUN"
debug "Working directory: $(pwd)"

$DRY_RUN && echo "[dry-run] Previewing setup — no changes will be made."
$DRY_RUN && echo ""

# ── Preflight ─────────────────────────────────────────────────────────────────

debug "Checking for .obsidian folder..."
[ -d ".obsidian" ] || error ".obsidian folder not found. Run this from an Obsidian vault root."
debug "Found .obsidian folder."

debug "Checking for obsidian CLI..."
command -v obsidian &>/dev/null || error "obsidian CLI not found. Enable it in Settings → General and register it in PATH."
debug "obsidian CLI found at: $(command -v obsidian)"

# Verify Obsidian is reachable (a vault window must be open)
# Skip reachability check in dry-run since we won't be calling the CLI
if $DRY_RUN; then
  dryrun "Would verify Obsidian is reachable via: obsidian plugins:restrict off"
else
  debug "Testing Obsidian reachability via plugins:restrict off..."
  RESTRICT_OUTPUT=$(obsidian plugins:restrict off </dev/null 2>&1) || true
  debug "plugins:restrict output: $RESTRICT_OUTPUT"
  if echo "$RESTRICT_OUTPUT" | grep -qi "not found"; then
    error "Obsidian is not reachable. Make sure the app is running with a vault window open, then try again."
  fi
fi

# ── Disable restricted mode ───────────────────────────────────────────────────

cmd "Disabling restricted mode..."
if $DRY_RUN; then
  dryrun "Would disable restricted mode: obsidian plugins:restrict off"
else
  if echo "$RESTRICT_OUTPUT" | grep -qi "already disabled"; then
    info "Restricted mode is already disabled."
  else
    info "Restricted mode disabled."
  fi
fi

# ── Install community plugins ─────────────────────────────────────────────────

cmd "Fetching plugin list..."
PLUGINS_TMP=$(mktemp)
debug "Temp file for plugins: $PLUGINS_TMP"
curl -fsSL "$PLUGINS_RAW_URL" | grep -o '"[^"]*"' | sed 's/"//g' > "$PLUGINS_TMP"
cmd "Installing and enabling plugins..."
PLUGIN_LIST=()
while IFS= read -r line; do
  [ -n "$line" ] && PLUGIN_LIST+=("$line")
done < "$PLUGINS_TMP"
rm -f "$PLUGINS_TMP"
debug "Plugin count: ${#PLUGIN_LIST[@]}"
for id in "${PLUGIN_LIST[@]}"; do
  if $DRY_RUN; then
    echo "[dry-run] Would install and enable plugin: $id"
  else
    debug "Attempting install: $id"
    OUTPUT=$(obsidian plugin:install "id=$id" enable </dev/null 2>&1) || true
    debug "Output: $OUTPUT"
    if echo "$OUTPUT" | grep -qi "^error:" && ! echo "$OUTPUT" | grep -qi "already installed"; then
      error "Failed to install plugin \"$id\": $OUTPUT"
    else
      item "$id"
    fi
  fi
done
debug "Plugin installation complete."

# ── Apply config template ─────────────────────────────────────────────────────

cmd "Applying config template..."
if $DRY_RUN; then
  dryrun "Would clone $CONFIG_GIT_URL (sparse: obsidian/) and copy obsidian/ → .obsidian/"
else
  if [ -d "$TMP_DIR" ]; then
    info "Removing leftover temp directory..."
    debug "Removing: $TMP_DIR"
    rm -rf "$TMP_DIR"
  fi
  debug "Cloning config repo from: $CONFIG_GIT_URL"
  git_quiet git clone --depth=1 --filter=tree:0 --no-checkout "$CONFIG_GIT_URL" "$TMP_DIR"
  debug "Clone complete. Setting sparse checkout for obsidian folder..."
  cd "$TMP_DIR"
  git_quiet git sparse-checkout set obsidian
  debug "Checking out main..."
  git_quiet git checkout main
  debug "Copying obsidian config files to .obsidian/..."
  cp -r obsidian/. ../.obsidian/
  cd ..
  rm -rf "$TMP_DIR"
  debug "Config template applied and temp directory removed."
fi

# ── Create vault folders ──────────────────────────────────────────────────────

cmd "Creating vault folders..."
FOLDERS_TMP=$(mktemp)
debug "Temp file for folders: $FOLDERS_TMP"
curl -fsSL "$FOLDERS_RAW_URL" | grep -o '"[^"]*"' | sed 's/"//g' > "$FOLDERS_TMP"
debug "Parsed folder list:"
while IFS= read -r folder; do
  debug "  '$folder'"
done < "$FOLDERS_TMP"
while IFS= read -r folder || [ -n "$folder" ]; do
  [ -z "$folder" ] && continue
  if $DRY_RUN; then
    echo "[dry-run] Would create folder: $folder"
  else
    debug "Creating folder: $folder"
    mkdir -p "$folder"
  fi
done < "$FOLDERS_TMP"
rm -f "$FOLDERS_TMP"
debug "Vault folders created."

# ── Reload ────────────────────────────────────────────────────────────────────

cmd "Reloading Obsidian..."
if $DRY_RUN; then
  dryrun "Would reload Obsidian: obsidian reload"
  echo ""
  echo "[dry-run] Preview complete. Run without --dry-run to apply."
else
  debug "Running: obsidian reload"
  obsidian reload </dev/null > /dev/null 2>&1 && true || warning "Could not reload Obsidian automatically. Please reload manually with Cmd/Ctrl + R."
  debug "Reload complete."
  echo "[info] Done. Your vault is configured."
fi