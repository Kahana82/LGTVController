#!/bin/bash


bin_folder="/usr/bin/LGTVController"
service_folder="/usr/lib/systemd/system"
config_folder="/etc/LGTVController"
#config_folder="~/.config/LGTVController"


sudo echo " ***  Uninstalling LGTVController ***"


echo "[1/4] Disabling services ... "
sudo systemctl daemon-reload

sudo systemctl disable LGTVController-Startup.service >/dev/null 2>&-
echo -n "      - LGTVController-Startup.service -> "
sudo systemctl is-enabled LGTVController-Startup.service

sudo systemctl disable LGTVController-Shutdown.service >/dev/null 2>&-
echo -n "      - LGTVController-Shutdown.service -> "
sudo systemctl is-enabled LGTVController-Shutdown.service

sudo systemctl daemon-reload
echo "      Services disabled."


echo -n "[2/4] Removing systemd services ... "
sudo rm $service_folder/LGTVController-Startup.service 2>&-
sudo rm $service_folder/LGTVController-Shutdown.service 2>&-
echo "done."


echo -n "[3/4] Removing scripts ... "
if [ $# -eq "0" ]
then
    sudo rm --recursive $bin_folder 2>&-
else
    sudo rm $bin_folder/LGTVController 2>&-
    sudo rm $bin_folder/LGTVController-Startup 2>&-
    sudo rm $bin_folder/LGTVController-Shutdown 2>&-
    sudo rm $bin_folder/LGTVController-SwitchInput 2>&-
    sudo rm $bin_folder/LGTVController-SwitchPictureMode 2>&-
    sudo rm $bin_folder/LGTVController-EstablishConnection 2>&-
fi
echo "done."


if [ $# -eq "0" ]
then
    echo -n "[4/4] Removing config file and connection database ... "
    sudo rm --recursive $config_folder 2>&-
    # sudo rm $config_folder/LGTVController.conf
    # sudo rm $config_folder/.aiopylgtv.sqlite
else
    echo -n "[4/4] Preserving config file and connection database ... "
fi
echo "done."


echo "----- LGTVController uninstalled"
