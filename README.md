# RetroPie-Extra

This is a collection of unofficial installation scripts for RetroPie allowing you to quickly and easily install emulators, ports and libretrocores that haven't been 
included in RetroPie for one reason or another. These scripts can be considered experimental at best. 

Those in the master branch have been tested reasonably and should work well but may have some flaws as they haven't gone through the RetroPie's watchful eyes yet. 
Scripts included in their own branches are either actively being worked upon or have various issues that have not been worked out yet.

Pull requests and issue reports are accepted and encouraged as well as requests. Feel free to use the issue tracker to send me any personal requests for new scripts
that you may have.

--- Installation ---

You can clone the repo to your Pi and then run the install-scripts.sh script to install the scripts in the master branch directly to the proper directories in RetroPie-Setup.
This script assumes that you are running it on a Raspberry Pi with the RetroPie-Setup being stored in /home/pi/RetroPie-Setup. If your setup differs, just copy the scripts
directly to the folder they need to be in.


-- Master Branch --  
- [X] - bermudasyndrome.sh - Bermuda Syndrome engine - Tested, runs, possibly instable.  
- [X] - chocolate-doom.sh - DOOM source port - Tested and works well.  
- [X] - chromium.sh - Open Source Web Browser - Tested and works well.
- [X] - corsixth.sh - Theme Hospital engine clone - Tested and works well.  
- [X] - crispy-doom.sh - DOOM source port - Tested and works well.  
- [X] - easyrpgplayer.sh - RPG Maker 2000/2003 interpreter - Tested and works well.  
- [X] - freeciv.sh - Civilization online clone - Tested and works well, I may soon replace it to compile latest freeciv so that players can play with newer clients.  
- [X] - freesynd.sh - Syndicate clone - Tested and has occasional crash issues. Save between levels to avoid losing progress.  
- [X] - gearboy.sh - Gameboy and Gameboy Color emulator - Tested and works well.
- [X] - kweb.sh - Minimal kiosk web browser - Tested and working well generally. Media may not be working well, I need to understand it better first to say.  
- [X] - manaplus.sh - 2D MMORPG client - Tested and works well, requires mouse.  
- [X] - pingus.sh - Lemmings clone - Tested and works well, requires mouse.  
- [X] - rawgl.sh - Another World source port - Tested, occasionally crashes when button held when switching scenes?  
- [X] - reminiscence.sh - Flashback engine clone - Tested and works well.   
- [X] - rott.sh - Rise of the Triad source port - Tested and works well.  

-- Testing --  
- [ ] - abuse.sh - Classic action game - Appears to have some stability issues as well as problems with sound/audio dropping out. Does not full screen properly yet.  
- [ ] - alephone-community.sh - Additional scenarios for AlephOne - Some instability with Alephone on Raspberry Pi. Working on it.  
- [ ] - beebem.sh - BBC Micro emulator - Working, won't run game from command line. Disk load issue fixed.  
- [ ] - f2bgl.sh - Fade To Black engine - Segfaults on launch.  
- [ ] - kodi.sh - Media Player - Installs v16 for Raspbian Jessie ONLY. Currently untested.  
- [ ] - lr-craft.sh - libretro-based Minecraft clone - Does not work on Pi due to missing OpenGLES2 support. Would require a version of RetroArch compiled against OpenGL. Not happening.  
- [ ] - mehstation.sh - Emulator frontend - Currently untested, unfinished script. Not able to replace emulationstation yet.  
- [ ] - moonlight.sh - Open Source nVidia GameStreaming - Currently untested.  
- [ ] - openfodder.sh - Open source Cannon Fodder engine - Instable, crashes during second mission.  


--- Future To-Do List (not ordered by priority) ---

- [ ] - glshim/glshim script by Hiradur.  
- [ ] - SDLash/Xash Half-Life engine through glshim.  
- [ ] - Beatfever Mania.  
- [ ] - Stepmania/Frets on Fire through glshim/new OpenGL driver.  
- [ ] - Mupen64Plus videocore plugin - Awaiting fixed code (gizmo98?)  
