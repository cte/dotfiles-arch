# dotfiles-arch

Personal Arch Linux desktop configuration for Hyprland, Ghostty, Neovim, Starship, Waybar, Waypaper, Rofi, Zsh, GTK, `btop`, `cliphist`, `hyprlock`, `swayidle`, and `keyd`.

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

## Wallpaper Flow

Wallpaper selection uses `waypaper` as the browser/picker UI and `hyprpaper` as the actual wallpaper daemon.

- `waypaper` is configured with `backend = hyprpaper`
- selecting a wallpaper talks directly to `hyprpaper`
- startup restore uses `waypaper --restore --backend hyprpaper`
- `hyprpaper.conf` must include `ipc = on`
- `hyprpaper.conf` remains the fallback path if `waypaper` is unavailable

## Clipboard History

- `cliphist` stores clipboard history
- `wl-paste --watch cliphist store` is used to feed it
- `Super+Y` opens a Rofi-based clipboard picker

## Locking And Idle

- `Super+L` launches `hyprlock`
- `swayidle` autostarts and currently:
  - locks after 10 minutes
  - turns displays off after 15 minutes
  - locks before sleep

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
- Text field: `Left Alt-Left`, `Left Alt-Right`
- Selection: `Left Alt-Shift-Left`, `Left Alt-Shift-Right`
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
