FPGA for Docker
---------------

This repository contains a series of tools to create sandboxed Docker
containers for running various FPGA development tools on Linux.

The motivation for this project was to avoid having to install a bunch
of system-wide dependencies since most of these tools require 32-bit
libraries to run.

## Recent changes:

* 2021-08-24
  * Added more versions of Quartus
  * Containers are more user-agnostic
  * Enabled USB passthrough for major device type 189 (most JTAG adapters)
* 2020-05-24
  * An extensive revamp of the entire build system. 
  * Added Intel Quartus 19.1 and Xilinx ISE 14.7. 
  * X11 (mostly) works for local UNIX socket, SSH forwarding and remote
    displays, with or without xauth cookies.  
  * UID/GID other than 1000 supported (uses your current uid/gid).

## Supported Tools

- Intel Quartus Prime 20.1.1
- Intel Quartus Prime 20.1
- Intel Quartus Prime 19.1
- Intel Quartus Prime 18.1
- Intel Quartus Prime 18.0
- Intel Quartus Prime 17.1
- Intel Quartus Prime 17.0
- Altera Quartus Prime 16.1
- Altera Quartus Prime 16.0
- Altera Quartus Prime 15.1
- Altera Quartus II 15.0
- Altera Quartus II 14.1
- Altera Quartus II 14.0
- Altera Quartus II 13.1
- Altera Quartus II 13.0sp1
- Xilinx ISE 14.7
- Lattice iCEcube2 Sep_12_2017, Dec_10_2020

## Requirements

* Linux capable of running Docker
* X11 server (local, network or SSH tunneled)

## Usage

Edit the top-level `Makefile` to control which containers will be built. A
common base image will be built that each tool uses to reduce overall container
size and build time.

Run `make` and all the desired containers will be built. Many of the tools will
download their installers automatically but some require you to log in to the
vendor's site and download manually (Xilinx ISE).

In the case of Lattice iCEcube2, the GUI installer must be used and will launch
automatically. Heed the directions printed to the console before it launches.
Additionally, a license file will need to be acquired separately from Lattice
before building the container. Further instructions can be found in the
`README.md` within that subdirectory. 

Once the containers are built, you can run them with the `run-fpga` tool in the
top directory. A unique `home` directory for each tool is created and mounted
into the container along with a shared directory mounted to ~/shared so changes
will persist between runs and settings can be kept separate for each tool.  If
you want to control the location of the home directories or change other
options, see the `run-fpga` script. After exiting the tool, the container is
deleted (but not the image or home directory).

No user data is stored inside the container as long as you only manipulate data
within the home directory. Any data not in your home directory will be lost
after closing the tool.


## Caveats

* Your user account must have full access to docker (e.g., a member of the
  `docker` group)
* To enhance performance, the docker option "--ipc=host" is enabled when using
  a local UNIX socket connection to X11. Read the docker documentation for more
  information on the security implications of this.
* Quartus builds will use a large amount of disk space during builds, upwards
  of 50GB.  The final containers are around 20GB each. Lattice
  iCEcube2 is much smaller at about 1.5GB. To save space, all the tools use a 
  common base image with the OS and libraries, fonts, etc.
* If you want to build the Xilinx ISE 14.7 container, you must have `qemu-nbd`
  and the nbd kernel driver installed and root access via sudo. An alternate 
  method that uses much more disk space can be implemented, but would still 
  require root access to loop mount a filesystem image.
* Outbound network connections are not restricted. If you want to apply specific 
  `iptables` rules to a container, either edit the `fpga` script in the
  `fpga-base/<operating system>` (most use the centos6 flavor) directory or create 
  a script in `home/<tool>/.fpga-docker/startup.sh`. If you are using a local X11 
  server via UNIX socket you can disable network entirely by adding `--network none`
  to the `docker run` command at the end of the `run-fpga` script.


## TODO

* Add more Xilinx tools (Vivado)
* Support command-line based workflows
