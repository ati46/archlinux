# 使用记录
## 用户
- 新建组
    - sudo groupadd docker
- 把当前用户添加到组
    sudo gpasswd -a $USER docker
- 更新组
    newgrp docker
## systemctl
- 用户
    - 如果是普通用户创建systemctl，一定不要加sudo，会提示找不到文件的

## 更新时跳过某个包，两种方式
- 命令--pacman时使用--ignore 跳过指定的包
    - sudo pacman -Syu --ignore linux
- 配置
    - vim /etc/pacman.conf
        - 在IgnorePkg 中加入要跳过的包的名字

## git
- 初始化
    - git init
- 关联远程仓库
    - 先初始化
    - git remote add origin git_address

- 删除全局配置项
    - 查看git所有配置
        - git config --list
    - 删除项
        - 命令
            git config --global --unset user.name
        - 编辑
            git config --global --edit

## 目录记录
- i3 ~/.config
- polybar ~/.config
- .vimrc ~/
- .Xresources ~/
- .xinitrc ~/
- 30-touchpad.conf /etc/X11/xorg.conf.d
- xorg.conf /etc/X11
- .zshrc ~/
- dunst ~/.config
- compton ~/.config