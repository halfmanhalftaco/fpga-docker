#!/bin/bash

echo "Copying /opt/Xilinx..."
cp -r /mnt/opt/Xilinx /opt
cp /mnt/home/ise/.Xilinx/Xilinx.lic /opt/Xilinx
mkdir -p /usr/share/applications/Xilinx
cp /mnt/home/ise/.local/share/applications/[iAPX]*.desktop /usr/share/applications/Xilinx
