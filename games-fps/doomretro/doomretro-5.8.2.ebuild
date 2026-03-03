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
        # 1. Instala o binário real em libexec (executável oculto)
        exeinto /usr/libexec
        newexe "${BUILD_DIR}/${PN}" "${PN}-bin"

        # 2. Instala o WAD obrigatório em /usr/share
        insinto /usr/share/doom
        doins "${BUILD_DIR}/${PN}.wad"

        # 3. Cria o link simbólico usando EAPI 8 (-r calcula o caminho relativo automático)
        dosym -r /usr/share/doom/${PN}.wad /usr/libexec/${PN}.wad

        # 4. Gera o script wrapper dinamicamente durante a instalação
        cat << 'EOF' > "${T}/doomretro"
#!/bin/bash
# Define e cria o diretório de configuração do usuário logado
CFG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/doomretro"
mkdir -p "$CFG_DIR"

# Executa o binário real repassando o config e quaisquer outros argumentos ($@)
exec /usr/libexec/doomretro-bin -config "$CFG_DIR/doomretro.cfg" "$@"
EOF

        # 5. Instala o script wrapper no PATH do sistema
        dobin "${T}/doomretro"

        # 6. Criação do atalho no menu
        make_desktop_entry "${PN}" "DOOM Retro" "doomretro" "Game;ActionGame;"

        einstalldocs
}
