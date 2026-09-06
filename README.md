# Alpine-Sway-Dotfiles

Sway window manager dotfiles for Alpine Linux — kept simple and readable, with a few helpers for getting Alpine set up.

## Introduction

This is a minimal, tweakable Sway setup for Alpine Linux. It favors clarity over cleverness, so you can read each config and adjust it to fit your own workflow. Alongside the configs there are some helper notes for setting things up on Alpine.

It's written for Alpine Linux, but it's portable — fork it and adapt it to any other distro.

> There's intentionally no `setup.sh`. Automating the copy would risk clobbering configs you already have. Instead, back up your existing configs and copy the ones here over yourself.

### Screenshots

Normal mode with a foot terminal:

![Normal mode with a foot terminal](./screenshot1.png)

Privacy indicator (mic/camera in use):

![Privacy Indicator](./screenshot2.png)

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
