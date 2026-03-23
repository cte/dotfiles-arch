# dotfiles-arch

Personal Arch Linux desktop configuration for Hyprland, Ghostty, Neovim, Starship, Waybar, Waypaper, Rofi, Zsh, GTK, VS Code, `btop`, `cliphist`, `hypridle`, `hyprlock`, `snappy-switcher`, `satty`, and `keyd`.

This repo is Arch-specific. It reflects the package names, filesystem layout, and desktop tooling used on the live Arch machine it configures.

The repo is structured to mirror the live filesystem paths so the active machine can use symlinks directly.

Launcher cleanup is handled with local desktop-entry overrides in `~/.local/share/applications/` so unwanted system apps can be hidden from Rofi without modifying the system package files.

## btop

- theme: Catppuccin Mocha
- config path: `~/.config/btop/btop.conf`
- custom themes live in `~/.config/btop/themes/`

## Neovim

Neovim is configured as a small personal setup, not a full distribution.

- plugin manager: `lazy.nvim`
- theme: Catppuccin Mocha
- editor stack: Treesitter, native LSP, `blink.cmp`, `snacks.nvim`
- language servers are expected to come from normal packages on `$PATH`
- plugin versions are pinned in `lazy-lock.json`

## VS Code

- settings path: `~/.config/Code/User/settings.json`
- editor font: `NotoSansM Nerd Font Mono`
- theme: `Catppuccin Frappé`
- icon theme: `catppuccin-frappe`
- Catppuccin italics are disabled via the theme's own settings

## Wallpaper Flow

Wallpaper selection uses `waypaper` as the browser/picker UI and `hyprpaper` as the actual wallpaper daemon.

- `waypaper` is configured with `backend = hyprpaper`
- selecting a wallpaper talks directly to `hyprpaper`
- `waypaper` runs a `post_command` that immediately syncs the chosen wallpaper into both `hyprpaper.conf` and `hyprlock.conf`
- startup uses `hyprpaper` directly from the synced `hyprpaper.conf`, not `waypaper --restore`
- `hyprpaper.conf` must include `ipc = on`
- the live wallpaper chooser is the source of truth, and the repo-managed configs are updated to match it

## Icons And GTK

- GTK icon theme: `Papirus-Dark`
- `Papirus-Dark` is set in both GTK config files and in live GNOME/Cinnamon desktop settings
- Rofi icons are enabled and use `Papirus-Dark`
- `snappy-switcher` is configured to use `Papirus-Dark`
- Reversal was tried and removed; do not reinstall it unless there is a specific reason

## Waybar

- full-width top bar, not floating pills
- center clock uses `Geist`
- right side order is: network, volume, tray, power profile, battery, power
- `custom/power-profile` is the power mode control
- click the profile icon to choose `performance`, `balanced`, or `power-saver`
- scroll the profile icon to cycle modes
- battery is icon-only and uses color for warning / critical / charging states
- power opens the Rofi power menu

## Clipboard History

- `cliphist` stores clipboard history
- `wl-paste --watch cliphist store` is used to feed it
- `Super+Y` opens a Rofi-based clipboard picker

## Window Switching

- `snappy-switcher` is the active Alt-Tab replacement
- the live setup is intentionally patched to use `Ctrl` release instead of upstream `Alt` release
- Hyprland binds are:
  - `Ctrl+Tab` -> next
  - `Ctrl+Shift+Tab` -> previous
- the patch is stored at `patches/snappy-switcher-ctrl-release.patch`
- the packaged wrapper expects `/usr/local/bin/snappy-switcher`, so Hyprland starts it with:
  - `env SNAPPY_BINARY=/usr/bin/snappy-switcher snappy-wrapper`
- an AUR reinstall or upgrade will overwrite the local binary patch, so reapply the stored patch when updating the package

Reapply flow after an upgrade:

```bash
yay -G snappy-switcher
cd snappy-switcher
patch -p1 < ~/dotfiles/patches/snappy-switcher-ctrl-release.patch
makepkg -si
```

## Locking And Idle

- `Super+L` launches `hyprlock`
- `hypridle` autostarts and currently:
  - locks after 10 minutes
  - turns displays off after 15 minutes
  - locks before sleep
- `hyprlock` uses native fingerprint auth
- the lockscreen is a bottom-anchored centered stack with:
  - time
  - date
  - input field
  - fingerprint prompt
- `hyprlock` wallpaper is kept in sync with the main Hyprland wallpaper

## Screenshots

- `Print` uses `slurp + grim + satty`
- drag a region with `slurp`
- annotate or save in `satty`
- screenshots are saved under `~/Pictures/Screenshots/`

## Keyboard Mapping Rationale

The keyboard remapping is intentional and is meant to approximate Mac-style shortcut ergonomics on a Linux laptop with a more Windows-like physical layout.

- `Left Alt` is used as the primary shortcut key because it sits immediately to the left of the spacebar, which is where `Cmd` muscle memory expects to live.
- `Left Ctrl` is repurposed as the fallback physical `Alt` so Linux and application-specific `Alt` shortcuts are still available.
- The goal is not a naive modifier swap. The goal is to preserve Mac-like copy/paste, tab, and selection ergonomics while still keeping Linux usable.
- Terminal behavior is handled separately in Ghostty because terminal shortcuts and GUI shortcuts have different expectations.

## Keyboard Mapping Verification

After changing `keyd`:

```bash
keyd check ~/.config/keyd/default.conf
sudo keyd reload
```

Then verify:

- GUI app: `Left Alt-C`, `Left Alt-V`, `Left Alt-T`, `Left Alt-W`
- Text field: `Left Alt-Left`, `Left Alt-Right`, `Left Alt-Up`, `Left Alt-Down`
- Selection: `Left Alt-Shift-Left`, `Left Alt-Shift-Right`, `Left Alt-Shift-Up`, `Left Alt-Shift-Down`
- Ghostty after full restart: selected text + `Left Alt-C`, prompt + `Left Alt-V`

For raw event debugging:

```bash
sudo keyd monitor -t
```

## Relink

Run:

```bash
./scripts/link.sh
```

This will recreate the user-level symlinks on the target Arch system. The `keyd` system symlink still requires `sudo`.
