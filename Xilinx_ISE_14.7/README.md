Xilinx ISE 14.7
===============

This directory contains scripts to generate Docker containers for Xilinx ISE 14.7.

The [ISE 14.7 Windows 10](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive-ise.html) download on Xilinx's site contains a virtual machine image with the latest
version of the software. The scripts in this directory extract the software from the VM and makes
a Docker container out of it.

## Requirements

* sudo access
* qemu-nbd and nbd kernel driver
  * Alternately, 7zip can be used to extract the partition image, but this takes 60+ GB disk space

Run `make` to build the image, then run `run-ise` to launch. 

