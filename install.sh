#!/bin/bash


bin_folder="/usr/bin/LGTVController"
service_folder="/usr/lib/systemd/system"
config_folder="/etc/LGTVController"

sudo echo " ***  Installing LGTVController ***"

echo -n "[1/5] Copying config file ... "
sudo mkdir $config_folder
sudo cp ./config/LGTVController.conf $config_folder
echo "done."

echo -n "[2/5] Copying scripts ... "
sudo mkdir $bin_folder
sudo cp ./bin/LGTVController $bin_folder
sudo cp ./bin/LGTVController-Startup $bin_folder
sudo cp ./bin/LGTVController-Shutdown $bin_folder
sudo cp ./bin/LGTVController-SwitchInput $bin_folder
echo "done."

echo -n "[3/5] Making scripts executable ... "
sudo chmod +x $bin_folder/LGTVController-Startup
sudo chmod +x $bin_folder/LGTVController-Shutdown
sudo chmod +x $bin_folder/LGTVController-SwitchInput
echo "done."

echo -n "[4/5] Copying systemd services ... "
sudo cp ./services/LGTVController-Startup.service $service_folder
sudo cp ./services/LGTVController-Shutdown.service $service_folder
echo "done."


echo "[5/5] Enabling services ... "
sudo systemctl daemon-reload

sudo systemctl enable LGTVController-Startup.service
sudo systemctl is-enabled LGTVController-Startup.service

sudo systemctl enable LGTVController-Shutdown.service
sudo systemctl is-enabled LGTVController-Shutdown.service

sudo systemctl daemon-reload
echo "Services enabled."

echo "----- LGTVController installed"
