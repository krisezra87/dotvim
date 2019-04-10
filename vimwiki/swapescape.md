## How to swap capslock and escape

On linux systems running X, edit
> /etc/X11/xorg.conf.d/00-keyboard.conf

to include

Section "InputClass"
        Identifier "system-keyboard"
        MatchIsKeyboard "on"
        Option "XkbLayout" "us"
        Option "XkbModel" "pc105"
        Option "XkbOptions" "caps:swapescape"
EndSection

or create it if it doesn't exist.

This was taken from a reddit thread:
https://www.reddit.com/r/archlinux/comments/8b3w2d/swapping_caps_lock_with_escape_not_working_on/
