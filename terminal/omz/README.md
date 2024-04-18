# Terminal Setup

A guide to my terminal setup using [Oh My Zsh](https://ohmyz.sh/). For a full step-by-step walkthrough, see my blog post: [Terminal Essentials: A Step-by-Step Setup and Usage Tutorial](https://blog.mjnlab.com/posts/terminal-essentials-a-step-by-step-setup-and-usage-tutorial).

## Themes

### Punctual (Recommended)

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

### Powerlevel10k

A highly customizable theme with a rich prompt. Install the theme from the upstream repo:

```sh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```

Then fetch my `p10k` config:

```sh
curl -o ${ZSH_CUSTOM:-$HOME/}.p10k.zsh \
  https://raw.githubusercontent.com/martinjnilsen/configs/refs/heads/main/terminal/omz/powerlevel10k/.p10k.zsh
```

Then fetch my `.zshrc` config for Powerlevel10k:

```sh
curl -o ~/.zshrc \
  https://raw.githubusercontent.com/martinjnilsen/configs/refs/heads/main/terminal/omz/powerlevel10k/.zshrc
```

## Terminal Profiles

Custom terminal color profiles (`.terminal` files) can be imported into the macOS Terminal app:

**Terminal** (menu bar) → **Settings** → **Profiles** → **`...`** → **Import**
