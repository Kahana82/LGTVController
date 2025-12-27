Scripts and services to control an LG TV through WebOS with bscpylgtv

Prerequisites:
--------------
- bscpylgtv  
  GitHub : https://github.com/chros73/bscpylgtv  
     AUR : https://aur.archlinux.org/packages/bscpylgtv

- the IPv4 address of the TV, found under : General - Network  
  this will be used in the config file for variable "tv_ip".

- enable "TV On With Mobile" in the TV's settings, under : General - Devices - External Devices  
  this can be seen as activating an API on the TV, which makes f.i. WoL (wake on lan) possible.


Installation:
-------------
- pull the repo or download as .zip and unpack somewhere on your system.

- edit the values of the variables in the config file (./config/LGTVController.conf) before installing.  
  "tv_ip" is needed for anything to work, set to the IP address you got from the TV's settings before.  
  change "wanted_hdmi_input_startup" if your computer is plugged into another input then HDMI_1 (default).  
  change "wanted_picture_mode_startup" if you want onother picture mode on startup (f.i. filmmaker).

- execute the install script (./install.sh) to start the install process.  
  doing so from within a console will give feedback output.



Post install:
-------------
- to uninstall : execute the uninstall script (./uninstall.sh)

- to update after editing the scripts/config file : execute the update script (./update.sh)  
  this will run the uninstall (./uninstall.sh) then the install (./install.sh) script again.
  
- the config file can off course be edited in place (/etc/LGTVControllerLGTVController.conf)  
  instead of editing the local files and using the update script.



Remarks:
--------
By default the shutdown script (./bin/LGTVController-Shutdown) checks if a secondary host computer is running by sending a ping command and if so switches the HDMI input of the TV to that computer.  
This functionality is controlled by the "otherpc_hostname" and "wanted_hdmi_input_shutdown" variables in the config file.  
If this behavior is of no interest to you then enter something bogus for "otherpc_hostname" (or comment it out) in the config file, so that the shutdown script just powers off the TV.  

Upon first execution (when either the startup or shutdown service calls the startup/shutdown script) the TV will display a prompt to accept the communication initiated by bscpylgtv on your computer.  
After accepting the prompt, a .aiopylgtv.sqlite file (local database that stores the key and the TV's IP address pertaining to the connection) will be created where the scripts are after installation (/usr/bin/LGTVController).



Thanks:
-------
To bscpylgtv's awesome work, which made this simple solution possible.