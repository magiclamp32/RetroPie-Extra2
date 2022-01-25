**UPDATE.** Im going to do my best to take this over and continue the work. Zerojay is done with this and RetroPie in general.

# RetroPie-Extra

This is a **collection of unofficial installation scripts for RetroPie** allowing you to quickly and easily **install emulators, ports and libretrocores** that haven't been included in RetroPie for one reason or another. These scripts can be considered experimental at best. 

Most of the scripts do work as is.
These scritps are all going through retesting and cleanup to get them more inline with the new way of how scripts are writen in RetroPie. 

I have changed the list below to show what has been tested to at least to install. I dont have all the games so I cant test them all 

Pull requests and issue reports are accepted and encouraged as well as requests. Feel free to use the issue tracker to send me any personal requests for new scripts that you may have.

## Installation 

The following commands clone the repo to your Raspberry Pi and then run `install-scripts.sh` to install the scripts in the `master` branch directly to the proper directories in the `RetroPie-Setup/` folder.

```bash
cd ~
git clone https://github.com/Exarkuniv/RetroPie-Extra.git
cd RetroPie-Extra/
./install-extras.sh
```
The installation script assumes that you are running it on a Raspberry Pi with the `RetroPie-Setup/` folder being stored in `/home/pi/RetroPie-Setup`. If your setup differs, just copy the scripts directly to the folder they need to be in.

## Usage

After installing **RetroPie-Extra**, the extra scripts will be installed directly in the **RetroPie Setup script** (generally in the experimental section), which you can run from either the command line or from the menu within Emulation Station.
```
cd ~
cd RetroPie-Setup/
sudo ./retropie_setup.sh
```

## Updating

The following commands update your Raspberry Pi to the latest repo and then run `install-scripts.sh` to install the scripts in the `master` branch directly to the proper directories in the `RetroPie-Setup/` folder.

```bash
cd ~
cd RetroPie-Extra/
git pull origin
./install-extras.sh
```

Scripts that are unfinished/untested/unpolished will not be located in this repository and instead have been moved to [RetroPie-Extra-unstable](https://github.com/Exarkuniv/RetroPie-Extra-unstable).

The installation script assumes that you are running it on a Raspberry Pi with the `RetroPie-Setup/` folder being stored in `/home/pi/RetroPie-Setup`. If your setup differs, just copy the scripts directly to the folder they need to be in.

### Master Branch
If there is a [X] that means it was tested and installs. 
I'll have a note at the end with some Info about it. if there is NO note or [X] **PLEASE LET ME KNOW** if it works for you 
#### Emulators

- [X] - `gearboy.sh` - Gameboy emulator - **Installs**
- [X] - `kat5200.sh` - Atari 8-bit/5200 emulator - **Installs**
- [X] - `mpv.sh` - Video Player - Not an actual emulator but allows you to play movies and tv shows from new systems in RetroPie.   - **Installs**
- [X] - `openbor.sh` - Beat 'em Up Game Engine (newest version) - **Tested only on Pi4 so far, installs as a system instead of as a port, direct launching of games from emulationstation supported!**
- [ ] - `pico8.sh` - Fantasy Game Emulator - Adds as a new system in RetroPie so you can directly launch carts. **No clue, I dont have the required files to test**
- [X] - `pokemini.sh` - Pokemon Mini emulator  - **Installs**
- [X] - `supermodel.sh` - Sega Model 3 Arcade emulator  - **Installs**

#### Libretrocores

- [X] - `lr-2048.sh` - 2048 engine - 2048 port for libretro - **Installs**
- [X] - `lr-bk.sh` -  Elektronika БК-0010/0011/Terak 8510a emulator - BK port for libretro - **Installs**
- [X] - `lr-blastem.sh` - Sega Genesis emu - BlastEm port for libretro - **Installs**
- [ ] - `lr-boom3.sh` -  Doom 3 port for libretro on x86 systems **Cant test dont have the right system x86**
- [ ] - `lr-canary.sh` - Citra Canary for libretro
- [ ] - `lr-cannonball.sh` - An Enhanced OutRun engine for libretro
- [ ] - `lr-chailove.sh` - 2D Game Framework with ChaiScript roughly inspired by the LÖVE API to libretro
- [ ] - `lr-citra.sh` - Citra port for libretro
- [ ] - `lr-craft.sh` - Minecraft engine - 
- [ ] - `lr-crocods.sh` - CrocoDS port for libretro
- [ ] - `lr-daphne.sh` - Daphne port to libretro - laserdisk arcade games.
- [ ] - `lr-easyrpg.sh` - RPG Maker 2000/2003 engine - EasyRPG Player interpreter port for libretro
- [ ] - `lr-ecwolf.sh` - Wolfestein 3D engine - ECWolf port based of Wolf4SDL for libretro
- [ ] - `lr-fceumm-mod.sh` - Modified fceumm core to specifically support the Super Mario Bros 1/3 hack.
- [ ] - `lr-freej2me.sh` - A J2ME implementation for old JAVA phone games.
- [ ] - `lr-gearboy.sh` - Game Boy (Color) emulator - Gearboy port for libretro.
- [ ] - `lr-gearcoleco.sh` - ColecoVision emulator - GearColeco port for libretro.
- [ ] - `lr-lutro.sh` - Lua engine - lua game framework (WIP) for libretro following the LÖVE API
- [ ] - `lr-mame2003_midway.sh` - MAME 0.78 core with Midway games optimizations.
- [ ] - `lr-melonds.sh` - NDS emu - MelonDS port for libretro
- [ ] - `lr-mesen-s.sh` - Super Nintendo emu - Mesen-S port for libretro
- [ ] - `lr-mess-jaguar.sh` - Add support for using lr-mess for Jaguar games, uses atarijaguar system name to match lr-virtualjaguar.
- [ ] - `lr-minivmac.sh` -  Macintosh Plus Emulator - Mini vMac port for libretro
- [ ] - `lr-mu.sh` - Palm OS emu - Mu port for libretro
- [ ] - `lr-oberon.sh` - Oberon RISC emulator for libretro
- [ ] - `lr-openlara.sh` - Tomb Raider engine - OpenLara port for libretro
- [ ] - `lr-play.sh` - PlayStation 2 emulator - Play port for libretro
- [ ] - `lr-pocketcdg.sh` - A MP3 karaoke music player.
- [ ] - `lr-potator.sh` -  Watara Supervision emulator based on Normmatt version - Potator port for libretro
- [ ] - `lr-prboom-system.sh` - For setting up DOOM as an emulated system, not a port. 
- [ ] - `lr-race.sh` - Neo Geo Pocket (Color) emulator - RACE! port for libretro.
- [ ] - `lr-reminiscence.sh` - Flashback engine - Gregory Montoir’s Flashback emulator port for libretro
- [ ] - `lr-sameboy.sh` - Game Boy (Color) emulator - SameBoy Port for libretro
- [ ] - `lr-simcoupe.sh` - SAM Coupe emulator - SimCoupe port for libretro
- [ ] - `lr-thepowdertoy.sh` - Sandbox physics game for libretro
- [ ] - `lr-uzem.sh` - Uzebox engine - Uzem port for libretro
- [ ] - `lr-vemulator.sh` - SEGA VMU emulator - VeMUlator port for libretro
- [ ] - `lr-vitaquake2.sh` - Quake 2 engine - vitaQuake II port for libretro
- [ ] - `lr-vitaquake3.sh` - Quake 3 engine - vitaQuake III (ioquake3) port for libretro
- [ ] - `lr-vitavoyager.sh` - Star Trek Voyager Elite Force Holomatch engine - Lilium Voyager (fork of ioquake3) port for libretro

#### Ports

- [ ] - `amphetamine.sh` - 2D Platforming Game - 
- [ ] - `augustus.sh` - Augustus - Enhanced Caesar III source port
- [ ] - `barrage.sh` - Shooting Gallery action game - 
- [ ] - `bermudasyndrome.sh` - Bermuda Syndrome engine - 
- [ ] - `bloboats.sh` - Fun physics game - 
- [ ] - `breaker.sh` - Arkanoid clone - 
- [ ] - `burgerspace.sh` - BurgerTime clone - 
- [ ] - `chocolate-doom`.sh - DOOM source port - 
- [ ] - `chocolate-doom-system`.sh - For setting up DOOM as an emulated system, not port.
- [ ] - `chromium.sh` - Open Source Web Browser - 
- [ ] - `corsixth.sh` - Theme Hospital engine clone - 
- [ ] - `crack-attack.sh` - Tetris Attack clone - 
- [ ] - `crispy-doom.sh` - DOOM source port - 
- [ ] - `crispy-doom-system.sh` - For setting up DOOM as an emulated system, not port.
- [ ] - `cytadela.sh` - Cytadela project - a conversion of an Amiga first person shooter
- [ ] - `deadbeef.sh` - Music and ripped game music player - 
- [ ] - `devilutionx.sh` - Diablo source port - 
- [ ] - `dhewm3.sh` - dhewm3 - Doom 3 port
- [ ] - `dunedynasty.sh` - Dune Dynasty - Dune 2 Building of a Dynasty port
- [ ] - `dunelegacy.sh` - Dune Legacy - Dune 2 Building of a Dynasty port
- [ ] - `easyrpgplayer.sh` - RPG Maker 2000/2003 interpreter -
- [ ] - `ecwolf.sh` - ECWolf - ECWolf is an advanced source port for Wolfenstein 3D
- [ ] - `filezilla.sh` - A cross platform FTP application
- [ ] - `firefox-esr.sh` - FireFox-ESR - Formally known as IceWeasel, the Rebranded Firefox Web Browser
- [ ] - `fofix.sh` - FoFix - Guitar Hero and Rock Band clone
- [ ] - `freeciv.sh` - Civilization online clone - **Tested and works well, I may soon replace it to compile latest freeciv so that players can play with newer clients.**
- [ ] - `freedink.sh` - Dink Smallwood engine - 
- [ ] - `freesynd.sh` - Syndicate clone - 
- [ ] - `funnyboat.sh` - Funny Boat. A side scrolling boat shooter with waves
- [ ] - `gamemaker.sh` - Install the 3 gamemaker games - 
- [ ] - `ganbare.sh` - Japanese 2D Platformer - 
- [ ] - `gmloader.sh` - GMLoader - play GameMaker Studio games for Android on non-Android operating systems
- [ ] - `gnukem.sh` - Dave Gnukem - Duke Nukem 1 look-a-like
- [ ] - `hcl.sh` - Hydra Castle Labrinth - 
- [ ] - `heboris.sh` - Tetris The Grand Master clone - 
- [ ] - `hexen2.sh` - Hexen II - Hammer of Thyrion source port
- [ ] - `hheretic.sh` - Heretic GL-port
- [ ] - `hhexen.sh` - Hexen GL-port
- [ ] - `hurrican.sh` - Turrican clone. - 
- [ ] - `julius.sh` - Julius - Caesar III source port
- [ ] - `iceweasel.sh` - Rebranded Firefox Web Browser - 
- [ ] - `kaiten-patissier-cs.sh` - Japanese 2D Platformer - **Not installing.**
- [ ] - `kaiten-patissier-ura.sh` - Japanese 2D Platformer - **Not installing.**
- [ ] - `kaiten-patissier.sh` - Japanese 2D Platformer - **Not installing.**
- [ ] - `kodi-extra.sh` - Kodi Media Player 16 with controller support as a separate system - 
- [ ] - `kweb.sh` - Minimal kiosk web browser - 
- [ ] - `lbreakout2.sh` - Open Source Breakout game - 
- [ ] - `lgeneral.sh` - Open Source strategy game - 
- [ ] - `lmarbles.sh` - Open Source Atomix game - 
- [ ] - `ltris.sh` - Open Source Tetris game - 
- [ ] - `lutris.sh` - lutris - Game engine for linux
- [ ] - `maelstrom.sh` - Maelstrom - Classic Mac Asteroids Remake
- [ ] - `manaplus.sh` - 2D MMORPG client - 
- [ ] - `meritous.sh` - Port of an action-adventure dungeon crawl game
- [ ] - `nblood.sh` - Blood source port
- [ ] - `netsurf.sh` - Lightweight web browser - 
- [ ] - `nkaruga.sh` - Ikaruga demake. 
- [X] - `nxengine.sh` - The standalone version of the open-source clone/rewrite of Cave Story - **Installs Plays fine on Pi4. Need to bind controller in options**
- [ ] - `openjazz.sh` - Jazz Jackrabbit source port.
- [ ] - `omxplayer.sh` - Video Player
- [ ] - `openjazz.sh` - An enhanced Jazz Jackrabbit source port
- [ ] - `openjk_ja.sh` - OpenJK: JediAcademy (SP + MP)
- [ ] - `openjk_jo.sh` - OpenJK: Jedi Outcast (SP)
- [ ] - `openmw.sh` - Morrowind source port
- [ ] - `openmwdriver.sh` - The OpenSceneGraph is an open source high performance 3D graphics toolkit.
- [ ] - `openra.sh` - Real Time Strategy game engine supporting early Westwood classics
- [ ] - `openrct2.sh` - RollerCoaster Tycoon 2 port
- [ ] - `openxcom.sh` - Open Source X-COM Engine
- [ ] - `pingus.sh` - Lemmings clone - 
- [ ] - `pokerth.sh` - open source online poker
- [ ] - `prboom-plus.sh` - Enhanced DOOM source port - lightly 
- [ ] - `rawgl.sh` - Another World source port - 
- [ ] - `reminiscence.sh` - Flashback engine clone - 
- [ ] - `pydance.sh` - Open Source Dancing Game
- [ ] - `quakespasm.sh` - Another enhanced engine for quake
- [ ] - `rawgl.sh` - Another World Engine
- [ ] - `refkeen.sh` - port for Keen Dreams, The Catacomb Adventure Series and Wolf3d
- [ ] - `rickyd.sh` - Rick Dangerous clone - 
- [ ] - `rigelengine.sh` - RigelEngine - Duke Nukem 2 source port
- [ ] - `rocksndiamonds.sh` - Rocks'n'Diamonds - Emerald Mine Clone
- [ ] - `rott-darkwar.sh` - Rise of the Triad source port with joystick support - 
- [ ] - `rott-huntbgin.sh` - Rise of the Triad (shareware version) source port with joystick support.
- [ ] - `score.sh` - score - Septerra Core: Legacy of the Creator port 
- [ ] - `sdl-bomber.sh` - Simple Bomberman clone - 
- [ ] - `shadowwarrior.sh` - Jfsw - Shadow warrior port
- [ ] - `shiromino.sh` - Tetris the Grand Master Clone - Requires keyboard to restart/quit.
- [ ] - `sorr.sh` - Streets of Rage Remake port - *
- [ ] - `sm64ex.sh` - Super Mario 64 PC Port for Pi4 - Works extremely well on Pi 4.
- [ ] - `texmaster2009.sh` - Tetris TGM clone - 
- [ ] - `tinyfugue.sh` - MUD client - 
- [ ] - `ulmos-adventure.sh` - Simple Adventure Game - 
- [ ] - `vanillacc.sh` - Vanilla-Command and Conquer
- [ ] - `vgmplay.sh` - Music Player - 
- [ ] - `vorton.sh` - Highway Encounter Remake in Spanish - 
- [ ] - `warmux.sh` - Worms Clone - 
- [ ] - `weechat.sh` - Console IRC Client - 
- [ ] - `wizznic.sh` - Puzznic clone -
- [ ] - `xash3d-fwgs.sh` - Half-Life engine source port.
- [ ] - `zeldansq.sh` - Zelda: Navi's Quest fangame - 
- [ ] - `zeldapicross.sh` - Zelda themed Picross fangame - 

#### Supplementary
- [ ] - `bezelproject.sh` - Easily set up the Bezel Project
- [ ] - `gparted.sh` - partition editing application
- [ ] - `fun-facts-splashscreens.sh` - Set up some loading splashscreens with fun facts.
- [ ] - `joystick-selection.sh` - Set controllers for RetroArch players 1-4.
- [ ] - `mame-tools.sh` - Additional tools for MAME/MESS
- [ ] - `screenshot.sh` - Take screenshots remotely through SSH - **Tested and works well.**

### My Future To-Do List 

I'm useing the Issues tab in GitHub for my To-Do list, just easier to keep it all stright. 

### Old Future To-Do List 

[TODO.md](/TODO.md).


## Hall of Fame - Scripts accepted into RetroPie-Setup

- [X] - LXDE - LXDE Desktop.
- [X] - SimCoupe - Sam Coupe Emulator.
- [X] - Oricutron - Oric 1/Oric Atmos emulator.
- [X] - sdltrs - Radio Shack TRS-80 Model I/III/4/4P emulator.
- [X] - ti99sim - Texas Instruments 99A emulator.

## Contact Info / Additional Information

- **Twitter**: [@exarkuniv](https://twitter.com/8ab0c711e7c9447) 
- I'm very active on the RetroPie [forum](https://retropie.org.uk/forum/)
