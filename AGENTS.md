# Dotfiles Guide

This repository is the source of truth for the live desktop configuration on this machine.

## Working Model

- Edit files in this repo, not in `~/.config` or `/etc`, unless you are deliberately repairing a broken symlink.
- The live paths are symlinked back to the files here.
- After changing a config, reload the relevant program if possible. Restart it if reload is unreliable.

## Repo Layout

- `./.zshrc`
- `./.local/share/applications/*.desktop`
- `./.config/btop/btop.conf`
- `./.config/btop/themes/*.theme`
- `./.config/ghostty/config.ghostty`
- `./.config/gtk-3.0/settings.ini`
- `./.config/gtk-4.0/settings.ini`
- `./.config/cliphist/config`
- `./.config/hypr/hyprland.conf`
- `./.config/hypr/hyprlock.conf`
- `./.config/hypr/clipboard-menu.sh`
- `./.config/hypr/power-menu.sh`
- `./.config/hypr/hyprpaper.conf`
- `./.config/hypr/start-clipboard.sh`
- `./.config/hypr/start-idle.sh`
- `./.config/hypr/start-wallpaper.sh`
- `./.config/nvim/init.lua`
- `./.config/nvim/lua/...`
- `./.config/rofi/config.rasi`
- `./.config/rofi/theme.rasi`
- `./.config/starship/starship.toml`
- `./.config/waybar/config.jsonc`
- `./.config/waybar/style.css`
- `./.config/waypaper/config.ini`
- `./etc/keyd/default.conf`

## Theme Rules

- Prefer a dark, minimal desktop.
- Bias toward Catppuccin Mocha surfaces, muted mauve and blue accents, and restrained contrast.
- Avoid bright borders, loud gradients, or heavy glass effects by default.
- Keep UI surfaces compact and legible.
- Use Geist and Geist Mono where possible.
- Use Nerd Font glyphs when they improve clarity, but do not replace readable text with ambiguous icons.

## Current Intent By Area

### Hyprland

- Keep the layout minimal.
- Focused borders should stay subtle and Catppuccin-toned.
- Inactive windows are intentionally translucent and blurred.
- `Super+R` should launch `rofi`.
- `Super+E` should launch `nemo`.
- `Super+L` should lock the screen with `hyprlock`.
- `Super+Y` should open the clipboard picker.
- `Super+Shift+W` should launch `waypaper`.

### Waybar

- The bar should stay clean and minimal.
- Right side order matters: grouped status, battery, then the power button at the far right.
- The tray exists primarily to host Dropbox.
- Avoid reintroducing `nm-applet` unless there is a specific reason.
- The power button and `Super+M` should launch the Rofi power menu.

### Waypaper

- Waypaper is the preferred wallpaper picker UI.
- It should use `hyprpaper` as the backend.
- `hyprpaper.conf` must keep `ipc = on` so Waypaper can talk to it.
- The default wallpaper folder should remain `/home/cte/Dropbox/Personal/Backgrounds`.
- Startup restore should use `waypaper --restore --backend hyprpaper`.
- The static `hyprpaper.conf` remains the fallback path if `waypaper` is unavailable.

### Clipboard

- `cliphist` is the clipboard history backend.
- Clipboard watching should be started from `wl-paste --watch`.
- `Super+Y` should open the Rofi picker and copy the chosen entry back to the clipboard.

### Locking And Idle

- `hyprlock` is the lock screen.
- `swayidle` is responsible for lock-on-idle and display power management.
- The current target is:
  - lock after 10 minutes
  - DPMS off after 15 minutes
  - lock before sleep

### Rofi

- Keep it single-panel and minimal.
- No left-side image pane.
- No icons in the application list.
- Keep the Catppuccin Mocha palette and the fake gradient frame.
- Hide unwanted launcher items with local desktop-entry overrides in `~/.local/share/applications`, not with brittle Rofi-side hacks.

### btop

- Keep the Catppuccin Mocha theme.
- Track custom themes in `./.config/btop/themes/`.

### Ghostty

- Keep the `Hardcore` theme unless explicitly changed.
- Preserve system clipboard behavior for both `Ctrl` and `Alt` copy/paste bindings.
- Ghostty often needs a full restart for keybind changes to apply reliably.

### Neovim

- Keep it small and personal, not a full distro.
- Use `lazy.nvim` for plugin management.
- The baseline stack is Catppuccin Mocha, Treesitter, native 0.11 LSP, `blink.cmp`, and `snacks.nvim`.
- Keep `lazy-lock.json` tracked so plugin updates are explicit.
- Prefer Arch-packaged language servers on `$PATH` over auto-install managers unless there is a clear reason otherwise.

### Starship

- Keep the prompt compact and readable.
- The current prompt uses the `hardcore` palette and is intentionally aligned with the terminal theme.
- Prefer small, information-dense prompt changes over decorative additions.

### keyd

- `Left Alt` is intentionally the Mac-like shortcut key.
- `Left Ctrl` is intentionally the fallback physical `Alt`.
- Any new shortcut work should preserve that mental model.
- Validate with `keyd check` before installing changes.

Reasoning:

- This keyboard is physically arranged more like a Windows keyboard, but the target muscle memory is Mac-like.
- The key immediately to the left of the spacebar is the key most often used for copy, paste, tab management, selection, and cursor movement on macOS.
- A full raw `Ctrl`/`Alt` swap would be too blunt and would make some Linux behaviors harder to reason about.
- The current setup instead makes `Left Alt` act like a Command-like shortcut modifier while preserving access to a real `Alt` on `Left Ctrl`.
- This keeps common shortcuts intuitive across browsers, editors, file managers, and other GUI apps without giving up Linux-specific `Alt` behavior entirely.
- Ghostty is configured separately to tolerate both `Ctrl` and `Alt` copy/paste paths because terminals are the place where generic desktop shortcut expectations and terminal-control expectations most often collide.

Basic verification after editing `keyd`:

- Run `keyd check` on the candidate config before installing it.
- Reload with `sudo keyd reload`.
- Test in a GUI app:
  - `Left Alt-C` copy
  - `Left Alt-V` paste
  - `Left Alt-T` new tab
  - `Left Alt-W` close tab/window
  - `Left Alt-Left` beginning of line
  - `Left Alt-Right` end of line
  - `Left Alt-Shift-Left` select to beginning of line
  - `Left Alt-Shift-Right` select to end of line
- Test in Ghostty after a full restart:
  - selected text + `Left Alt-C`
  - shell prompt + `Left Alt-V`
- If behavior is unclear, use `sudo keyd monitor -t` and press the physical keys from a different window.

## Reload Notes

- Hyprland: `hyprctl reload`
- Waybar: restart the process
- Ghostty: prefer full restart for keybind changes
- keyd: `sudo keyd reload`

## Safety Notes

- Do not remove the tray unless Dropbox has another StatusNotifier host.
- Be cautious with global keyboard remaps. Small changes can break core interaction quickly.
- If `keyd` becomes unusable, its panic sequence is `Backspace+Escape+Enter`.
