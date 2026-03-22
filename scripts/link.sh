#!/usr/bin/env bash
set -euo pipefail

REPO="${HOME}/dotfiles"

mkdir -p \
  "${HOME}/.local/share/applications" \
  "${HOME}/.config/btop/themes" \
  "${HOME}/.config/cliphist" \
  "${HOME}/.config/ghostty" \
  "${HOME}/.config/gtk-3.0" \
  "${HOME}/.config/gtk-4.0" \
  "${HOME}/.config/hypr" \
  "${HOME}/.config/keyd" \
  "${HOME}/.config/mako" \
  "${HOME}/.config/nvim" \
  "${HOME}/.config/rofi" \
  "${HOME}/.config/starship" \
  "${HOME}/.config/waybar" \
  "${HOME}/.config/waypaper"

ln -sfn "${REPO}/.zshrc" "${HOME}/.zshrc"
ln -sfn "${REPO}/.local/share/applications/nm-connection-editor.desktop" "${HOME}/.local/share/applications/nm-connection-editor.desktop"
ln -sfn "${REPO}/.local/share/applications/bssh.desktop" "${HOME}/.local/share/applications/bssh.desktop"
ln -sfn "${REPO}/.local/share/applications/bvnc.desktop" "${HOME}/.local/share/applications/bvnc.desktop"
ln -sfn "${REPO}/.local/share/applications/avahi-discover.desktop" "${HOME}/.local/share/applications/avahi-discover.desktop"
ln -sfn "${REPO}/.local/share/applications/cmake-gui.desktop" "${HOME}/.local/share/applications/cmake-gui.desktop"
ln -sfn "${REPO}/.local/share/applications/qv4l2.desktop" "${HOME}/.local/share/applications/qv4l2.desktop"
ln -sfn "${REPO}/.local/share/applications/qvidcap.desktop" "${HOME}/.local/share/applications/qvidcap.desktop"
ln -sfn "${REPO}/.local/share/applications/rofi.desktop" "${HOME}/.local/share/applications/rofi.desktop"
ln -sfn "${REPO}/.local/share/applications/rofi-theme-selector.desktop" "${HOME}/.local/share/applications/rofi-theme-selector.desktop"
ln -sfn "${REPO}/.local/share/applications/xgps.desktop" "${HOME}/.local/share/applications/xgps.desktop"
ln -sfn "${REPO}/.local/share/applications/xgpsspeed.desktop" "${HOME}/.local/share/applications/xgpsspeed.desktop"
rm -f "${HOME}/.config/btop/btop.conf"
rm -f "${HOME}/.config/btop/themes/catppuccin_mocha.theme"
ln -sfn "${REPO}/.config/btop/btop.conf" "${HOME}/.config/btop/btop.conf"
ln -sfn "${REPO}/.config/btop/themes/catppuccin_mocha.theme" "${HOME}/.config/btop/themes/catppuccin_mocha.theme"
ln -sfn "${REPO}/.config/cliphist/config" "${HOME}/.config/cliphist/config"
ln -sfn "${REPO}/.config/ghostty/config.ghostty" "${HOME}/.config/ghostty/config.ghostty"
ln -sfn "${REPO}/.config/gtk-3.0/settings.ini" "${HOME}/.config/gtk-3.0/settings.ini"
ln -sfn "${REPO}/.config/gtk-4.0/settings.ini" "${HOME}/.config/gtk-4.0/settings.ini"
ln -sfn "${REPO}/.config/hypr/hyprland.conf" "${HOME}/.config/hypr/hyprland.conf"
ln -sfn "${REPO}/.config/hypr/hyprlock.conf" "${HOME}/.config/hypr/hyprlock.conf"
ln -sfn "${REPO}/.config/hypr/clipboard-menu.sh" "${HOME}/.config/hypr/clipboard-menu.sh"
ln -sfn "${REPO}/.config/hypr/power-menu.sh" "${HOME}/.config/hypr/power-menu.sh"
ln -sfn "${REPO}/.config/hypr/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"
ln -sfn "${REPO}/.config/hypr/sync-wallpaper-state.sh" "${HOME}/.config/hypr/sync-wallpaper-state.sh"
ln -sfn "${REPO}/.config/hypr/start-clipboard.sh" "${HOME}/.config/hypr/start-clipboard.sh"
ln -sfn "${REPO}/.config/hypr/start-idle.sh" "${HOME}/.config/hypr/start-idle.sh"
ln -sfn "${REPO}/.config/hypr/start-wallpaper.sh" "${HOME}/.config/hypr/start-wallpaper.sh"
ln -sfn "${REPO}/etc/keyd/default.conf" "${HOME}/.config/keyd/default.conf"
ln -sfn "${REPO}/.config/mako/config" "${HOME}/.config/mako/config"
ln -sfn "${REPO}/.config/nvim/init.lua" "${HOME}/.config/nvim/init.lua"
rm -f "${HOME}/.config/nvim/lazy-lock.json"
ln -sfn "${REPO}/.config/nvim/lazy-lock.json" "${HOME}/.config/nvim/lazy-lock.json"
ln -sfn "${REPO}/.config/nvim/lua" "${HOME}/.config/nvim/lua"
ln -sfn "${REPO}/.config/rofi/config.rasi" "${HOME}/.config/rofi/config.rasi"
ln -sfn "${REPO}/.config/rofi/theme.rasi" "${HOME}/.config/rofi/theme.rasi"
ln -sfn "${REPO}/.config/starship/starship.toml" "${HOME}/.config/starship/starship.toml"
ln -sfn "${REPO}/.config/starship/starship.toml" "${HOME}/.config/starship.toml"
ln -sfn "${REPO}/.config/waybar/config.jsonc" "${HOME}/.config/waybar/config.jsonc"
ln -sfn "${REPO}/.config/waybar/style.css" "${HOME}/.config/waybar/style.css"
ln -sfn "${REPO}/.config/waypaper/config.ini" "${HOME}/.config/waypaper/config.ini"

echo "User symlinks refreshed."
echo "For keyd, run:"
echo "  sudo ln -sfn ${REPO}/etc/keyd/default.conf /etc/keyd/default.conf && sudo keyd reload"
