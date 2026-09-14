# dotfiles

Bare git repo checked out directly over `$HOME`. Tracked files only — `status` is
configured to hide everything untracked, so `$HOME` stays quiet.

```
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
```

The alias is defined in `.zshrc`, so it exists once these files are in place.

## Bootstrap a new machine

### 1. Prerequisites

Everything `.zshrc` assumes is present. On Arch:

```sh
sudo pacman -S --needed git zsh neovim tmux starship \
                       eza bat fd fzf ripgrep zoxide mise \
                       github-cli openssh
```

`snapper` is optional — the `snaps`/`snaph` aliases are inert without it.

### 2. Authenticate to GitHub

The repo is public, but the clone below is over SSH, which needs a key on your
GitHub account regardless — and pushing changes back needs it anyway. (For a
read-only setup, clone `https://github.com/Problematic/dotfiles.git` instead and
skip this step.)

```sh
gh auth login          # choose SSH as the git protocol
ssh -T git@github.com  # accept the host key, or the clone fails non-interactively
```

That second line matters: a bare `git clone` over SSH aborts on an unknown host
key with no prompt to answer.

### 3. Clone bare

```sh
git clone --bare git@github.com:Problematic/dotfiles.git "$HOME/.cfg"
```

### 4. Check out over $HOME

The checkout **refuses to run** if any tracked file already exists — a fresh Arch
install already ships `.bashrc`, `.bash_profile`, and friends. Back them up, then
check out:

```sh
config() { git --git-dir="$HOME/.cfg/" --work-tree="$HOME" "$@"; }

BK="$HOME/dotfiles-preinstall-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BK"
config ls-tree -r --name-only HEAD | while read -r f; do
  if [ -e "$HOME/$f" ]; then
    mkdir -p "$BK/$(dirname "$f")"
    mv "$HOME/$f" "$BK/$f"
  fi
done

config sparse-checkout set --no-cone '/*' '!/README.md'
config checkout
config config status.showUntrackedFiles no
```

The `sparse-checkout` line keeps this README in the repo but out of `$HOME`. To
edit it, `config sparse-checkout disable`, commit, then re-run the `set` line.

Keep the backup until the new shell behaves — some of it may be worth merging
back.

### 5. Install the unversioned pieces

oh-my-zsh and `zsh-autosuggestions` are not vendored into this repo:

```sh
~/.local/bin/dotfiles-bootstrap
```

Then start `tmux` and `nvim` once each. tpm and lazy.nvim install their own
plugins on first launch; `lazy-lock.json` pins the versions, so run `:Lazy
restore` inside nvim to match the lockfile exactly rather than taking whatever is
newest.

### 6. Commit signing

`.gitconfig` signs every commit and tag with SSH. The key itself is not in this
repo — `.ssh/*` is deny-by-default in `.gitignore`, with no exceptions.

```sh
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_signing -C "derek@stobbe.dev (git signing)"

# authorize it for local verification
printf '%s namespaces="git" %s\n' derek@stobbe.dev \
  "$(awk '{print $1" "$2}' ~/.ssh/id_ed25519_signing.pub)" \
  >> ~/.config/git/allowed_signers

# and for the "Verified" badge on GitHub (needs admin:ssh_signing_key scope)
gh ssh-key add ~/.ssh/id_ed25519_signing.pub --type signing --title "$(hostname)"
```

Append rather than replace — old entries keep past commits verifiable.

Verify it took:

```sh
cd "$(mktemp -d)" && git init -q . && git commit -q --allow-empty -m t
git log -1 --format='%G?'   # G
```

Note `gpg.ssh.allowedSignersFile` points at `~/.config/git/allowed_signers`, not
the more commonly seen `~/.ssh/allowed_signers`. Git has no default for this
setting; the XDG location keeps `.ssh` free of tracked-file exceptions.

### 7. Toolchains

```sh
mise use -g node@lts
```

Node is managed by mise, loaded via the oh-my-zsh `mise` plugin. Do not install
the distro `nodejs`/`npm` packages alongside it. Rust is managed by `rustup`
separately, deliberately not by mise.

## Layout notes

- **Prompt** — starship, via the oh-my-zsh `starship` plugin, which unsets
  `ZSH_THEME`. Config in `.config/starship.toml`.
- **fzf** — the oh-my-zsh `fzf` plugin binds `^T` and `^[c`. `^R` is claimed by
  `zsh-navigation-tools`, so `.zshrc` rebinds it back to `fzf-history-widget`.
  `n-history` is still available as a command.
- **`zsh-interactive-cd`** binds Tab but only intercepts `cd <arg>`; everything
  else falls through to normal completion.
- **`lazy-lock.json` is tracked on purpose.** It is a lockfile. Commit it after
  `:Lazy update`, or `:Lazy restore` to discard the drift.

## Day to day

```sh
config status
config add -u
config commit -m "..."
config push
```

`config add` needs `-f` for a file under an ignored path.
