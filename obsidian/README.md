# Obsidian Config Template

Every Obsidian vault stores its settings in a `.obsidian` folder at the root of the vault. The contents of this directory can be replaced with the files in the config repository to apply a consistent base configuration to any vault.

## Table of Contents
- [Usage](#usage)
- [Set custom app icon](#set-custom-app-icon)
- [Notes](#notes)

## Usage
### Automatic (recommended)
Run this from the root of an existing Obsidian vault. It checks that `.obsidian` exists, sparse-checks out only the `obsidian` folder from the repository, copies it into the vault, and removes the temporary clone.

```sh
[ -d .obsidian ] || { echo "Error: .obsidian folder not found. Run this from an Obsidian vault root."; exit 1; }; git clone --depth=1 --filter=tree:0 --no-checkout https://github.com/martinjnilsen/configs.git obsidian-vault-template && cd obsidian-vault-template && git sparse-checkout set obsidian && git checkout main && cp -r obsidian/. ../.obsidian/ && cd .. && rm -rf obsidian-vault-template
```

### Manual
If preferred, clone the repository and copy the `obsidian` folder into the vault's `.obsidian` directory manually.

```sh
git clone https://github.com/martinjnilsen/configs.git
cp -r configs/obsidian/. /path/to/your/vault/.obsidian/
```

After either method, the vault will use the persisted settings from the Git repository for themes, plugins, snippets, and other vault-level configuration.

## Set custom app icon
The app icon choice is stored as an application-level setting, not as a vault-local file, so it must be selected again on a new machine.

To set the app icon:

1. Open **Settings → Appearance → Advanced**.
2. Under **Custom app icon**, click **Choose**.
3. Select `.obsidian/appicon.png` via the file picker.
4. Click **Relaunch**.

## Notes
> The `.obsidian` folder is hidden in macOS by default. Use `Cmd+Shift+.` in Finder or `ls -a` in the terminal to see it.