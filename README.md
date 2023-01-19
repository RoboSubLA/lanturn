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
