### Gentoo Linux

DOOM Retro is available for Gentoo Linux via the [xerxes-overlay](https://github.com/xerxeslins/xerxes-overlay) repository.

#### Prerequisites (Keywords & USE flags)

```bash
mkdir -p /etc/portage/package.accept_keywords /etc/portage/package.use

cat << 'EOF' > /etc/portage/package.accept_keywords/doomretro
games-fps/doomretro ~amd64
EOF

cat << 'EOF' > /etc/portage/package.use/doomretro
media-libs/libsdl2 opengl
media-libs/sdl2-image png jpeg
media-libs/sdl2-mixer stb mod vorbis flac mp3 modplug midi timidity
media-libs/libglvnd X
EOF

```

#### Latest Release

```bash
eselect repository enable xerxes-overlay
emaint sync -r xerxes-overlay
emerge --ask --verbose games-fps/doomretro

```

#### Live version (latest git commit)

```bash
echo "=games-fps/doomretro-9999 **" >> /etc/portage/package.accept_keywords/doomretro
emerge --ask --verbose =games-fps/doomretro-9999

```
