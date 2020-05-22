#!/bin/bash  

if [ ! -f $HOME/.Xilinx/license.lic ]; then  
        mkdir -p $HOME/.Xilinx 
        cp /opt/Xilinx/Xilinx.lic $HOME/.Xilinx/  
fi 
 
source /opt/Xilinx/14.7/ISE_DS/settings64.sh
ise
