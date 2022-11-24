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


### Method 2: [Install Ubuntu 20.04 then add L4T](https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html)

####    Section 1: Upgrade of the Ubuntu system 
1. Get SD Card atleast 16 GB of free space
2. Check Ubuntu version
    ```
    #prints Ubuntu version number (ex. 18.04)
    lsb_release -a
    ```
3. Remove software packages you don't need immediately (like LibreOffice, Chromium, and OpenCV)
   
   Note: removal of programs helps speed up this process and you can reinstall later
    ```
    #remove libreoffice 
    sudo apt-get remove --purge libreoffice*
    
    #remove chromium browser
    sudo apt-get remove --purge chromium-browser chromium-browser-l10n
    
    #remove OpenCV
    sudo apt-get purge '*opencv*'
    
    #remove firefox
    sudo apt-get purge firefox
    ```    
4. When step 3 is done, update, upgrade, and clean up your system with the following commands:
   
   Note: make sure to connect to the internet
    ``` 
    #update your system
    sudo apt-get update 
    
    #upgrade your system
    sudo apt-get upgrade   
    
    #autoremove specific packages from linux
    sudo apt-get autoremove
    ```    
   
5. use the sed command which will automatically edit and save the file /etc/update-manager/release-upgrades

    Note: "-i" will save the content and you cannot undo changes

    ```
    #if Prompt is set to never, change to lts, and save 
    sudo sed -i 's/=never/=lts/' /etc/update-manager/release-upgrades


    #if Prompt is set to normal, change to lts, and save 
    sudo sed -i 's/=normal/=lts/' /etc/update-manager/release-upgrades
    ```

6. refresh your system, upgrade your distro, and reboot
    ```
    #update your system
    sudo apt-get update
    
    #upgrade your distro
    sudo apt-get dist-upgrade
    
    #reboot your system
    sudo reboot
    ```
7. all preparations are finished. This step is to upgrade to Ubuntu 20 (took 30+ min)
    ```
    #upgrade your Ubuntu version release
    sudo do-release-upgrade
    ```
8. enter <kbd>Y</kbd> when prompted "Do you want to start the upgrade?" followed by text about packages
9. enter <kbd>Y</kbd> when prompted "Remove obsolete packages?" followed by text about packages (100+ packages)
    
    Note: this next step is **<ins>important.</ins>** We still need to finish editing files.
    
10. enter <kbd>N</kbd> when prompted "Restart required. [...] To finish the upgrade, a restart is required."
11. use the sed command which will check if this line ```WaylandEnabe=false```is active in /etc/gdm3/custom.conf
    ```
    #uncomment and enable the line (WaylandEnable=false) found in /etc/gdm3/custom.conf
    sed -i 's/# WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf

    #incase there is no space in between the '#' and 'W'
    sed -i 's/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/custom.conf
    ```    
    
12. use the sed command which will uncomment (by removing the "#" before the line) ```# Driver "nvidia"``` in the file /etc/X11/xorg.conf
    ```
    #uncomment and enable the line (Driver "nvidia") found in /etc/X11/xorg.conf 
    sed 's/# Driver "nvidia"/Driver "nvidia"/' /etc/X11/xorg.conf 

    #incase there is no space in between the '#' and 'W'
    sed 's/#Driver "nvidia"/Driver "nvidia"/' /etc/X11/xorg.conf 
    ```

13. this command will reset the upgrade manager to "never" in the file /etc/update=manager/release-upgrades    
    ```
    #set Prompt is never 
    sudo sed -i 's/=lts/=never/' /etc/update-manager/release-upgrades
    ```

14. reboot
    ```
    sudo reboot
    ```
    
####    Section 2: The post-upgrade configuration    
15. check Ubuntu version
    ```
    lsb_release -a
    ```
16. delete directory /usr/share/vulkan/icd.d
    ```
    sudo rm -rf /usr/share/vulkan/icd.d
    ```
17. updates
    ```
    #update your system
    sudo apt-get update 
    
    #upgrade your system
    sudo apt-get upgrade   
    
    #autoremove specific packages from linux
    sudo apt-get autoremove
    ```
18. Remove circular symlink
    ```
    sudo rm /usr/share/applications/vpil_demos
    ```
19. remove distorted nvidia logo in top bar
    ```
    #change into the directy called /usr/share/nvpmodel_indicator
    cd /usr/share/nvpmodel_indicator
    
    #move the contents of file "nv_logo.svg" to file "no_logo.svg"
    sudo mv nv_logo.svg no_logo.svg
    ```
20. remove the "#" before the line ```# deb file:///var/visionworks-repo / # disabled on upgrade to focal``` in the file /etc/apt/sources.list.d/visionworks-repo.list 
    ```
    sudo sed -i 's/# deb file/deb file/' /etc/apt/sources.list.d/visionworks-repo.list 
    ```
21. gcc update (install gcc, g++ version 8, and setup the gcc selector)
    ```    
    #install GNU compiler collection to run programs written in C (gcc) and C++ (g++)
    sudo apt-get install gcc-8 g++-8        
    
    # add gcc (C) version 9 to selector
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
    
    # add gcc (C) version 8 to selector
    sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
    
    # add g++ (C++) version 9 to selector
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
    
    # add g++ (C++) version 8 to selector
    sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
    
    # setup the gcc selector
    sudo update-alternatives --config gcc
    
    # setup the g++ selector
    sudo update-alternatives --config g++
    ```
    Note: select option 1 from list, it should say **Path** is /usr/bin/g++-8 and **Priority** is 8, not 9
    
22. install firefox if not already automatically installed
    Note: do not install Chromium because it will interfere with Snap installation
    ```
    sudo apt install firefox
    ```
23. upgrade
    ```
    sudo apt-get upgrade
    ```
24. fix correct version
    ```
    #fix broken install
    sudo apt --fix-broken install
    
    #overwrite nvidia-l4t-init file
    sudo dpkg -i --force-overwrite /var/cache/apt/archives/nvidia-l4t-init_32.6.1-20210916211029_arm64.deb
    ```
25. overwrite /etc/systemd/sleep.conf (force upgrade)
    Note: location of nvidia-l4t-init file is given in the output of the previous fix-broken command from step 23.
    ```
    sudo dpkg -i --force-overwrite
    ```
26. nvidia-l4t-init should be installed successfully, now upgrade
    ```
    sudo apt-get upgrade
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

