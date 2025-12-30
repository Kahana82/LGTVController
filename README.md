Scripts and services to control an LG TV through WebOS with bscpylgtv

Prerequisites:
--------------
- bscpylgtv  
  GitHub : https://github.com/chros73/bscpylgtv  
     AUR : https://aur.archlinux.org/packages/bscpylgtv

- The IPv4 address of the TV, found in General - Network  
  under either the "Wired Connection (Ethernet)" or "Wi-Fi Connection"  
  this will be used in the config file for variable "tv_ip".

- Enable the "Turn on via Wi-Fi(Networked Standby Mode)" option in the TV's settings, found under : General - Devices - External Devices - TV On With Mobile  
  This can be thought of as activating an API on the TV, which makes functionality such as WoL (wake on lan) possible.  
  Also note that the power consumption of the TV in standby will be higher as it will keep the network module active.


Installation:
-------------
1. Make sure bscpylgtv is running on your machine,  
   either by compiling it yourself or by installing from the AUR (command: paru bscpylgtv)

2. Pull this repo somewhere on your system or download as .zip and unpack.

3. Edit the values of the variables in the config file (./config/LGTVController.conf) before installing.
    - "tv_ip" is needed for anything to work, set to the IP address you got from the TV's settings before.
    - change "hdmi_input_startup" if your computer is plugged into another input then HDMI_1 (default).
    - change "picture_mode_startup" if you want another picture mode on startup (f.i. filmMaker).

4. Start the install process with install.sh:
    - make the file executable (chmod +x or right click -> permissions)
    - open a prompt where the script is located and call the script
    - accept the prompt to grant sudo privilieges (it needs to copy files under /etc, /usr/bin and /usr/lib/systemd/system)
      therefore executing by double clicking the script file will result in failure unless executed with administrative privileges.

5. Accept the pairing prompt on the TV to approve communication between the TV and your machine.  
   After accepting the prompt, a .aiopylgtv.sqlite file (local database that stores the key and the TV's IP address pertaining to the connection) will be created alongside the config file under /etc/LGTVController.

6. Take a look inside the ./shortcuts folder, see if any of the shortcuts could be used on your desktop / start menu / start bar.



Post install:
-------------
- To uninstall : execute the uninstall script (./uninstall.sh)

- To update after editing the scripts/config file : execute the update script (./update.sh)  
  this will run the uninstall (./uninstall.sh) then the install (./install.sh) script again.
  
- The config file can off course be edited in place (/etc/LGTVController/LGTVController.conf)  
  instead of editing the local files and using the update script.



Remarks:
--------
By default the shutdown script (./bin/LGTVController-Shutdown) checks if a secondary host computer is running by sending a ping command and if so switches the HDMI input of the TV to that computer.  
This functionality is controlled by the "otherpc_hostname" and "hdmi_input_shutdown" variables in the config file.  
If this behavior is of no interest to you then enter something bogus for "otherpc_hostname" (or comment it out) in the config file, so that the shutdown script just powers off the TV.  



Thanks:
-------
To bscpylgtv's awesome work, which made this simple solution possible.