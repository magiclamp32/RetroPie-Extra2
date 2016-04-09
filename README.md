# RetroPie-Extra

This is a collection of unofficial installation scripts for RetroPie allowing you to quickly and easily install emulators, ports and libretrocores that haven't been 
included in RetroPie for one reason or another. These scripts can be considered experimental at best. 

Those in the master branch have been tested reasonably and should work well but may have some flaws as they haven't gone through the RetroPie's watchful eyes yet. 
Scripts included in their own branches are either actively being worked upon or have various issues that have not been worked out yet.

Pull requests and issue reports are accepted and encouraged as well as requests. Feel free to use the issue tracker to send me any personal requests for new scripts
that you may have.

### Installation 

Install the extra scripts

The following clones the repo to your Pi and then the install-scripts.sh installs the scripts in the master branch directly to the proper directories in RetroPie-Setup.

```
git clone https://github.com/zerojay/RetroPie-Extra.git
cd RetroPie-Extra/
./install-extras.sh
```
Run the RetroPie Setup Script (the extra scripts will be in the experimental section)
```
cd
cd RetroPie-Setup
sudo ./retropie_setup.sh
```

This script assumes that you are running it on a Raspberry Pi with the RetroPie-Setup being stored in /home/pi/RetroPie-Setup. If your setup differs, just copy the scripts directly to the folder they need to be in.

### Troubleshooting

Here are some helpful hints for getting around some possible issues that you may encounter.

##### The port I installed appears to close immediately upon launching.

In most cases, this is likely because the port requires external data files, especially in the case of game engines. In cases where shareware datafiles are available, the port will install them where possible. Otherwise, you will need to provide your own. The warning dialog box at the end of installation should usually tell you what files will be needed and where to place them. If you somehow don't see a dialog box after installation, you can open the script itself and look towards the bottom for the warning.

Another possible case is the port uses the X11 windowing system. In some cases, I've included the X11 window system because of issues such as the game not going fullscreen, or just not functioning at all without it. In these cases, you will need to tell the system that it is okay for users other than root to use X11. You can do this by running the following command:

```
dpkg-reconfigure x11-common
```

In the dialog box that comes up, you can select which users are allowed to use the X11 system. I would suggest you allow the pi user or anyone to run X11. This only needs to be done one time to fix the issue for all ports and programs that use the X11 window system. I would even suggest doing it now even if you have no intention yet of installing a port that uses X11 yet so that you do not need to deal with this issue in the future.


### Included Software
#### Master Branch

- [X] - bermudasyndrome.sh - Bermuda Syndrome engine - Tested, runs, possibly instable.  
- [X] - breaker.sh - Arkanoid clone - Tested and works well.  
- [X] - burgerspace.sh - BurgerTime clone - Tested and works well.  
- [X] - chocolate-doom.sh - DOOM source port - Tested and works well.  
- [X] - chromium.sh - Open Source Web Browser - Tested and works well.
- [X] - corsixth.sh - Theme Hospital engine clone - Tested and works well.  
- [X] - crispy-doom.sh - DOOM source port - Tested and works well.  
- [X] - deadbeef.sh - Music and ripped game music player - Tested and works well.
- [X] - easyrpgplayer.sh - RPG Maker 2000/2003 interpreter - Tested and works well.  
- [X] - freeciv.sh - Civilization online clone - Tested and works well, I may soon replace it to compile latest freeciv so that players can play with newer clients.  
- [X] - freesynd.sh - Syndicate clone - Tested and has occasional crash issues. Save between levels to avoid losing progress.  
- [X] - gamemaker.sh - Install the 3 gamemaker games - Tested and works well.  
- [X] - ganbare.sh - Japanese 2D Platformer - Tested and works well, does not require Japanese to play.  
- [X] - kaiten-patissier-cs.sh - Japanese 2D Platformer - Tested and works well, has English mode.  
- [X] - kaiten-patissier-ura.sh - Japanese 2D Platformer - Tested and works well, has English mode.  
- [X] - kaiten-patissier.sh - Japanese 2D Platformer - Tested and works well, has English mode.  
- [X] - kodi.sh - Kodi Media Player 16 with controller support as a separate system - Tested and works well.  
- [X] - kweb.sh - Minimal kiosk web browser - Tested and working well generally. Media may not be working well, I need to understand it better first to say.  
- [X] - manaplus.sh - 2D MMORPG client - Tested and works well, requires mouse.  
- [X] - pingus.sh - Lemmings clone - Tested and works well, requires mouse.  
- [X] - rawgl.sh - Another World source port - Tested, occasionally crashes when button held when switching scenes?  
- [X] - reminiscence.sh - Flashback engine clone - Tested and works well.   
- [X] - roadfighter.sh - RoadFighter clone - Tested and works well.  
- [X] - rott.sh - Rise of the Triad source port - Tested and works well.  
- [X] - smw-netplay.sh - Super Mario War with netplay - Tested and works well, netplay untested?  
- [X] - sorr.sh - Streets of Rage Remake port - Tested and works well. Use fullscreen fast video mode.  
- [X] - tinyfugue.sh - MUD client - Tested and works well.  
- [X] - vorton.sh - Highway Encounter Remake in Spanish - Tested and works well.
- [X] - wizznic.sh - Puzznic clone - Tested and works well.  
- [X] - gearboy.sh - Gameboy emulator - Tested and works well.  
- [X] - ti99sim.sh - Texas Instruments 99A emulator - Tested and works well.  

#### Testing

- [ ] - abuse.sh - Classic action game - Appears to have some stability issues as well as problems with sound/audio dropping out. Does not full screen properly yet.  
- [ ] - alephone-community.sh - Additional scenarios for AlephOne - Some instability with Alephone on Raspberry Pi. Working on it.  
- [ ] - beebem.sh - BBC Micro emulator - Working, won't run game from command line. Disk load issue fixed.  
- [ ] - caveexpress.sh - Cave Express game - Not working, some major compilation issues.
- [ ] - f2bgl.sh - Fade To Black engine - Segfaults on launch.  
- [ ] - freegish.sh - Gish clone - Requires OpenGL, crashes.  
- [ ] - kodi.sh - Media Player - Installs v16 for Raspbian Jessie ONLY. Currently untested.  
- [ ] - lr-craft.sh - libretro-based Minecraft clone - Does not work on Pi due to missing OpenGLES2 support. Would require a version of RetroArch compiled against OpenGL. Not happening.  
- [ ] - mehstation.sh - Emulator frontend - Currently untested, unfinished script. Not able to replace emulationstation yet.  
- [ ] - moonlight.sh - Open Source nVidia GameStreaming - Needs to be built from source for latest versions to work properly.   
- [ ] - openfodder.sh - Open source Cannon Fodder engine - Instable, crashes during second mission.  
 


#### Future To-Do List (not ordered by priority)

- [ ] - glshim/glshim script by Hiradur.  
- [ ] - SDLash/Xash Half-Life engine through glshim.  
- [ ] - Beatfever Mania.  
- [ ] - Stepmania/Frets on Fire through glshim/new OpenGL driver.  
- [ ] - Mupen64Plus videocore plugin - Awaiting fixed code (gizmo98?)  
- [ ] - John's Shadow Warrior Port (jswp)
