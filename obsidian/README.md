# Obsidian Config Template

Every Obsidian vault stores its settings in a `.obsidian` folder at the root of the vault. The contents of this directory can be replaced with the files in the config repository to apply a consistent base configuration to any vault.

## Table of Contents
- [Create vault](#create-vault)
- [Fresh machine setup](#fresh-machine-setup)
- [Run setup script](#run-setup-script)
- [Notes](#notes)

## Create vault
1. Open Obsidian.
2. In the vault manager:
   - **First time**: the vault manager opens automatically on launch. Click **Create new vault**.
   - **Existing setup**: click the current vault name → **Manage Vaults...** → **Create new vault**.
3. Enter a vault name and **choose a location** (Obsidian will create the folder, no need to create it first).
4. Click **Create**.

## Fresh machine setup
These steps are **system-wide** and only need to be done once per machine, regardless of how many vaults you create.

### Enable CLI
The setup script uses the [Obsidian CLI](https://obsidian.md/cli), which requires Obsidian 1.12.7 or later.

1. Open **Settings → General**.
2. Enable **Command line interface**.
3. Follow the on-screen prompt to register the CLI in your system PATH.
4. Restart your terminal for the PATH change to take effect.
5. Verify the CLI works:
   ```sh
   obsidian help
   ```

> **Note:** The Obsidian app must be running for CLI commands to work.

### Set custom app icon
1. Download the [app icon](https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/appicon.png) to your Downloads folder:
   ```sh
   curl -fsSL "https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/appicon.png" -o ~/Downloads/appicon.png
   ```
2. Open **Settings → Appearance → Advanced**.
3. Under **Custom app icon**, click **Choose**.
4. Select `appicon.png` from your Downloads folder via the file picker.
5. Click **Relaunch**.

## Run setup script

The script does the following, in order:

1. Disables restricted mode so community plugins can be installed.
2. Fetches the plugin list from [`obsidian/community-plugins.json`](https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/community-plugins.json) and installs and enables each plugin.
3. Applies the config template by merging the `obsidian` folder from the config repository into your vault's `.obsidian` folder. Existing files not covered by the template are left untouched.
4. Creates the standard vault folders defined in [`obsidian/config/vault-folders.json`](https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/vault-folders.json).
5. Reloads Obsidian.

Run this from the root of your vault:

```sh
curl -fsSL "https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/setup.sh" | bash
```

<details>
<summary>More options — dry run, help, and manual inspection</summary>

**Preview what the script will do without making any changes:**

```sh
# Shows each step that would be taken, without applying anything
curl -fsSL "https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/setup.sh" | bash -s -- --dry-run
```

**Print the help message:**

```sh
# Lists all available flags and usage instructions
curl -fsSL "https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/setup.sh" | bash -s -- help
```

**Download and inspect the script before running it:**

```sh
curl -fsSL "https://raw.githubusercontent.com/martinjnilsen/configs/main/obsidian/config/setup.sh" -o setup.sh
# Review setup.sh, then run with any flags:
bash setup.sh             # normal run
bash setup.sh --dry-run   # preview only
bash setup.sh --verbose   # print every step
bash setup.sh --debug     # print debug output
bash setup.sh help        # show help
```

> **What does `bash -s -- <args>` mean?**
>
> - `-s` tells bash to read the script from stdin (the pipe) rather than a file.
> - `--` marks the end of bash's own options — everything after it is passed as arguments to the script itself.
> - Without `--`, a flag like `--dry-run` could be misinterpreted as a bash option rather than a script argument.

</details>

## Notes
> The `.obsidian` folder is hidden in macOS by default. Use `Cmd+Shift+.` in Finder or `ls -a` in the terminal to see it.
