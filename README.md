# Void Dotfiles
⚠️ **CAUTION**: Some commands may not work properly when used in a different
distribution, since Void Linux uses [runit][3] as its init system instead of 
systemd — the default init system for distributions like Debian or Arch Linux.

## Table of contents

- Usefull scripts in `~/.local/bin`
- [Hyprland config](.config/hypr/) <small>([xbps-src template](https://github.com/Makrennel/hyprland-void))</small>
- Shell configs
	- [Zsh](.zshrc) / [Starship](.config/starship.toml)
- [Alacritty config](.config/alacritty.yml)  
*... and more*

## Preferred utilities

- **Window Manager**: Hyprland
- **Terminal emulator**: Alacritty
- **Look and feel**:  *(configured with the [nwg-look][1] utility)*
    - **GTK theme**: Nordic
    - **Icon theme**: Vimix dark
    - **Mouse cursor**: Breeze Snow
- **Application launcher**: [bemenu][2]
- **File manager**: Thunar
- **Browser**: Librewolf

[1]: https://github.com/nwg-piotr/nwg-look
[2]: https://github.com/Cloudef/bemenu
[3]: https://docs.voidlinux.org/config/services/index.html
