```markdown
### Gentoo Linux

DOOM Retro is available for Gentoo Linux via the [xerxes-overlay](https://github.com/xerxeslins/xerxes-overlay) repository.

**Prerequisites (Dependencies & Keywords):**

```bash
mkdir -p /etc/portage/package.accept_keywords /etc/portage/package.use
echo "games-fps/doomretro ~amd64" >> /etc/portage/package.accept_keywords/doomretro
echo "media-libs/sdl2-mixer fluidsynth midi mp3 vorbis wav" >> /etc/portage/package.use/sdl2-mixer

```

**Latest Release:**

```bash
eselect repository enable xerxes-overlay
emaint sync -r xerxes-overlay
emerge games-fps/doomretro

```

**Live version (latest git commit):**

```bash
echo "=games-fps/doomretro-9999 **" >> /etc/portage/package.accept_keywords/doomretro
emerge =games-fps/doomretro-9999

```
