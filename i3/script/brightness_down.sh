read bright < '/sys/class/backlight/intel_backlight/brightness' 
v=0
v=$(($bright - 5000 )) 
 if [ $v -lt 1000 ]; then 
    v=1000 
fi 
echo $v > /sys/class/backlight/intel_backlight/brightness
