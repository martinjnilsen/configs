# Terminal Setup

A guide to my terminal setup using [Oh My Zsh](https://ohmyz.sh/). For a full step-by-step walkthrough, see my blog post: [Terminal Essentials: A Step-by-Step Setup and Usage Tutorial](https://blog.mjnlab.com/posts/terminal-essentials-a-step-by-step-setup-and-usage-tutorial).

## Themes

### Punctual

A minimal, fast theme. The original repository has not been updated in years, so I made some changes to my own liking. Fetch it directly:

```sh
curl -o ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/punctual.zsh-theme \
  https://raw.githubusercontent.com/martinjnilsen/configs/refs/heads/main/terminal/omz/punctual/.oh-my-zsh/custom/themes/punctual.zsh-theme
```

Then fetch my `.zshrc` config for Punctual:

```sh
curl -o ~/.zshrc \
  https://raw.githubusercontent.com/martinjnilsen/configs/refs/heads/main/terminal/omz/punctual/.zshrc
```

## Terminal Profiles

Custom terminal color profiles (`.terminal` files) can be imported into the macOS Terminal app:

**Terminal** (menu bar) → **Settings** → **Profiles** → **`...`** → **Import**
