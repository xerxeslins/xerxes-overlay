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
	# Deixa o sistema nativo do jogo instalar tudo nos locais corretos
	# (Binário em /usr/bin e recursos em /usr/share/doomretro)
	cmake_src_install

	# Cria o ícone no menu de aplicativos do Linux
	make_desktop_entry "doomretro" "DOOM Retro" "doomretro" "Game;ActionGame;"

	einstalldocs
}
