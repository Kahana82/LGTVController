#!/bin/bash


bin_folder="/usr/bin/LGTVController"
service_folder="/usr/lib/systemd/system"
config_folder="/etc/LGTVController"
#config_folder="~/.config/LGTVController"


sudo echo " ***  Installing LGTVController ***"


if [ $# -eq "0" ]
then
    echo -n "[1/6] Copying config file ... "
    sudo mkdir $config_folder >/dev/null 2>&-
    sudo cp ./config/LGTVController.conf $config_folder
    echo "done."
else
    echo "[1/6] Config file preserved."
fi


echo -n "[2/6] Copying scripts ... "
if [ $# -eq "0" ]
then
    sudo mkdir $bin_folder >/dev/null 2>&-
fi
sudo cp ./bin/LGTVController $bin_folder
sudo cp ./bin/LGTVController-Startup $bin_folder
sudo cp ./bin/LGTVController-Shutdown $bin_folder
sudo cp ./bin/LGTVController-SwitchInput $bin_folder
sudo cp ./bin/LGTVController-SwitchPictureMode $bin_folder
sudo cp ./bin/LGTVController-EstablishConnection $bin_folder
echo "done."


echo -n "[3/6] Making scripts executable ... "
sudo chmod +x $bin_folder/LGTVController-Startup
sudo chmod +x $bin_folder/LGTVController-Shutdown
sudo chmod +x $bin_folder/LGTVController-SwitchInput
sudo chmod +x $bin_folder/LGTVController-SwitchPictureMode
sudo chmod +x $bin_folder/LGTVController-EstablishConnection
echo "done."


echo -n "[4/6] Copying systemd services ... "
sudo cp ./services/LGTVController-Startup.service $service_folder
sudo cp ./services/LGTVController-Shutdown.service $service_folder
echo "done."


echo "[5/6] Enabling services ... "
sudo systemctl daemon-reload

sudo systemctl enable LGTVController-Startup.service >/dev/null 2>&-
echo -n "      - LGTVController-Startup.service -> "
sudo systemctl is-enabled LGTVController-Startup.service

sudo systemctl enable LGTVController-Shutdown.service >/dev/null 2>&-
echo -n "      - LGTVController-Shutdown.service -> "
sudo systemctl is-enabled LGTVController-Shutdown.service

sudo systemctl daemon-reload
echo "      Services enabled."


if [ $# -eq "0" ]
then
    echo "[6/6] Creating connection database ... "
    pushd $config_folder >/dev/null 2>&-
    sudo $bin_folder/LGTVController-EstablishConnection
    popd >/dev/null 2>&-
    echo "      done."
else
    echo "[6/6] Connection database preserved."
fi


echo "----- LGTVController installed"
