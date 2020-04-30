# ArchLinux使用程序
## 程序列表
- base base-devel 基础包
- xorg-server xorg-init xdialog xorg-apps 界面基础包
- gconf 解决libgconf-2.so.4缺失
- ttf-unifont siji-git xorg-fonts-misc polybar-git需要的包
- thunar 文件夹
- gvfs gvfs-mtp 自动挂载u盘、手机
- git git
- vi vim 编辑器
- pcmanfm 文件管理器
## 批量安装命令
- sudo pacman -S base base-devel xorg-server xorg-init thunar gvfs gvfs-mtp xdialog xorg-apps
- yaourt -S gconf ttf-unifont ttf-unifont siji-git xorg-fonts-misc