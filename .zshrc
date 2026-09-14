# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME unset by the starship plugin

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
# DISABLE_AUTO_TITLE="true"

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

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  golang
  fzf
  mise
  starship
  zoxide
  zsh-autosuggestions
  zsh-interactive-cd
  zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

export PAGER='less'
export EDITOR='nvim'

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Browser handling lives in ~/.local/bin/xdg-open (first on PATH): an OSC 8
# clickable link when SSH'd in, wslview when local under WSL, the real xdg-open
# on a desktop. Nothing aliases xdg-open, so no unalias is needed here.
alias sensible-browser='xdg-open'
export BROWSER="$HOME/.local/bin/xdg-open"


export PATH="$HOME/.local/bin:$HOME/go/bin:$PATH"

# nvm is loaded by the oh-my-zsh `nvm` plugin above (it sets NVM_DIR and sources
# nvm.sh + completions). The installer's own block used to live here and made it
# load twice, costing ~260ms per shell.

# dotfiles bare repo (https://www.atlassian.com/git/tutorials/dotfiles)
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# keep tmux plugins out of ~/.config (oh-my-tmux honors this; data, not config)
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.local/share/tmux/plugins"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# --- merged from pre-dotfiles setup ---
export SUDO_ASKPASS="$HOME/.local/bin/sudo-askpass"

alias ls='LS_COLORS= eza --group-directories-first'
alias ll='LS_COLORS= eza -lh --group-directories-first --git'
alias la='LS_COLORS= eza -lha --group-directories-first --git'
alias lt='LS_COLORS= eza --tree --level=2 --git-ignore'
alias cat='bat --paging=never'
alias snaps='snapper -c root list'
alias snaph='snapper -c home list'

export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border
  --color=bg+:#313244,bg:-1,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
  --color=selected-bg:#45475a,border:#6c7086,label:#cdd6f4'

# take Ctrl-R back from zsh-navigation-tools (n-history still available as a command)
bindkey '^R' fzf-history-widget

# --- completion menu ---------------------------------------------------------
# fzf-tab rebinds Tab itself: it hooks zsh's completion system, so every compdef
# oh-my-zsh already loaded (git, systemctl, docker, mise) comes through fzf.
# This is orthogonal to the oh-my-zsh `fzf` plugin above, which owns Ctrl-R,
# Ctrl-T and Alt-C. Must be sourced after compinit (oh-my-zsh.sh) and after
# zsh-autosuggestions.
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh

zstyle ':completion:*' menu no                      # fzf-tab draws the menu, not zsh
zstyle ':completion:*:descriptions' format '[%d]'   # required for group headers
zstyle ':completion:*:git-checkout:*' sort false    # keep git's own branch order
[[ -n $LS_COLORS ]] && zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':fzf-tab:*' switch-group '<' '>'            # cycle groups when several match

# Previews, keyed by what is being completed.
zstyle ':fzf-tab:complete:(cd|__zoxide_z|ls|ll|eza):*' fzf-preview \
  'LS_COLORS= eza -1 --color=always --icons --group-directories-first $realpath'
zstyle ':fzf-tab:complete:(nvim|vim|nano|bat|cat|less|rm|cp|mv):*' fzf-preview \
  '[[ -d $realpath ]] && LS_COLORS= eza -1 --color=always --icons $realpath || bat --color=always --style=numbers --line-range=:200 $realpath'
zstyle ':fzf-tab:complete:git-(add|diff|restore|stage):*' fzf-preview \
  'git diff --color=always -- $word | delta'
zstyle ':fzf-tab:complete:git-(checkout|switch|branch|rebase|merge):*' fzf-preview \
  'git log --oneline --graph --color=always -50 $word'
zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'git show --color=always $word | delta'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(-command-|export|unset|printenv):*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:(man|tldr):*' fzf-preview \
  'tldr --color always $word 2>/dev/null || man $word 2>/dev/null | col -bx'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o pid,user,%cpu,%mem,cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:4:wrap

# Syntax highlighting rewrites the command line as you type, so it has to wrap
# every widget that already exists: it must stay the last plugin sourced.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
