# XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Keep tool state/data out of $HOME
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export VIMINIT="set viminfofile=$XDG_STATE_HOME/vim/viminfo"

# Zsh history in XDG_STATE_HOME
HISTFILE="$XDG_STATE_HOME/zsh/history"
[[ -d "${HISTFILE:h}" ]] || mkdir -p -m 700 "${HISTFILE:h}"
HISTSIZE=5000
SAVEHIST=5000

export PATH="$HOME/.local/bin:$PATH"

# =============================================================================
# Minimal Zsh Completions (Zero-bloat, Nord / Dracula themed)
# =============================================================================
zmodload -i zsh/complist
zmodload -i zsh/terminfo

# Populate LS_COLORS for colorized file completions
if [[ -z "$LS_COLORS" ]] && (( $+commands[dircolors] )); then
  eval "$(dircolors -b)"
fi

# Completion behavior
unsetopt menu_complete   # do not autoselect the first entry
unsetopt flowcontrol     # disable Ctrl-S / Ctrl-Q flow control
setopt auto_menu         # show menu on successive Tab press
setopt complete_in_word  # complete from both ends of a word
setopt always_to_end     # move cursor to end of completed word

# Keep completion dump and cache in XDG_CACHE_HOME
ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
[[ -d "$ZSH_CACHE_DIR" ]] || mkdir -p -m 700 "$ZSH_CACHE_DIR"

autoload -Uz compinit && compinit -d "$ZSH_CACHE_DIR/zcompdump-$ZSH_VERSION"

# Match active theme-switch palette (Nord blue #88C0D0 or Dracula purple #BD93F9)
_zsh_theme="nord"
[[ -r "$XDG_CONFIG_HOME/theme-switch/current" ]] && _zsh_theme="$(<"$XDG_CONFIG_HOME/theme-switch/current")"
if [[ "$_zsh_theme" == "dracula" ]]; then
  _menu_hl='ma=1;38;2;40;42;54;48;2;189;147;249'   # Dracula: #282A36 on #BD93F9
else
  _menu_hl='ma=1;38;2;46;52;64;48;2;136;192;208'   # Nord:    #2E3440 on #88C0D0
fi
unset _zsh_theme

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" "$_menu_hl"
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:descriptions' format '%F{cyan}--- %d ---%f'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$ZSH_CACHE_DIR/zcompcache"
unset _menu_hl

# Vim-style navigation (hjkl) + Tab / Shift-Tab inside completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect '^I' menu-complete
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete
fi

# =============================================================================
# nnn File Manager (imv, mpv, zathura, cmus)
# =============================================================================
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"
export TERMINAL="${TERMINAL:-footclient}"
export PAGER="${PAGER:-less -R}"

export NNN_OPENER="$XDG_CONFIG_HOME/nnn/plugins/nuke"
export NNN_OPTS="cdH"
export NNN_PLUG='c:cmusq;i:imgview'

# Quit-cd wrapper for nnn (use `n` to launch and cd on quit)
n() {
  if [ "${NNNLVL:-0}" -ge 1 ]; then
    echo "nnn is already running"
    return
  fi

  export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
  command nnn "$@"

  if [ -f "$NNN_TMPFILE" ]; then
    . "$NNN_TMPFILE"
    rm -f -- "$NNN_TMPFILE" > /dev/null
  fi
}

# Minimal, snappy prompt (zero git-status latency)
PS1='%F{cyan}%n%f@%F{blue}%m%f %F{magenta}%~%f %F{white}%#%f '
