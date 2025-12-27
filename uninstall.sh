#!/bin/bash


bin_folder="/usr/bin/LGTVController"
service_folder="/usr/lib/systemd/system"
config_folder="/etc/LGTVController"

sudo echo " ***  Uninstalling LGTVController ***"

echo "[1/4] Disabling services ... "
sudo systemctl daemon-reload

sudo systemctl disable LGTVController-Startup.service
sudo systemctl is-enabled LGTVController-Startup.service

sudo systemctl disable LGTVController-Shutdown.service
sudo systemctl is-enabled LGTVController-Shutdown.service

sudo systemctl daemon-reload
echo "Services disabled."


echo -n "[2/4] Removing systemd services ... "
sudo rm $service_folder/LGTVController-Startup.service
sudo rm $service_folder/LGTVController-Shutdown.service
echo "done."

echo -n "[3/4] Removing scripts ... "
# sudo rm $bin_folder/LGTVController
# sudo rm $bin_folder/LGTVController-Startup
# sudo rm $bin_folder/LGTVController-Shutdown
# sudo rm $bin_folder/LGTVController-SwitchInput
# sudo rmdir $bin_folder
sudo rm --recursive $bin_folder
echo "done."

echo -n "[4/4] Removing config file ... "
# sudo rm $config_folder/LGTVController.conf
sudo rm --recursive $config_folder
echo "done."

echo "----- LGTVController uninstalled"
