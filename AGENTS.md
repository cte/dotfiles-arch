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
- `./.config/Code/User/settings.json`
- `./.config/ghostty/config.ghostty`
- `./.config/gtk-3.0/settings.ini`
- `./.config/gtk-4.0/settings.ini`
- `./.config/cliphist/config`
- `./.config/hypr/hyprland.conf`
- `./.config/hypr/hypridle.conf`
- `./.config/hypr/hyprlock.conf`
- `./.config/hypr/mocha.conf`
- `./.config/hypr/clipboard-menu.sh`
- `./.config/hypr/power-menu.sh`
- `./.config/hypr/hyprpaper.conf`
- `./.config/hypr/start-clipboard.sh`
- `./.config/hypr/sync-wallpaper-state.sh`
- `./.config/hypr/start-wallpaper.sh`
- `./.config/nvim/init.lua`
- `./.config/nvim/lua/...`
- `./.config/rofi/config.rasi`
- `./.config/rofi/theme.rasi`
- `./.config/snappy-switcher/config.ini`
- `./.config/starship/starship.toml`
- `./.config/waybar/config.jsonc`
- `./.config/waybar/power-profile-*.sh`
- `./.config/waybar/power-segment.sh`
- `./.config/waybar/style.css`
- `./.config/waypaper/config.ini`
- `./etc/keyd/default.conf`
- `./patches/snappy-switcher-ctrl-release.patch`

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
- `Super+Space` should launch `rofi`.
- `Super+E` should launch `nemo`.
- `Super+L` should lock the screen with `hyprlock`.
- `Super+Y` should open the clipboard picker.
- `Super+Shift+W` should launch `waypaper`.
- `Print` should use the `slurp + grim + satty` flow.
- `Ctrl+Tab` and `Ctrl+Shift+Tab` should drive `snappy-switcher`.

### Waybar

- The bar should stay clean and minimal.
- It should remain a full-width translucent top bar, not separate floating pills.
- Right side order matters: network, volume, tray, power profile, battery, then the power button at the far right.
- The tray exists primarily to host Dropbox.
- Avoid reintroducing `nm-applet` unless there is a specific reason.
- Keep the dedicated power profile control icon-first and compact.
- The profile control should remain the place to switch between `performance`, `balanced`, and `power-saver`.
- Battery is icon-only and should communicate state through icon choice and color, not percentage text.
- The power button and `Super+M` should launch the Rofi power menu.
- The center clock should stay on `Geist`, not the general monospace bar font.

### Waypaper

- Waypaper is the preferred wallpaper picker UI.
- It should use `hyprpaper` as the backend.
- `hyprpaper.conf` must keep `ipc = on` so Waypaper can talk to it.
- The default wallpaper folder should remain `/home/cte/Dropbox/Personal/Backgrounds`.
- Waypaper should immediately sync the selected wallpaper back into both `hyprpaper.conf` and `hyprlock.conf` via the repo-managed `post_command`.
- Startup should use `hyprpaper` directly from the synced `hyprpaper.conf`, not `waypaper --restore`.
- The sync helper must resolve symlink targets instead of replacing live symlinks with regular files.
- The static `hyprpaper.conf` remains the startup source of truth and fallback path if `waypaper` is unavailable.

### Icons

- `Papirus-Dark` is the active icon theme.
- It should be applied consistently across:
  - GTK
  - Nemo
  - Rofi
  - `snappy-switcher`
- Reversal was removed after poor GTK/Nemo coverage and a broken upstream `-b` install path.

### Clipboard

- `cliphist` is the clipboard history backend.
- Clipboard watching should be started from `wl-paste --watch`.
- `Super+Y` should open the Rofi picker and copy the chosen entry back to the clipboard.

### Locking And Idle

- `hyprlock` is the lock screen.
- `hypridle` is responsible for lock-on-idle and display power management.
- `hyprlock` should stay on the bottom-anchored centered-stack layout.
- The lockscreen stack should remain simple:
  - time
  - date
  - input field
  - fingerprint prompt
- Avoid ad hoc helper labels and top-right/center-anchor mixing. That made the config fragile and caused real breakage earlier.
- The current target is:
  - lock after 10 minutes
  - DPMS off after 15 minutes
  - lock before sleep

### Snappy Switcher

- `snappy-switcher` is the active window switcher.
- The live setup is intentionally patched so release-to-select is tied to `Ctrl`, not upstream `Alt`.
- It should use the `Papirus-Dark` icon theme.
- Keep the patch in `./patches/snappy-switcher-ctrl-release.patch`.
- Hyprland must start the wrapper with `SNAPPY_BINARY=/usr/bin/snappy-switcher` because the packaged wrapper defaults to `/usr/local/bin/snappy-switcher`.
- If the package is upgraded or reinstalled, assume the local binary patch is gone and needs to be reapplied.
- Reapply with:
  - `yay -G snappy-switcher`
  - `cd snappy-switcher`
  - `patch -p1 < ~/dotfiles/patches/snappy-switcher-ctrl-release.patch`
  - `makepkg -si`

### Rofi

- Keep it single-panel and minimal.
- No left-side image pane.
- Icons are enabled and should use `Papirus-Dark`.
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
  - `Left Alt-Up` top of document
  - `Left Alt-Down` bottom of document
  - `Left Alt-Shift-Left` select to beginning of line
  - `Left Alt-Shift-Right` select to end of line
  - `Left Alt-Shift-Up` select to top of document
  - `Left Alt-Shift-Down` select to bottom of document
- Test in Ghostty after a full restart:
  - selected text + `Left Alt-C`
  - shell prompt + `Left Alt-V`
- If behavior is unclear, use `sudo keyd monitor -t` and press the physical keys from a different window.

### VS Code

- Keep user settings tracked in `./.config/Code/User/settings.json`.
- The current font is `NotoSansM Nerd Font Mono`.
- Catppuccin Frappé is the current theme and its italics should be disabled through the theme's own settings, not broad token overrides.

## Reload Notes

- Hyprland: `hyprctl reload`
- Waybar: restart the process
- Ghostty: prefer full restart for keybind changes
- keyd: `sudo keyd reload`
- snappy-switcher: `exec-once` does not rerun on `hyprctl reload`; restart the daemon manually or relog if needed

## Safety Notes

- Do not remove the tray unless Dropbox has another StatusNotifier host.
- Be cautious with global keyboard remaps. Small changes can break core interaction quickly.
- If `keyd` becomes unusable, its panic sequence is `Backspace+Escape+Enter`.
- A future `snappy-switcher` package upgrade will overwrite the local `Ctrl+Tab` binary patch unless it is rebuilt with `./patches/snappy-switcher-ctrl-release.patch`.
