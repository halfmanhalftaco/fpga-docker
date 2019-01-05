 Lattice iCEcube2 Build Instructions
 -----------------------------------
 
 iCEcube2 appears to not have an unattended install mode so you must install using the GUI.
 
 Therefore, to build a docker container for iCEcube2 you'll need to follow a few steps:
 
 1) Run the installer with `make`. 
 
 2) Choose `/opt/icecube2` as the installation destination.
 
 3) When prompted for a license file, enter/browse to `/opt/icecube2/license.dat`.
 
 4) When the install completes, uncheck the "Run iCEcube2 Now" option and exit the installer.
 
 5) When the installer exits, the image build process continues.
 
 You should then be able to launch iCEcube2 by entering `make run`.
