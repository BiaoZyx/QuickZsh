# Alpine-Sway-Dotfiles
## Introduction
### What is it?
This repo contains the dotfiles for my Sway setup on Alpine Linux. It is kept simple and easy to read, and it also includes some helpers for setting up Alpine. I hope it can help you too.

It is best used on Alpine Linux, but you can fork it and adapt it to other distros.

### Why is there no `setup.sh`?
There is no `setup.sh` because I am worried that it might overwrite your existing configs. So you should back up the configs you already have, and then copy the ones in this repo to your system yourself.

### Screenshots
> Normal mode with a foot terminal
> [!image](./screenshot1.png)

> Privacy Indicator
> [!image](./screenshot2.png)

## Requirements
### Core packages
#### System
1.  `bash`
2.  `cmd:env`
3.  `cmd:dbus-launch`
4.  `dbus`
5.  `dbus-x11`
6.  `cmd:seatd-launch`
7.  `seatd`
8.  `doas` (Optional: `doas-sudo-shim`)
9.  `elogind`
10. `udisks2`
11. `polkit-elogind`

#### Audio
1.  `alsa-utils`
2.  `pipewire`
3.  `pipewire-alsa`
4.  `pipewire-pulse`
5.  `pipewire-tools`
6.  `pulseaudio-utils`
7.  `wireplumber`
8.  `wireplumber-lang`
9.  `wireplumber-libs`
10. `wireplumber-logind`
11. `wayland-pipewire-idle-inhibit`

> Optional:
>   - pavucontrol
>   - pavucontrol-lang

#### Desktop
1.  `sway`
2.  `swaybg`
3.  `swayidle`
4.  `swaylock-effects`
5.  `swaylockd`
6.  `waybar`
7.  `xwayland`
8.  `wl-clipboard`
9.  `cliphist`
10. `fnott`
11. `rofi` or `fuzzel` *\(Fuzzel is the default. Change the default in `~/.config/waybar/config` and `~/.config/sway/config.d/keybindings.sway`\)*
12. `grimshot`
13. `foot`

#### Font
1. `font-noto`
2. `font-noto-cjk`
3. `font-noto-emoji`
4. `font-noto-music`
5. `font-jetbrains-mono-nerd`

## Installation
First, I recommend running `su -c 'setup-desktop sway'`, which will install some packages like `sway` and `swaybg` automatically.

Then install the packages above and copy the configs in `user-home/.config/`:
```sh
# Make sure you're in the repo path
mkdir -p ~/.config && cp ./user-home/.config/{sway,swaylock,waybar,fuzzel,fnott,foot} ~/.config/
```
