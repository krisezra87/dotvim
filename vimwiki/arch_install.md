# ARCH INSTALL

#NETWORK on fresh boot
> systemctl start netctl
> get interfaces using: #ip link
> dhcpcd __interface__

#XORG
> pacman -S xorg-server xorg-apps

# Graphics Drivers
> pacman -S xf86-video-amdgpu

Install some default drivers as well:
> pacman -S xf86-video-vesa

#GNOME
Display manager
> pacman -S gdm
> systemctl enable gdm
> pacman -S gnome

For extra bullshit
> pacman -S gnome-extra

# Extras
> pacman -S gvim
> pacman -S git

#URXVT
pacman -S rxvt-unicode

#i3
pacman -S i3-wm

#SSH Capability
> pacman -S openssh

Edit /etc/ssh/sshd_config to allow password authentication
Restart the daemon
> systemctl restart sshd.service

