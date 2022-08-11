
# RetroPie-Extra
**Under New Management**

This is a **collection of unofficial installation scripts for RetroPie** allowing you to quickly and easily **install emulators, ports and libretrocores** that haven't been included in RetroPie for one reason or another. These scripts can be considered experimental at best. 
I have found new scripts made by other people and added them to this Repo. I dont take credit for any of them, other then the ones I made

Most of the scripts do work as is.

**1 Find out what ones install as is and mark them as so / Done, all working ones are marked**

**2 See if the ones that dont Install can be fixed to install**

**3 Clean up all the scripts to the new way RetroPie is writing the scripts**

I have changed the list below to show what has been tested to at least to install. I dont have all the games so I cant test them all 

Pull requests and issue reports are accepted and encouraged as well as requests. Feel free to use the issue tracker to send me any personal requests for new scripts that you may have.

## Installation with GUI menu

The following commands will clone the repo to your system and then run the GUI installer where you may select which of the scriptmodules will be copied into the `RetroPie-Setup` folder.

```bash
cd ~
git clone https://github.com/Exarkuniv/RetroPie-Extra.git
cd RetroPie-Extra/
./install-extras.sh
```

## or old install way

```bash
cd ~
git clone https://github.com/Exarkuniv/RetroPie-Extra.git
cd RetroPie-Extra/
./mass-install-extras.sh
```
The installation script assumes that RetroPie-Setup is installed to `$HOME/RetroPie-Setup`. You may specify an alternate location on command-line, ex:
    ./install-extras.sh /games/rp-setup
    
## Usage

After installing **RetroPie-Extra**, the extra scripts will be installed directly in the **RetroPie Setup script** (generally in the experimental section), which you can run from either the command line or from the menu within Emulation Station.
```bash
cd ~
cd RetroPie-Setup/
sudo ./retropie_setup.sh
```

## Updating

The following commands will update RetroPie-Extra to the latest repo and then re-run the installer (your installed scripts will be pre-selected. Just install them again to receive the latest updates.)

```bash
cd ~
cd RetroPie-Extra/
./update-extras.sh
```

## Remove

The following commands will remove RetroPie-Extra from your system.

```bash
cd ~
cd RetroPie-Extra/
./remove-extras.sh
```

Scripts that are unfinished/untested/unpolished/or broken will not be located in this repository and instead have been moved to [RetroPie-Extra-unstable](https://github.com/Exarkuniv/RetroPie-Extra-unstable).

If there is a [X] that means it Installs and Plays. 
I'll have a note at the end with some Info about it. if there is NO note or [X] **PLEASE LET ME KNOW** if it works for you 

#### Emulators

- [X] - `gearboy.sh` - Gameboy emulator - **Installs Plays fine, Need to clean up the controls**
- [ ] - `kat5200.sh` - Atari 8-bit/5200 emulator - **x86 only**
- [X] - `openbor.sh` - Beat 'em Up Game Engine (newest version) - **Tested only on Pi4 so far, installs as a system instead of as a port, direct launching of games from emulationstation supported!**
- [x] - `pico8.sh` - Fantasy Game Emulator - Adds as a new system in RetroPie so you can directly launch carts. **Was told that it works fine, so I'll go with that**
- [ ] - `pokemini.sh` - Pokemon Mini emulator  - **x86 only**
- [X] - `ppsspp-dev.sh` - PlayStation Portable emulator PPSSPP - latest development version - **Tested and works on RPi4 (May 2022)**
- [X] - `supermodel.sh` - Sega Model 3 Arcade emulator  - **Installs Does play, test game are slow**
#### Libretrocores

- [X] - `lr-2048.sh` - 2048 engine - 2048 port for libretro - **Installs, Plays, Runs well**
- [X] - `lr-beetle-pce.sh` - PCEngine emu - Mednafen PCE port for libretro**Installs, Plays, Runs well**
- [X] - `lr-bk.sh` -  Elektronika БК-0010/0011/Terak 8510a emulator - BK port for libretro - **Installs Plays not sure well or not**
- [ ] - `lr-blastem.sh` - Sega Genesis emu - BlastEm port for libretro - **x86 only**
- [ ] - `lr-boom3.sh` -  Doom 3 port for libretro - **x86 only**
- [ ] - `lr-canary.sh` - Citra Canary for libretro - **x86 only**
- [X] - `lr-cannonball.sh` - An Enhanced OutRun engine for libretro - **Installs, Plays, Runs well**
- [X] - `lr-chailove.sh` - 2D Game Framework with ChaiScript roughly inspired by the LÖVE API to libretro - **Installs Plays fine, the one game i could find for it**
- [ ] - `lr-citra.sh` - Citra port for libretro - **x86 only**
- [X] - `lr-crocods.sh` - CrocoDS port for libretro  - **Installs Starts but will not finish loading game**
- [ ] - `lr-daphne.sh` - Daphne port to libretro - laserdisk arcade games. - **Installs dont have any games to test**
- [X] - `lr-fceumm-mod.sh` - Modified fceumm core to specifically support the Super Mario Bros 1/3 hack. - **Installs, Plays, Runs well**
- [X] - `lr-freej2me.sh` - A J2ME implementation for old JAVA phone games. - **Installs, Plays, Runs well**
- [X] - `lr-gearboy.sh` - Game Boy (Color) emulator - Gearboy port for libretro. - **Installs, Plays, Runs well**
- [X] - `lr-gearcoleco.sh` - ColecoVision emulator - GearColeco port for libretro. - **Installs, Plays, Runs well**
- [X] - `lr-lutro.sh` - Lua engine - lua game framework (WIP) for libretro following the LÖVE API - **Installs, Plays, Runs well**
- [ ] - `lr-mame2003_midway.sh` - MAME 0.78 core with Midway games optimizations. - **Installs, doesnt start my games**
- [X] - `lr-melonds.sh` - NDS emu - MelonDS port for libretro - **Installs, Plays, Runs**
- [X] - `lr-mesen-s.sh` - Super Nintendo emu - Mesen-S port for libretro - **Installs, Plays, Runs well**
- [] - `lr-mess-jaguar.sh` - Add support for using lr-mess for Jaguar games, uses atarijaguar system name to match lr-virtualjaguar. - **did not test due to not having mess installed yet**
- [X] - `lr-mu.sh` - Palm OS emu - Mu port for libretro - **Installs, Plays, Runs**
- [X] - `lr-oberon.sh` - Oberon RISC emulator for libretro - **Installs**
- [ ] - `lr-openlara.sh` - Tomb Raider engine - OpenLara port for libretro - **Installs Might work, dont have correct files to test**
- [ ] - `lr-play.sh` - PlayStation 2 emulator - Play port for libretro - **x86 only**
- [X] - `lr-potator.sh` -  Watara Supervision emulator based on Normmatt version - Potator port for libretro - **Installs, Plays, Runs well**
- [X] - `lr-ppsspp-dev.sh` - PlayStation Portable emu - PPSSPP port for libretro - latest development version - **Tested and works on RPi4 (May 2022)**
- [X] - `lr-prboom-system.sh` - For setting up DOOM as an emulated system, not a port.  - **Installs Plays fine**
- [X] - `lr-race.sh` - Neo Geo Pocket (Color) emulator - RACE! port for libretro. - **Installs, Plays, Runs well**
- [X] - `lr-reminiscence.sh` - Flashback engine - Gregory Montoir’s Flashback emulator port for libretro - **Installs, Plays, Runs fine**
- [X] - `lr-sameboy.sh` - Game Boy and Game Boy Color, emulator - SameBoy Port for libretro - **Installs Plays, runs well**
- [X] - `lr-simcoupe.sh` - SAM Coupe emulator - SimCoupe port for libretro - **Installs, Might run games, cant get one to work**
- [X] - `lr-swanstation.sh` - Playstation emulator - Duckstation fork for libretro - **Installs, Plays well**
- [X] - `lr-thepowdertoy.sh` - Sandbox physics game for libretro - **Installs Plays fine**
- [X] - `lr-uzem.sh` - Uzebox engine - Uzem port for libretro - **Installs, Plays well**
- [X] - `lr-vemulator.sh` - SEGA VMU emulator - VeMUlator port for libretro - **Installs Plays fine**
- [X] - `lr-yabasanshiro.sh` - Saturn & ST-V emulator - Yabasanshiro port for libretro - **Installs Plays fine**

#### Ports
- [X] - `abuse.sh` - Classic action game -   **Installs Plays fine, needs keyboard**
- [X] - `augustus.sh` - Augustus - Enhanced Caesar III source port - **Installs plays fine, needs mouse**
- [X] - `barrage.sh` - Shooting Gallery action game - **Installs, Plays fine, needs mouse**
- [X] - `bermudasyndrome.sh` - Bermuda Syndrome engine - **Installs, plays fine, cant exit, but thats the desine of the engine not the script**
- [X] - `bloboats.sh` - Fun physics game - **Installs play fine**
- [X] - `breaker.sh` - Arkanoid clone - **Installs, plays fine, need to drop the resolutions to 640-480**
- [X] - `bstone.sh` - Blake Stone - BStone A source port of Blake Stone: Aliens of Gold and Blake Stone: Planet Strike **Installs, Plays great**
- [X] - `burgerspace.sh` - BurgerTime clone - **Installs, plays fine, need to drop the resolutions to 640-480**
- [X] - `chocolate-doom.sh`- DOOM source port - **Installs, plays great**
- [X] - `chocolate-doom-system.sh`- For setting up DOOM as an emulated system, not port. - **Installs Plays great**
- [X] - `chopper258.sh` - Chopper Commando Revisited - A modern port of Chopper Commando (DOS, 1990) - **Installs, Plays fine, needs keyboard**
- [X] - `crack-attack.sh` - Tetris Attack clone - **Installs works, but you need to need to drop the resolutions to 640-480**
- [X] - `crispy-doom.sh` - DOOM source port - **Installs, Plays great**
- [X] - `crispy-doom-system.sh` - For setting up DOOM as an emulated system, not port. - **Installs, Plays great**
- [X] - `devilutionx.sh` - Diablo source port - **Installs, Plays great w/ DEMO**
- [X] - `dhewm3.sh` - dhewm3 - Doom 3 port - **Installs, Plays great w/ DEMO**
- [X] - `easyrpgplayer.sh` - RPG Maker 2000/2003 interpreter - **Installs and launches**
- [X] - `ecwolf.sh` - ECWolf - ECWolf is an advanced source port for Wolfenstein 3D - **Installs, Plays great, PATCH is not applyed, getting error**
- [X] - `freeciv.sh` - Civilization online clone - **Tested and works well**
- [X] - `freedink.sh` - Dink Smallwood engine - **Installs, Plays great**
- [X] - `freesynd.sh` - Syndicate clone - **Installs, Plays great**
- [X] - `gmloader.sh` - GMLoader - play GameMaker Studio games for Android on non-Android operating systems - **Installs, Plays great W/games**
- [X] - `gnukem.sh` - Dave Gnukem - Duke Nukem 1 look-a-like - **Installs, Plays great**
- [X] - `gtkboard.sh` - Board games system - **Installs Runs fine**
- [X] - `hcl.sh` - Hydra Castle Labrinth - **Installs, Plays great**
- [X] - `heboris.sh` - Tetris The Grand Master clone - **Installs, Plays great,**
- [X] - `hexen2.sh` - Hexen II - Hammer of Thyrion source port - **Installs, Plays great w/demo**
- [X] - `hurrican.sh` - Turrican clone. - **Installs, Plays great**
- [X] - `jfsw.sh` - Shadow warrior port - **Installs and runs on rpi4**
- [X] - `julius.sh` - Julius - Caesar III source port - **Installs, Plays great**
- [X] - `kraptor.sh` - Shoot em up scroller game - **Installs Runs fine**
- [X] - `lbreakout2.sh` - Open Source Breakout game - **Installs Runs fine**
- [X] - `lgeneral.sh` - Open Source strategy game - **Installs Runs fine**
- [X] - `lmarbles.sh` - Open Source Atomix game - **Installs Runs fine, screen is alitte off center**
- [X] - `ltris.sh` - Open Source Tetris game - **Installs, Plays great**
- [X] - `meritous.sh` - Port of an action-adventure dungeon crawl game - **Installs, Plays great**
- [X] - `nblood.sh` - Blood source port - **Installs, Plays great**
- [ ] - `nkaruga.sh` - Ikaruga demake. - **Blocked from installing on Pi4**
- [X] - `nxengine-evo.sh` - The standalone version of the open-source clone/rewrite of Cave Story - **Installs Plays fine on Pi4. Need to bind controller in options**
- [X] - `opendune.sh` - Dune 2 source port - **Installs Play sgreat,/W game, need to need to drop resolutions to lower for full screen**
- [X] - `openjazz.sh` - An enhanced Jazz Jackrabbit source port - **Installs, Plays great**
- [X] - `openjk_ja.sh` - OpenJK: JediAcademy (SP + MP) - **Installs, Plays great, didnt test MP**
- [X] - `openjk_jo.sh` - OpenJK: Jedi Outcast (SP) - **Installs, Plays great**
- [X] - `openmw.sh` - Morrowind source port - **Installs, Plays great**
- [X] - `openra.sh` - Real Time Strategy game engine supporting early Westwood classics - **Installs, Plays great**
- [X] - `openrct2.sh` - RollerCoaster Tycoon 2 port - **Installs, Plays great**
- [X] - `piegalaxy.sh` - Pie Galaxy - Download and install GOG.com games in RetroPie - **Installs Runs, Cant login to test**
- [X] - `pingus.sh` - Lemmings clone - **Installs, Plays great**
- [X] - `pokerth.sh` - open source online poker  - **Installs, Plays fine**
- [X] - `prboom-plus.sh` - Enhanced DOOM source port - **Installs Plays great**
- [X] - `prototype.sh` - Free R-Type remake by Ron Bunce - Gamepad support incomplete. **Installs, Plays fine, needs keyboard**
- [X] - `pydance.sh` - Open Source Dancing Game  - **Installs, Plays fine**
- [X] - `quakespasm.sh` - Another enhanced engine for quake  - **Installs, Plays fine Need to keep the resolution low for smooth play and full screen**
- [X] - `rawgl.sh` - Another World Engine  - **Installs, Plays great**
- [X] - `relive.sh` - Oddworld engine for Abe's Oddysee and Abe's Exoddus **Installs Plays well, some graphic glitches**
- [X] - `reminiscence.sh` - Flashback engine clone - **Installs, Plays fine**
- [ ] - `rickyd.sh` - Rick Dangerous clone - **Blocked from installing on Pi4**
- [X] - `rigelengine.sh` - RigelEngine - Duke Nukem 2 source port - **Installs, Plays great/ with Demo**
- [X] - `rocksndiamonds.sh` - Rocks'n'Diamonds - Emerald Mine Clone - **Installs, Plays great**
- [X] - `rott-darkwar.sh` - Rise of the Triad source port with joystick support - **Installs**
- [X] - `rott-huntbgin.sh` - Rise of the Triad (shareware version) source port with joystick support. - **Installs, Plays great**
- [X] - `rtcw.sh`- IORTCW source port of Return to Castle Wolfenstein. - **Installs, and plays great**
- [X] - `sdl-bomber.sh` - Simple Bomberman clone - **Installs, Plays great**
- [X] - `seahorse.sh` - a side scrolling platform game **Installs Plays fine**
- [X] - `sm64ex.sh` - Super Mario 64 PC Port for Pi4 - Works extremely well on Pi 4. **Installs Plays great**
- [X] - `sorr.sh` - Streets of Rage Remake port - **Installs, Plays great**
- [X] - `supertuxkart.sh` - a free kart-racing game - **Installs, Plays great at lower resolution**
- [X] - `warmux.sh` - Worms Clone - **Installs**
- [X] - `xash3d-fwgs.sh` - Half-Life engine source port. - **Installs**
- [X] - `zeldansq.sh` - Zelda: Navi's Quest fangame - **Installs, Plays great, Needs correct script to remove xinit errors**

#### Drivers
- [X] - `openmwdriver.sh` - The OpenSceneGraph is an open source high performance 3D graphics toolkit. - **Installs works as needed**

#### Supplementary
- [X] - `audacity.sh` - Audacity open-source digital audio editor - **Installs Runs fine**
- [X] - `bezelproject.sh` - Easily set up the Bezel Project **Installs Runs fine**
- [X] - `bgm123.sh` - Straighforward background music player using mpg123. **Currently limited to RPi into HDMI. Testers / collaborators welcome to help expand this functionality.**
- [X] - `chromium.sh` - Open Source Web Browser - **Installs, Work well**
- [X] - `epiphany.sh` - epiphany lightweight web browser - **Installs Runs fine**
- [X] - `filezilla.sh` - A cross platform FTP application - **Installs Runs fine**
- [X] - `firefox-esr.sh` - FireFox-ESR - Formally known as IceWeasel, the Rebranded Firefox Web Browser - **Installs Runs fine**
- [ ] - `fun-facts-splashscreens.sh` - Set up some loading splashscreens with fun facts. **Cant test dont have the right system x86**
- [X] - `gparted.sh` - partition editing application **Installs Runs fine**
- [X] - `joystick-selection.sh` - Set controllers for RetroArch players 1-4. **Installs Does what it needs too**
- [X] - `kodi-extra.sh` - Kodi Media Player 16 with controller support as a separate system - **Installs, works great**
- [X] - `kweb.sh` - Minimal kiosk web browser - **Installs Runs fine**
- [X] - `librecad.sh` - librecad open-source 2d cad - **Installs Runs fine**
- [X] - `libreoffice.sh` - Open source office suite - **Installs Runs fine**
- [X] - `mpv.sh` - Video Player - Not an actual emulator but allows you to play movies and tv shows from new systems in RetroPie.   - **Installs Runs fine**
- [X] - `mixx.sh` - Mixxx DJ Mixing Software App - **Installs Runs fine**
- [X] - `mypaint.sh` - mypaint easy-to-use painting program - **Installs Runs fine**
- [X] - `omxplayer.sh` - Video Player - **Installs Runs fine**
- [X] - `putty.sh` - SSH and telnet client - **Installs Runs fine**
- [X] - `screenshot.sh` - Take screenshots remotely through SSH - **Tested and works well.**
- [X] - `thunderbird.sh` - Thunderbird — Software made to make email easier - **Installs Runs fine**
- [X] - `videolan.sh` - VLC media player - **Installs Runs fine**
- [X] - `weechat.sh` - Console IRC Client - **Installs Runs fine**

### Removed broken scripts to RetroPie-Extra-unstable

- [ ] - `lr-craft.sh` - Minecraft engine  - **Installs Fails to start**
- [ ] - `lr-easyrpg.sh` - RPG Maker 2000/2003 engine - EasyRPG Player interpreter port for libretro - **Fail**
- [ ] - `lr-ecwolf.sh` - Wolfestein 3D engine - ECWolf port based of Wolf4SDL for libretro - **Installs Fails to start games**
- [ ] - `lr-pocketcdg.sh` - A MP3 karaoke music player. - **Installs, Fails to load files **
- [ ] - `lr-minivmac.sh` -  Macintosh Plus Emulator - Mini vMac port for libretro - **Installs, Black screen when starting games**
- [ ] - `deadbeef.sh` - Music and ripped game music player - **Installs**
- [ ] - `corsixth.sh` - Theme Hospital engine clone - **Installs, Lua error, will not play**
- [ ] - `fofix.sh` - FoFix - Guitar Hero and Rock Band clone - **Bin file is nolonger able to download**
- [ ] - `funnyboat.sh` - Funny Boat. A side scrolling boat shooter with waves - **Installs, Plays in small window**
- [ ] - `ganbare.sh` - Japanese 2D Platformer - **Installs, Plays in small window**
- [ ] - `gamemaker.sh` - Install the 3 gamemaker games - **Failed to build**
- [ ] - `lutris.sh` - lutris - Game engine for linux - **fails, missing package now**
- [ ] - `maelstrom.sh` - Maelstrom - Classic Mac Asteroids Remake - **Failed to build**
- [ ] - `mame-tools.sh` - Additional tools for MAME/MESS **Failed**
- [ ] - `manaplus.sh` - 2D MMORPG client - **Failed to build**
- [ ] - `openxcom.sh` - Open Source X-COM Engine - **Failed to build**
- [ ] - `kaiten-patissier.sh` - Japanese 2D Platformer - **Installs Plays in small window**
- [ ] - `kaiten-patissier-ura.sh` - Japanese 2D Platformer - **Installs Plays in small window**
- [ ] - `refkeen.sh` - port for Keen Dreams, The Catacomb Adventure Series and Wolf3d  - **Does not install now**
- [ ] - `shiromino.sh` - Tetris the Grand Master Clone - Requires keyboard to restart/quit.  - **Installs, cant find the config file, fails to start **
- [ ] - `texmaster2009.sh` - Tetris TGM clone - **Plays in small screen**
- [ ] - `tinyfugue.sh` - MUD client - **fails to start**
- [ ] - `ulmos-adventure.sh` - Simple Adventure Game - **Installs Small screen**
- [ ] - `vorton.sh` - Highway Encounter Remake in Spanish - **Installs small screen**
- [ ] - `vgmplay.sh` - Music Player - **fails, missing package now**
- [ ] - `wizznic.sh` - Puzznic clone - **Installs Plays, screen is small**
- [ ] - `zeldapicross.sh` - Zelda themed Picross fangame - **Installs starts but will not go past first screen**

## Hall of Fame - Scripts accepted into RetroPie-Setup

- [X] - LXDE - LXDE Desktop.
- [X] - SimCoupe - Sam Coupe Emulator.
- [X] - Oricutron - Oric 1/Oric Atmos emulator.
- [X] - sdltrs - Radio Shack TRS-80 Model I/III/4/4P emulator.
- [X] - ti99sim - Texas Instruments 99A emulator.

## Contact Info / Additional Information

- **Twitter**: [@exarkuniv](https://twitter.com/8ab0c711e7c9447) 
- I'm very active on the RetroPie [forum](https://retropie.org.uk/forum/)
