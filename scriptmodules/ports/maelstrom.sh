#!/usr/bin/envbash

#This file is part of RetroPie-Extra, a supplement to RetroPie.
#For more information, please visit:
#
#https://github.com/RetroPie/RetroPie-Setup
#https://github.com/Exarkuniv/RetroPie-Extra
#
#See the LICENSE file distributed with this source and at
#https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#

rp_module_id="maelstrom"
rp_module_desc="Maelstrom- Classic Mac Asteroids Remake"
rp_module_licence="GPL2https://www.gnu.org/licenses/gpl-2.0.txt"
rp_module_section="exp"
rp_module_flags="!x86!mali"

functiondepends_maelstrom() {
   getDepends libsdl1.2-dev libsdl-net1.2-dev
}

functionsources_maelstrom() {
   wget https://www.libsdl.org/projects/Maelstrom/src/Maelstrom-3.0.6.tar.gz
   tar zxvf Maelstrom-3.0.6.tar.gz
}

functionbuild_maelstrom() {
   cd Maelstrom-3.0.6
   ./autogen.sh
   ./configure
   automake --add-missing
   make
   md_ret_require="$md_build/Maelstrom-3.0.6/Maelstrom"
}

functioninstall_maelstrom() {
   md_ret_files=(
      'Maelstrom-3.0.6/Images'
      'Maelstrom-3.0.6/Docs'
      'Maelstrom-3.0.6/Maelstrom_Fonts'
      'Maelstrom-3.0.6/Maelstrom_Sprites'
      'Maelstrom-3.0.6/Maelstrom_Sounds'
      'Maelstrom-3.0.6/Maelstrom-Scores'
      'Maelstrom-3.0.6/Maelstrom'
      'Maelstrom-3.0.6/icon.bmp'
   )
}

functionconfigure_maelstrom() {
   mkRomDir "ports"
   moveConfigFile "$home/.Maelstrom-data" "$md_conf_root/$md_id"
   addPort "$md_id" "maelstrom" "Maelstrom - Classic Mac Asteroids Remake" "pushd $md_inst; ./Maelstrom; popd" 
}
