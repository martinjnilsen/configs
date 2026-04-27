# Obsidian Config Template

Every Obsidian vault stores its settings in a `.obsidian` folder at the root of the vault. The contents of this directory can be replaced with the files in the config repository to apply a consistent base configuration to any vault.

## Table of Contents
- [Usage](#usage)
- [Post‑setup](#post-setup)
- [Set custom app icon](#set-custom-app-icon)
- [Notes](#notes)

## Usage
### Automatic (recommended)
Run this from the root of an existing Obsidian vault. It checks that `.obsidian` exists, sparse-checks out only the `obsidian` folder from the repository, copies it into the vault, and removes the temporary clone.

```sh
[ -d .obsidian ] || { echo "Error: .obsidian folder not found. Run this from an Obsidian vault root."; exit 1; }; git clone --depth=1 --filter=tree:0 --no-checkout https://github.com/martinjnilsen/configs.git obsidian-vault-template && cd obsidian-vault-template && git sparse-checkout set obsidian && git checkout main && cp -r obsidian/. ../.obsidian/ && cd .. && rm -rf obsidian-vault-template
```

### Step-by-step
If preferred, clone the repository and copy the `obsidian` folder into the vault's `.obsidian` directory manually.

```sh
# Check that we're in a vault root by verifying the presence of the .obsidian folder
[ -d .obsidian ] || { echo "Error: .obsidian folder not found. Run this from an Obsidian vault root."; exit 1; }

# Clone the repository (or download and extract the ZIP) to a temporary location
git clone https://github.com/martinjnilsen/configs.git obsidian-vault-template

# Copy the `obsidian` folder from the temporary clone to the vault's `.obsidian` directory
cp -r obsidian-vault-template/obsidian/. .obsidian/

# Remove the temporary clone
rm -rf obsidian-vault-template
```

## Post‑setup
1. Open Obsidian → **Settings → Community plugins → Turn off restricted mode** (if not already).
2. **Reload Obsidian** (`Cmd/Ctrl + R`) or restart the app.
3. Go to **Community plugins → Check for updates** and **Enable** any plugins that appear as "installed but disabled".
4. **Reload again** (`Cmd/Ctrl + R`) to fully activate all plugins and refresh the ribbon.

The vault will then use the persisted settings from the Git repository for themes, plugins, snippets, and other vault‑level configuration.

## Set custom app icon
The app icon choice is stored as an application‑level setting, not as a vault‑local file, so it must be selected again on a new machine.

To set the app icon:

1. Open **Settings → Appearance → Advanced**.
2. Under **Custom app icon**, click **Choose**.
3. Select `.obsidian/appicon.png` via the file picker.
4. Click **Relaunch**.

## Notes
> The `.obsidian` folder is hidden in macOS by default. Use `Cmd+Shift+.` in Finder or `ls -a` in the terminal to see it.