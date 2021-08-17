#!/bin/bash

echo "Copying /opt/Xilinx..."
cp -r /build/mnt/opt/Xilinx /opt
cp /build/mnt/home/ise/.Xilinx/Xilinx.lic /opt/Xilinx
cp /build/launch.sh /opt/Xilinx && chmod +x /opt/Xilinx/launch.sh
