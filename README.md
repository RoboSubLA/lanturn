# lanturn
A meta repository used for guides, scripts and other useful information for the Lanturn RoboSub

## TODO
- [] Add a safety catch for when directories already exist when cloning github repositories
- [] Make sure ~/.local/bin is in PATH environment
- [] Add home/ directory for configuration files
- [] Add a WORKSPACE variable
- [] Automate set up of configuration files and repositories


## Nvidia Tegra X2 
<!-- indlude schemaric for carrier board -->
<!-- explain usage of sdk manager -->
<!-- manage nvidias's sdk with sdk manager -->
<!-- what sdks from nvidia do we use? -->

### Nvidia SDK Manager
To flash, back up and upgrade the software in the TX2, download the 
[Nvidia SDK Manager](https://developer.nvidia.com/nvidia-sdk-manager)

## Setting up Ubuntu 20 on the TX2

### Method 1: Install L4T with SDK Manager then upgrade to Ubuntu 20.04

<!-- Flash TX2 with Ubuntu 18.04 -->
<!-- add nvidia ppa -->
<!-- install a specific version of jetpack -->

### Method 2: Install Ubuntu 20.04 then add L4T


### Flash the TX2

Connect the computer with the SDK Manager to the TX2's Micro-USB AB connector.

Once connected, launch the SDK Manager and boot up the TX2 in Recovery Mode.


## Set SSH
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

