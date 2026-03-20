#!/usr/bin/env bash
set -euo pipefail

REPO="${HOME}/dotfiles"

mkdir -p \
  "${HOME}/.config/ghostty" \
  "${HOME}/.config/gtk-3.0" \
  "${HOME}/.config/gtk-4.0" \
  "${HOME}/.config/hypr" \
  "${HOME}/.config/keyd" \
  "${HOME}/.config/rofi" \
  "${HOME}/.config/starship" \
  "${HOME}/.config/waybar" \
  "${HOME}/.config/waypaper" \
  "${HOME}/.config/wlogout"

ln -sfn "${REPO}/.zshrc" "${HOME}/.zshrc"
ln -sfn "${REPO}/.config/ghostty/config.ghostty" "${HOME}/.config/ghostty/config.ghostty"
ln -sfn "${REPO}/.config/gtk-3.0/settings.ini" "${HOME}/.config/gtk-3.0/settings.ini"
ln -sfn "${REPO}/.config/gtk-4.0/settings.ini" "${HOME}/.config/gtk-4.0/settings.ini"
ln -sfn "${REPO}/.config/hypr/hyprland.conf" "${HOME}/.config/hypr/hyprland.conf"
ln -sfn "${REPO}/.config/hypr/hyprpaper.conf" "${HOME}/.config/hypr/hyprpaper.conf"
ln -sfn "${REPO}/.config/hypr/start-wallpaper.sh" "${HOME}/.config/hypr/start-wallpaper.sh"
ln -sfn "${REPO}/etc/keyd/default.conf" "${HOME}/.config/keyd/default.conf"
ln -sfn "${REPO}/.config/rofi/config.rasi" "${HOME}/.config/rofi/config.rasi"
ln -sfn "${REPO}/.config/rofi/theme.rasi" "${HOME}/.config/rofi/theme.rasi"
ln -sfn "${REPO}/.config/starship/starship.toml" "${HOME}/.config/starship/starship.toml"
ln -sfn "${REPO}/.config/starship/starship.toml" "${HOME}/.config/starship.toml"
ln -sfn "${REPO}/.config/waybar/config.jsonc" "${HOME}/.config/waybar/config.jsonc"
ln -sfn "${REPO}/.config/waybar/style.css" "${HOME}/.config/waybar/style.css"
ln -sfn "${REPO}/.config/waypaper/config.ini" "${HOME}/.config/waypaper/config.ini"
ln -sfn "${REPO}/.config/wlogout/layout" "${HOME}/.config/wlogout/layout"
ln -sfn "${REPO}/.config/wlogout/style.css" "${HOME}/.config/wlogout/style.css"

echo "User symlinks refreshed."
echo "For keyd, run:"
echo "  sudo ln -sfn ${REPO}/etc/keyd/default.conf /etc/keyd/default.conf && sudo keyd reload"
