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
[X] - chocolate-doom.sh - Tested and works well.    
[X] - crispy-doom.sh - Tested and works well.  
[X] - freeciv.sh - Tested and works well, I may soon replace it to compile latest freeciv so that players can play with newer clients.  
[X] - reminiscence.sh - Tested and works well.  

-- Testing --  
[ ] - abuse.sh - Appears to have some stability issues as well as problems with sound/audio dropping out. Does not full screen properly yet.  
[ ] - lr-craft.sh - New libretro core for a Minecraft clone, does not work on Pi due to missing OpenGLES2 support. X86 only, untested.  


