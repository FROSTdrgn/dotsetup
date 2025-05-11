## Install

### Required Setup

Install CatchyOS via USB in a configuration with GNOME desktop, systemd-boot with 5GiB boot partition in FAT32 and any other partitions (/, /home, etc) as btrfs.

Be warned, SSD is nearly mandatory for modern installs.

> **IMPORTANT** it's highly recommended to you press META key (WinKey) > Software and install an application called "Resources". The reason why this is so important is that with out having it open you won't be able to tell if the system is slow or something is simply abusing the living hell out of your hardware.
>
> For example if you have your system installed on a regular HDD instead of a SSD expect the experience to be horendous if something abuses it for a few seconds. Unfortunately tools like `btop` and similar don't actually show this properly so you're left to wonder why everything is slow with CPU, Mem, GPU doing nothing. You can install `iotop` to find what program is actually using the HDD so intensily as if it's RAM.
>
> If your experience in the USB installer OS is significantly better, same reason, the OS there installs to RAM so it doesn't have this hidden HDD penalty.

> **Note on Package Types**: `extra` vs `aur` vs `catchyos-v3` is basically default packages, user maintained packages (aur = arch user repos) and cachy optimized packages. You always want the cachy optimized packages which are always the default option.

When inside GNOME in the CachyOS Hello
 - go to Apps and Tweaks
   - then Rank Mirrors = this optimizes downloads
   - then Install Gaming packages = this installs anything related to gaming

If you closed the cachyos hello app just call it back by typing `cachyos-hello` in the terminal or `hello` in the launcher.

### Configuration

```
git clone https://github.com/FROSTdrgn/dotsetup ~/.setup
cd ~/.setup
make install
```

This will setup basics. You can then easily grab your dotfiles or other resources.
