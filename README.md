FPGA for Docker
---------------

This repository contains a series of tools to create sandboxed Docker
containers for running various FPGA development tools on Linux.

The motivation for this project was to avoid having to install a bunch
of system-wide dependencies since most of these tools require 32-bit
libraries to run.

# Supported Tools

- Intel Quartus Prime 18.1
- Altera Quartus II 13.1
- Altera Quartus II 13.0sp1
- Lattice iCEcube2 2017-08

# Usage

Each directory within this repository contains a Makefile.

To build the container image, just type `make` at the prompt in the directory
of the tool/version you'd like to use. The installer files will be downloaded
from the vendor, then extracted and installed. These are all configured to
download the lite/free versions of the tools.

In the case of Lattice iCEcube2, the GUI installer must be used and will launch
automatically. Additionally, a license file will need to be acquired separately
from Lattice before building the container. Further instructions can be found 
in the `README.md` within that subdirectory. 

Once the containers are built, you can run them with `make run`. A `home`
directory is mounted as a volume from the local filesystem into the container
so changes will persist if you delete/recreate the container/images. If you
want to control the location of the home directory or change other options,
see the `Makefile`. After exiting the tool, the container is not deleted.
To restart a container, find it in `docker ps -a` and then start it with
`docker start <container id/name>`. To remove it, `docker rm <container id/name>`. 
To completely remove the image from your system, find the image tag or id 
with `docker images` and then remove it with `docker rmi <image tag/id>`.

No user data is stored inside the container as long as you only manipulate data within
the home directory. It is therefore generally safe to delete containers after use.


# Caveats/Todos

* The account running the container must have UID 1000 and GID 1000 or X11 passthrough
will not work. This makes the containers not very useful on a multi-user system.
* The containers are given privileged access to the host system to allow access to USB
devices such as JTAG programmers and devboards. This has not been thoroughly tested.
Privileges can likely be pared down.
* Your user account must have full access to docker (e.g., a member of the `docker` group)
* Quartus builds will use a large amount of disk space during builds, upwards of 50GB.
The final containers are between 15GB and 20GB each. Lattice iCEcube2 is much smaller at
about 1.5GB.
* Remote X11 works in most cases if your `DISPLAY` envvar is set with a fully-qualified
hostname and authenticated access is disabled. 
* The dependencies in the Dockerfiles can likely be pared down/cleaned up a bit.
* The tools will often use a web browser or PDF viewer to open documentation. the
Quartus containers install firefox  which seems like overkill to me but I haven't
thought of a more clever solution.
