# Dotfiles

Personal Linux / Hyprland dotfiles managed with **Git** and **GNU Stow** (`--no-folding`).

## Layout

Each top-level directory is a Stow package mirroring `$HOME`:

| Package | Target files |
|---|---|
| `btop` | `~/.config/btop/btop.conf` |
| `fuzzel` | `~/.config/fuzzel/fuzzel.ini`, `~/.config/fuzzel/themes/` |
| `git` | `~/.config/git/config` |
| `gtk` | `~/.config/gtk-3.0/{settings.ini,gtk.css,themes/}`, `~/.config/gtk-4.0/{settings.ini,gtk.css,themes/}` |
| `hypr` | `~/.config/hypr/{hyprland.lua,hyprlock.conf,hypridle.conf}`, `~/.config/hypr/themes/` |
| `foot` | `~/.config/foot/foot.ini`, `~/.config/foot/themes/` |
| `mako` | `~/.config/mako/themes/` |
| `mpv` | `~/.config/mpv/mpv.conf` |
| `newsboat` | `~/.config/newsboat/{config,urls}` |
| `nnn` | `~/.config/nnn/plugins/{nuke,cmusq,imgview}` |
| `scripts` | `~/.local/bin/{theme-switch,shot,powermenu,clipmenu,nightlight,waybar-media,waybar-news}` |
| `thunar` | `~/.config/Thunar/uca.xml` |
| `vim` | `~/.config/vim/vimrc` |
| `waybar` | `~/.config/waybar/{config.jsonc,style.css}`, `~/.config/waybar/themes/` |
| `xdg` | `~/.config/environment.d/10-xdg.conf` |
| `zathura` | `~/.config/zathura/zathurarc`, `~/.config/zathura/themes/` |
| `zsh` | `~/.zprofile`, `~/.zshrc` |

## Usage

Install GNU Stow (if not already installed):

```bash
sudo pacman -S stow
```

Apply / restow all packages:

```bash
~/dotfiles/stow-all.sh
```

Or manage individual packages from inside `~/dotfiles` (reads `.stowrc` automatically):

```bash
cd ~/dotfiles
stow -R hypr       # restow a single package
stow -D newsboat   # unstow a package
```

## Notes

- **Why `--no-folding`?** Your `~/.local/bin/theme-switch` script dynamically writes active theme symlinks (`hypr/theme.lua`, `hypr/hyprlock-theme.conf`, `hypr/hyprpaper.conf`, `waybar/colors.css`, `foot/theme.ini`, `fuzzel/theme.ini`, `mako/config`, `zathura/theme`). Using `--no-folding` keeps those directories real so switching themes never dirties this Git repository.
- **Intentionally excluded:** Secrets, credentials, caches, and runtime state (`~/.gemini`, `~/.local/share/gnupg`, `~/.config/antigravity`, `~/.config/pulse`, `~/.config/mozilla`, `~/.config/dconf`, `~/.config/theme-switch/current`, `~/.config/Thunar`, `~/.config/xfce4`).
