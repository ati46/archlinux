read bright < '/sys/class/backlight/intel_backlight/brightness' 
v=0
v=$((5000 + $bright)) 
if [ $v -gt 96000 ]; then 
    v=96000 
# 96000为我的最大亮度，即max_brightness文件里面的值
fi 
echo $v > /sys/class/backlight/intel_backlight/brightness 
