# lanturn
A meta-repository used for guides, scripts and other useful information for the
Lanturn RoboSub

<!-- TODO: add image of lanturn -->

## TODO
- [ ] downlaod all github repos script
    - [ ] Add a safety catch for when directories already exist when cloning github repositories
    - [ ] 
- [ ] Make sure ~/local/bin is in PATH environment
- [ ] Add home/ directory for configuration files
- [ ] Add a WORKSPACE variable
- [ ] Add SSH source script
- [ ] Automate set up of configuration files and repositories
- [ ] Describe Tegra X2 module and carrier board
- [ ] Automate auto login set up
- [ ] Add a directory to save rosbag files to
- [ ] Add commands for SSH login
- [ ] Add instructions on how to use Fathom-X


## Nvidia Jetson TX2 
<!-- indlude schematic for carrier board -->
<!-- explain usage of sdk manager -->
<!-- manage nvidias's sdk with sdk manager -->
<!-- what sdks from nvidia do we use? -->
Lanturn uses the [Nvidia Jetson TX2 Module](https://developer.nvidia.com/embedded/jetson-tx2)
connected to the carrier board (P2597) that comes with the
[Nvidia Jetson TX2 Developer Kit](https://developer.download.nvidia.com/embedded/L4T/r32-3-1_Release_v1.0/jetson_tx2_developer_kit_user_guide.pdf).
However, in the future, the carrier board will be switched out with a
[Quasar Carrier Board](https://connecttech.com/product/quasar-carrier-nvidia-jetson-tx2/).

### Nvidia SDK Manager
To flash, back up and upgrade the software in the TX2, download the 
[Nvidia SDK Manager](https://developer.nvidia.com/nvidia-sdk-manager)

## Setting up Ubuntu 20 on the TX2

### Method 1: Install L4T with SDK Manager then upgrade to Ubuntu 20.04

<!-- Flash TX2 with Ubuntu 18.04 -->
### Flash the TX2

Connect the computer with the SDK Manager to the TX2's Micro-USB AB connector.

Once connected, launch the SDK Manager and boot up the TX2 in Recovery Mode.


### Method 2: Install Ubuntu 20.04 then add L4T

1. Get SD Card atleast 16 GB of free space
2. Check Ubuntu version
    ```
    $ lsb_release -a
    ```
3. Remove software packages you don't need immediately (like LibreOffice, Chromium, and OpenCV)
   
   Note: removal of programs helps speed up this process and you can reinstall later
    ```
    $ sudo apt-get remove --purge libreoffice*
    $ sudo apt-get remove --purge chromium-browser chromium-browser-l10n
    $ sudo apt-get purge '*opencv*'
    $ sudo apt-get purge firefox
    ```    
4. get nano installed to edit files, or use vim if preferred
    ```
    $ sudo apt-get install nano
    ```
5. When step 3 is done, update, upgrade, and clean up your system with the following commands:
   
   Note: make sure to connect to the internet
    ``` 
    $ sudo apt-get update 
    $ sudo apt-get upgrade   
    $ sudo apt-get autoremove
    ```    
6. use the nano command to edit the file /etc/update-manager/release-upgrades
   ```
   $ sudo nano /etc/update-manager/release-upgrades
   ```
   set the ```prompt=lts```
   This will enable distribution upgrades in the update manager 
   
   Note: to close nano, use the following: 
   
   <kbd>Ctrl</kbd> + <kbd>X</kbd>, then <kbd>Y</kbd>, then <kbd>Enter</kbd>
7. refresh your system, upgrade your distro, and reboot
    ```
        $ sudo apt-get update
        $ sudo apt-get dist-upgrade
        $ sudo reboot
    ```
8. all preparations are finished. This step is to upgrade to Ubuntu 20 (took 30 min)
    ```
    $ sudo do-release-upgrade
    ```
7. enter <kbd>Y</kbd> when prompted "Do you want to start the upgrade?" followed by text about packages
8. enter <kbd>Y</kbd> when prompted "Remove obsolete packages?" followed by text about packages (100+ packages)
Note: this next step is **IMPORTANT.** We still need to finish editing files.
9. enter <kbd>N</kbd> when prompted "Restart required" followed by "To finish the upgrade, a restart is required."
10. check if this line ```WaylandEnabe=false```is active in /etc/gdm3/custom.conf
    ```
    $ sudo nano /etc/gdm3/custom.conf
    ```
11. Uncomment (remove the "#" before the line) ```# Driver "nvidia"``` in the file /etc/X11/xorg.conf
    ```
    $ sudo nano /etc/X11/xorg.conf
    ```
12. Reset the upgrade manager to ```never``` in the file /etc/update=manager/release-upgrades
    ```
    $ sudo nano /etc/update=manager/release-upgrades
    ```
13. reboot
    ```
    $ sudo reboot
    ```
14. check Ubuntu version
    ```
    $ lsb_release -a
    ```
15. delete directory /usr/share/vulkan/icd.d
    ```
    $ sudo rm -rf /usr/share/vulkan/icd.d
    ```
16. updates
    ```
    $ sudo apt-get update
    $ sudo apt-get upgrade
    $ sudo apt-get autoremove
    ```
17. Remove circular symlink
    ```
    $ sudo rm /usr/share/applications/vpil_demos
    ```
18. remove distorted nvidia logo in top bar
    ```
    $ cd /usr/share/nvpmodel_indicator
    $ sudo mv nv_logo.svg no_logo.svg
    ```
19. remove the "#" before the line ```# deb file:///var/visionworks-repo / # disabled on upgrade to focal``` in the file /etc/apt/sources.list.d/visionworks-repo.list 
    ```
    $ sudo nano /etc/apt/sources.list.d/visionworks-repo.list 
    ```
20. gcc update (install gcc, g++ version 8, and setup the gcc selector)
    ```    
    $ sudo apt-get install gcc-8 g++-8    
    $ sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
    $ sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
    $ sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
    $ sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
    $ sudo update-alternatives --config gcc
    $ sudo update-alternatives --config g++
    ```
    Note: select option 1 from list, it should say **Path** is /usr/bin/g++-8 and **Priority** is 8, not 9
21. install firefox if not still uninstalled
    Note: do not install Chromium because it will interfere with Snap installation
    ```
    $ sudo apt install firefox
    ```
22. upgrade
    ```
    $ sudo apt-get upgrade
    ```
23. fix correct version
    ```
    $ sudo apt --fix-broken install
    $ sudo dpkg -i --force-overwrite /var/cache/apt/archives/nvidia-l4t-init_32.6.1-20210916211029_arm64.deb
    ```
24. overwrite /etc/systemd/sleep.conf (force upgrade)
    Note: location of nvidia-l4t-init file is given in the output of the previous fix-broken command
    ```
    $ sudo dpkg -i --force-overwrite
    ```
25. nvidia-l4t-init should be installed successfully, now upgrade
    ```
    $ sudo apt-get upgrade
    ```
 
<!-- add nvidia ppa -->
<!-- install a specific version of jetpack -->


## Setup SSH
Lanturn has a [Fathom-X](https://bluerobotics.com/store/comm-control-power/tether-interface/fathom-x-tether-interface-board-set-copy/)
onboard, which can be used to establish a connection with another computer.

### Auto login
To SSH into the TX2, auto login needs to be enabled.

The assumption is that the TX2 is using gnome display manager.

Configure automatic login through gsettings or by editing the
/etc/gdm3/custom.conf file.
```
# make a back up of the /etc/gdm3/custom.conf file
sudo cp /etc/gdm3/custom.conf /etc/gdm3/custom.conf.bak

# edit the /etc/gdm3/custom.conf
sudo nano /etc/gdm3/custom.conf
```
Add the configuration for automatic login.
```
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=username
```

