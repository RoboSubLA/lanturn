## Setting up Ubuntu 20 on the TX2

<!-- Flash TX2 with Ubuntu 18.04 -->
<!-- Another way to possibly do this is to flash the TX2 with an Ubuntu 20.04 image -->

These steps were grabbed from a guide by qengineering that upgrades a Jetson Nano to Ubuntu 20.04;
found [here](https://qengineering.eu/install-ubuntu-20.04-on-jetson-nano.html).

### Upgrade to Ubuntu 20.04 from 18.04

#### Section 1: Upgrade of the Ubuntu system 
1. Get SD Card at least 16 GB of free space

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
    
#### Section 2: The post-upgrade configuration    
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

