# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop xdg

DESCRIPTION="A refined, classic DOOM source port for Windows and Linux"
HOMEPAGE="https://www.doomretro.com/"
SRC_URI="https://github.com/bradharding/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	media-libs/libsdl2[sound,video,opengl]
	media-libs/sdl2-image[png,jpeg]
	media-libs/sdl2-mixer[midi,mp3,vorbis,wav]
"
RDEPEND="${DEPEND}"

src_install() {
	exeinto /usr/libexec
	newexe "${BUILD_DIR}/${PN}" doomretro-bin

	insinto /usr/share/doom
	doins "${BUILD_DIR}/${PN}.wad"

	cat << 'WRAPPER' > "${T}/doomretro"
#!/bin/sh
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/doomretro"
SAVE_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/doomretro/savegames"

mkdir -p "$CONFIG_DIR"
mkdir -p "$SAVE_DIR"

exec /usr/libexec/doomretro-bin \
	-iwad /usr/share/doom/doomretro.wad \
	-config "$CONFIG_DIR/doomretro.cfg" \
	-savedir "$SAVE_DIR" \
	"$@"
WRAPPER

	dobin "${T}/doomretro"
	make_desktop_entry "doomretro" "DOOM Retro" "doomretro" "Game;ActionGame;"
	einstalldocs
}
