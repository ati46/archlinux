#!/usr/bin/env sh

# Terminate already running bar instances
#killall -q polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
#polybar base &
$HOME/.config/polybar/launch.sh &
nm-applet &
fcitx &
/usr/local/src/apps/electron-ssr-0.3.0-alpha.5.AppImage &
#flameshot &
# 电源
mate-power-manager &
# 蓝牙
#blueman-manager &
blueman-applet &
# 自动锁屏
xautolock -time 5 -locker 'i3lock -i ~/Pictures/lock.png' -notify 60 -notifier 'notify-send "一分钟后锁屏"' &

## 触摸板
#synclient TapButton1=1 # 一个手指轻触触摸板代表点击左键
#synclient TapButton2=3 # 两个手指轻触触摸板代表点击右键
#synclient TapButton3=2 # 三个手指轻触触摸板代表点击中键


echo "Bars launched..."

