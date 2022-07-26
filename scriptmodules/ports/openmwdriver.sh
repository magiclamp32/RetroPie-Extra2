#!/usr/bin/env bash

# This file is part of RetroPie-Extra, a supplement to RetroPie.
# For more information, please visit:
#
# https://github.com/RetroPie/RetroPie-Setup
# https://github.com/Exarkuniv/RetroPie-Extra
#
# See the LICENSE file distributed with this source and at
# https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/LICENSE
#

rp_module_id="openmwdriver"
rp_module_desc="The OpenSceneGraph is an open source high performance 3D graphics toolkit. Needed for OpenMW"
rp_module_licence="GPL3 https://github.com/OpenMW/osg/blob/3.4/LICENSE.txt"
rp_module_section="driver"
rp_module_flags="!all rpi"

function sources_openmwdriver() {
   gitPullOrClone "$md_build" https://github.com/OpenMW/osg.git
}

function build_openmwdriver() {
	cd "$md_build"
   	cmake . -DBUILD_OSG_PLUGINS_BY_DEFAULT=0 -DBUILD_OSG_PLUGIN_OSG=1 -DBUILD_OSG_PLUGIN_DDS=1 -DBUILD_OSG_PLUGIN_TGA=1 -DBUILD_OSG_PLUGIN_BMP=1 -DBUILD_OSG_PLUGIN_JPEG=1 -DBUILD_OSG_PLUGIN_PNG=1 -DBUILD_OSG_PLUGIN_FREETYPE=1 -DBUILD_OSG_DEPRECATED_SERIALIZERS=0 -DOPENGL_PROFILE=GL2 -DOSG_GLES1_AVAILABLE=FALSE -DOSG_GLES2_AVAILABLE=FALSE -DOSG_GLES3_AVAILABLE=FALSE    
	make

}

function install_openmwdriver() {
    cd "$md_build"
    sudo make install
}
