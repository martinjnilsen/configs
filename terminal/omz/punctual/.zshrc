# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation. Defaults to user directory.
# export ZSH="/Users/martinjohannesnilsen/.oh-my-zsh"
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="punctual"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


#############
## Plugins ##
#############
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  # bundled
  command-not-found
  copypath
  copyfile
  copybuffer
  dirhistory
  git
  sudo
  fzf
  # custom / external
  zsh-autosuggestions
  zsh-syntax-highlighting
  #ohmyzsh-full-autoupdate
)

# Plugin configs
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root line)
ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')
export PATH="$HOME/.local/bin:$PATH"
export FZF_BASE=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf/
export FZF_DEFAULT_COMMAND="find . \( -name node_modules -o -name .git -o -name .venv \) -prune -o -print" # Hide Node modules, git or Python venv files
export FZF_DEFAULT_OPTS="--height=40% --layout=reverse" # Set height and reversed layout (selector below)
ZOXIDE_CMD_OVERRIDE="cd" # Override default cd behavior
DISABLE_FZF_AUTO_COMPLETION="false" # Enable autocompletion
DISABLE_FZF_KEY_BINDINGS="false" # Enable key bindings

# Source changes
source $ZSH/oh-my-zsh.sh


####################
## Visual Changes ##
####################
# Set listing colors
export CLICOLOR=1
export CLICOLOR_FORCE=1
export LSCOLORS="exgxfxdacxDaDaxbadacex" # macOS color for ls command (or BSD systems)
export LS_COLORS="di=34;40:ln=36;40:so=35;40:pi=33;40:ex=32;40:bd=1;33;40:cd=1;33;40:su=0;41:sg=0;43:tw=0;42:ow=34;40:" # Linux color for ls command (or GNU systems)
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} # Sets the color for zsh autocomplete

# Suppress login banner (Mac specific)
touch ~/.hushlogin

# Disable default virtual env prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Punctual prompt configurations
PUNCTUAL_SHOW_BLANK_LINE="false"
PUNCTUAL_SHOW_INDENT="false"
PUNCTUAL_SHOW_TIMESTAMP="true"
PUNCTUAL_SHOW_USER="false"
PUNCTUAL_SHOW_HOSTNAME="false"
PUNCTUAL_SHOW_CURRENT_DIR="true"
PUNCTUAL_SHOW_GIT="true"
PUNCTUAL_SHOW_PYTHON_ENVIRONMENT="true"

PUNCTUAL_TIMESTAMP_COLOUR="white"
PUNCTUAL_USER_COLOUR="blue"
PUNCTUAL_ROOT_USER_COLOUR="red"
PUNCTUAL_HOSTNAME_COLOUR="cyan"
PUNCTUAL_CURRENT_DIR_COLOUR="green"
PUNCTUAL_GIT_COLOUR="magenta"
PUNCTUAL_PYTHON_ENVIRONMENT_COLOUR="yellow"

PUNCTUAL_TIMESTAMP_BOLD="false"
PUNCTUAL_USER_BOLD="false"
PUNCTUAL_ROOT_USER_BOLD="false"
PUNCTUAL_HOSTNAME_BOLD="false"
PUNCTUAL_CURRENT_DIR_BOLD="false"
PUNCTUAL_GIT_BOLD="false"
PUNCTUAL_PYTHON_ENVIRONMENT_BOLD="false"

PUNCTUAL_TIMESTAMP_FORMAT="%H:%M:%S"

PUNCTUAL_CURRENT_DIR_RELATIVE_PATH="true"
PUNCTUAL_CURRENT_DIR_RELATIVE_DEPTH="3"

PUNCTUAL_PROMPT=">"

PUNCTUAL_GIT_SYMBOL_UNTRACKED="?"
PUNCTUAL_GIT_SYMBOL_ADDED="+"
PUNCTUAL_GIT_SYMBOL_MODIFIED="!"
PUNCTUAL_GIT_SYMBOL_RENAMED="!"
PUNCTUAL_GIT_SYMBOL_DELETED="!"
PUNCTUAL_GIT_SYMBOL_STASHED="*"
PUNCTUAL_GIT_SYMBOL_UNMERGED="M"
PUNCTUAL_GIT_SYMBOL_AHEAD="↑"
PUNCTUAL_GIT_SYMBOL_BEHIND="↓"
PUNCTUAL_GIT_SYMBOL_DIVERGED="~"


#############
## Configs ##
#############

# Homebrew
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# Tailscale
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"