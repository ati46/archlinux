#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
#exec compton -b &
#exec fcitx &
exec /usr/lib/gsd-xsettings &
#exec gsettings set org.gnome.desktop.interface scaling-factor 2 &
exec gsettings set org.gnome.desktop.interface text-scaling-factor 1.8 &
exec gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <1>}]" &
exec gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Xft/DPI', <158>}]" &
exec gsettings set org.gnome.desktop.interface scaling-factor 1 &
exec i3 -V >> ~/.config/i3/log/i3log-$(date + '%F-%k-%M-%S') 2>&1
#exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1
xrdb -merge ~/.Xresources
oneko -dog & # 桌面显示一只宠物，追逐鼠标
