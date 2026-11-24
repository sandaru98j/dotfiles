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
