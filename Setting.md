# 配置
## rofi and rofi 剪切板
``` shell
    //安装
        sudo pacman -S rofi 
        yaourt -S rofi-greenclip
    //配置服务
    //新建文件
        sudo vim /usr/lib/systemd/user/greenclip.service
    //加入以下内容
        [Unit]
        Description=Start greenclip daemon
        After=display-manager.service

        [Service]
        ExecStart=/usr/bin/greenclip daemon
        Restart=always
        RestartSec=5

        [Install]
        WantedBy=default.target
    //设置开机自启
        systemctl --user enable greenclip.service
    //设置立即启动
        systemctl --user start greenclip.service
    //创建新的开机启动时，确保 $HOME/.config/systemd/user/default.target.wants 没有同名文件
```
## 配置蓝牙
``` shell
    
```
## 配置触摸板
``` shell
    //安装
        pacman -S xf86-input-libinput
    //使用 xinput 检查自己的触摸板
        $ xinput
        ⎡ Virtual core pointer                    	id=2	[master pointer  (3)]
        ⎜   ↳ Virtual core XTEST pointer              	id=4	[slave  pointer  (2)]
        ⎜   ↳ Microsoft Surface Type Cover Mouse      	id=8	[slave  pointer  (2)]
        ⎜   ↳ Microsoft Surface Type Cover Consumer Control	id=9	[slave  pointer  (2)]
        ⎜   ↳ Microsoft Surface Type Cover Touchpad   	id=10	[slave  pointer  (2)]
        ⎜   ↳ IPTS Singletouch                        	id=14	[slave  pointer  (2)]
        ⎣ Virtual core keyboard                   	id=3	[master keyboard (2)]
            ↳ Virtual core XTEST keyboard             	id=5	[slave  keyboard (3)]
            ↳ Video Bus                               	id=6	[slave  keyboard (3)]
            ↳ Microsoft Surface Type Cover Keyboard   	id=7	[slave  keyboard (3)]
            ↳ gpio-keys                               	id=11	[slave  keyboard (3)]
            ↳ gpio-keys                               	id=12	[slave  keyboard (3)]
            ↳ IPTS Stylus                             	id=13	[slave  keyboard (3)]
            ↳ Microsoft Surface Type Cover Consumer Control	id=15	[slave  keyboard (3)]
    //使用 xinput list-props 'Microsoft Surface Type Cover Touchpad' 查看特性
        $ xinput list-props 'Microsoft Surface Type Cover Touchpad'                                            
        Device 'Microsoft Surface Type Cover Touchpad':
            Device Enabled (163):	1
            Coordinate Transformation Matrix (165):	1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
            libinput Tapping Enabled (316):	1
            libinput Tapping Enabled Default (317):	0
            libinput Tapping Drag Enabled (318):	1
            libinput Tapping Drag Enabled Default (319):	1
            libinput Tapping Drag Lock Enabled (320):	0
            libinput Tapping Drag Lock Enabled Default (321):	0
            libinput Tapping Button Mapping Enabled (322):	1, 0
            libinput Tapping Button Mapping Default (323):	1, 0
            libinput Natural Scrolling Enabled (298):	1
            libinput Natural Scrolling Enabled Default (299):	0
            libinput Disable While Typing Enabled (324):	1
            libinput Disable While Typing Enabled Default (325):	1
            libinput Scroll Methods Available (300):	1, 1, 0
            libinput Scroll Method Enabled (301):	1, 0, 0
            libinput Scroll Method Enabled Default (302):	1, 0, 0
            libinput Click Methods Available (326):	1, 1
            libinput Click Method Enabled (327):	0, 1
            libinput Click Method Enabled Default (328):	1, 0
            libinput Middle Emulation Enabled (305):	0
            libinput Middle Emulation Enabled Default (306):	0
            libinput Accel Speed (307):	0.500000
            libinput Accel Speed Default (308):	0.000000
            libinput Left Handed Enabled (312):	0
            libinput Left Handed Enabled Default (313):	0
            libinput Send Events Modes Available (283):	1, 1
            libinput Send Events Mode Enabled (284):	0, 0
            libinput Send Events Mode Enabled Default (285):	0, 0
            Device Node (286):	"/dev/input/event8"
            Device Product ID (287):	1118, 2498
            libinput Drag Lock Buttons (314):	<no items>
            libinput Horizontal Scroll Enabled (315):	1
    //配置功能
        sudo vim /etc/X11/xorg.conf.d/30-touchpad.conf
    //加入以下内容
        Section "InputClass"
            Identifier "Microsoft Surface Type Cover Touchpad"
            Driver "libinput"
            MatchIsTouchpad "on"
            
            Option "TapButton1" "1"            #单指敲击产生左键事件
            Option "TapButton2" "3"            #三指敲击产生中键事件
            Option "TapButton3" "2"            #双指敲击产生右键事件
            
            Option "VertEdgeScroll" "on"       #滚动操作：横向、纵向、环形
            Option "VertTwoFingerScroll" "on"
            Option "HorizEdgeScroll" "on"
            Option "HorizTwoFingerScroll" "on"
            Option "CircularScrolling" "on"
            Option "CircScrollTrigger" "2"

            Option "Tapping" "on"
            Option "ClickMethod" "clickfinger"
            Option "NaturalScrolling" "true"
            #Option "ScrollMethod" "edge"
            
            Option "EmulateTwoFingerMinZ" "40" #精确度
            Option "EmulateTwoFingerMinW" "8"
            Option "CoastingSpeed" "20"        #触发快速滚动的滚动速度

            Option "PalmDetect" "1"            #避免手掌触发触摸板
            Option "PalmMinWidth" "3"          #认定为手掌的最小宽度
            Option "PalmMinZ" "200"            #认定为手掌的最小压力值

            Option "AccelSpeed" "0.5"
        EndSection

```
## mpd
``` shell
    mpd --verbose --stdout --no-daemon
```

## gnome应用不适配.Xresources设置的DPI问题解决，以及docker-wxwork 使用xhost + 后依然无法显示界面的问题
``` shell
    //安装软件
        sudo pacman -S gnome-settings-daemon
    //执行程序
        /usr/lib/gsd-xsettings
        //注意执行之后系统的DPI会受到影响，对于高分屏是个灾难，必须重启才可以恢复到原有的DPI设置。需要进行如下设置
        //有一个解决方法就是先开启所有需要的应用，然后再执行这条命令开启企业微信，然后再取消这条命令，这样对于旧窗口dpi不受影响
    //四条命令不分先后，但缺一不可 //设置后即写入系统，慎重使用
        gsettings set org.gnome.desktop.interface text-scaling-factor 1.8
        gsettings set org.gnome.desktop.interface scaling-factor 2
        gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <1>}]"
        gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Xft/DPI', <158>}]"
        //scaling-factor 是整数， text-scaling-factor 是浮点数
        //字体大小似乎与'Xft/DPI'的值无关，仅取决于text-scaling-factor 。但对火狐窗口内鼠标指针缩放与'Xft/DPI'有关
    //设置启动生效，在.xinitrc 中加入以下内容
        exec /usr/lib/gsd-xsettings &
        exec gsettings set org.gnome.desktop.interface scaling-factor 2 &
        exec gsettings set org.gnome.desktop.interface text-scaling-factor 1.8 &
        exec gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <2>}]" &
        exec gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Xft/DPI', <158>}]" &
```
## xorg卡死
``` shell
    //安装xorg偶尔会出现界面卡死，系统正常。 特别双屏幕后更容易出现这种情况。
    //至今未查询到为何会出现这种情况
    //安装xfce4的所有包后就不会再出现卡死情况
    sudo pacman -S xfce4 xfce4-goodies
```

## xrandr 多屏幕设置
``` shell
    //终端输入 xrandr 查看显示信息
    $ xrandr                                                                                                                    
        Screen 0: minimum 320 x 200, current 5616 x 1824, maximum 16384 x 16384
        eDP-1 connected primary 2736x1824+0+0 (normal left inverted right x axis y axis) 260mm x 173mm
        2736x1824     59.96*+
        DP-1 connected 2880x1620+2736+0 (normal left inverted right x axis y axis) 436mm x 245mm
        1920x1080     60.00*+  59.94  
        1680x1050     59.88  
        1600x900      60.00  
        1280x1024     75.02    60.02  
        1440x900      59.90  
        1280x720      60.00    59.94  
        1024x768      75.03    70.07    60.00  
        800x600       72.19    75.00    60.32  
        720x480       60.00    59.94  
        640x480       75.00    72.81    60.00    59.94  
        720x400       70.08  
        DP-2 disconnected (normal left inverted right x axis y axis)

    //eDP-1 笔记本屏幕
    //DP-1 扩展屏幕
    //设置笔记本屏幕在扩展屏幕的左边
    // --scale 缩放比例 
    //eDP-1 --scale 0.99999x0.99999 主屏幕缩放0.9999 是因为xorg 双屏幕下鼠标会发生抖动，所以使用此命令来解决
    //DP-1 --scale 1.5x1.5 扩展屏幕1.5是因为 笔记本屏幕是高分屏DPI放大后，扩展屏幕也会放大，所以需要再次缩小
    //eDP-1 --left-of DP-1 笔记本屏幕在扩展屏幕的左边
    xrandr --auto --output eDP-1 --scale 0.99999x0.99999 --primary --output DP-1 --scale 1.5x1.5 --output eDP-1 --left-of DP-1
    
    //设置笔记本屏幕在扩展屏幕的下面，由于扩展屏幕的缩小的原因导致上下屏幕设置后会有部分屏幕重叠，需要计算显示区域
    xrandr --output eDP-1 --auto --pos 0x1728 --scale 0.99999x0.99999 --primary --output DP-1 --auto --pos 0x0 --scale 1.6x1.6
    //计算方式 -- 直接摘录某大神的 懒得自己话了
        基本上，--pos指定屏幕在虚拟屏幕空间中的左上角的位置。虚拟屏幕是覆盖整个物理屏幕的屏幕。这是指定屏幕位置的非常通用的方法
        (virtual screen coordinates)
            0        1366                 1366+1920
          0           A-----------------------
                      |                      |
                      |                      |
                      |                      |
         x? B---------|         HDMI         |
            |         |                      |
            |  LVDS   |       1920x1080      |
            |1366x768 |                      |
        1080 ----------------------------------
        并且您需要在--pos选项中使用A和B的坐标。 x可以很容易地将其求解为1080-768 = 312，因此A为（1366,0），而B为（0,312）。
        因此，合适的--pos选项对于HDMI是--pos 1366x0，对于LVDS是--pos 0,312。您不必再指定虚拟屏幕的大小，它会自动调整大小。
        请注意，这--pos可能会被滥用，例如在两个屏幕之间造成孔洞或重叠。大多数（全部？）WM将无法解决该问题

    //如果不是高分屏只需要使用以下命令即可实现上下屏幕
    xrandr --output eDP-1 --below DP-1 --output DP-1 
```
## 自动锁屏
``` shell
    //没有操作5分钟后自动锁屏， 锁屏使用i3lock，锁屏前一分钟通过dunst弹出提示语
    xautolock -time 5 -locker 'i3lock -i ~/Pictures/lock.png' -notify 60 -notifier 'notify-send "一分钟后锁屏"'
```

## 休眠挂起 --更改电源键为挂起操作
``` shell
    编辑 /etc/systemd/logind.conf 修改对应的按钮事件
        事件处理程序                描述                                                                    默认动作
        HandlePowerKey          按下电源键后的动作                                                          poweroff
        HandleSuspendKey        按下挂起键后的动作                                                          suspend
        HandleHibernateKey      按下休眠键后触发的动作                                                      hibernate
        HandleLidSwitch         笔记本翻盖后触发的动作，除了下面的情况	                                    suspend
        HandleLidSwitchDocked   如果笔记本放到了扩展坞或连接了多个显示器时，笔记本翻盖合上时触发的动作	    ignore
        
    修改后需要运行 systemctl restart systemd-logind 使上述更改生效。
```