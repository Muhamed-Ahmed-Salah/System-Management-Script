#! /bin/bash
LOGFILE="/home/muhamed/Embedded_linux/projects/bash/log.txt"
admin_mode() {
    echo -e "\nAdmin Mode" | tee -a "$LOGFILE"
    while true; do
        echo -e "\nAdmin Menu:"
        echo "1. System Info"  
        echo "2. Devices Info" 
        echo "3. Network Info"
        echo "4. Reboot system"
        echo "5. shutdown system"
        echo "6. Kernel logs"
        echo "7. Exit "
        read -p "Choose an option: " choice

        case $choice in
            1)
               sysinfo
                ;;
            2)
               devicesinfo
               
                ;;
            3)
               networkinfo
                ;;
            4)
                
                echo "The laptop will reboot in 10 s"| tee -a "$LOGFILE"
                sleep 10
                sudo reboot
                ;;
            5)
                echo "The laptop will shutdown in 10 s"| tee -a "$LOGFILE"
                sleep 10
                sudo shutdown now 
                ;;
            6) 
                echo -e "Kernel logs"| tee -a "$LOGFILE"
                dmesg | tee -a "$LOGFILE"
                sleep 3
                ;;
            7)
               break
                ;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac
    done
}


user_mode() {
    echo -e "\nUser Mode" | tee -a "$LOGFILE"
    while true; do
        echo -e "\nUser Menu:"
        echo "1. System Info"
        echo "2. Network Info"
        echo "3. Kernel logs"
        echo "4. Exit User Mode"
        read -p "Choose an option: " choice

        case $choice in
            1)
               sysinfo
                ;;
            2)
               networkinfo
                ;;
            3) 
                echo -e "Kernel logs"| tee -a "$LOGFILE"
                dmesg  | tee -a "$LOGFILE"
                sleep 3
                ;;
            4)
                break
                ;;
            *)
                echo "Invalid option. Please try again."
                ;;
        esac
    done
}

sysinfo(){
    echo -e "\nCPU"
    echo "CPU Temperature: $(($(cat /sys/class/thermal/thermal_zone0/temp) / 1000))°C" | tee -a "$LOGFILE"
    echo "CPU Frequency: $(grep 'cpu MHz' /proc/cpuinfo | head -n 1 ) MHz" | tee -a "$LOGFILE"

    echo -e "\nRAM"
    total_ram=$(grep MemTotal /proc/meminfo | awk '{print $2}')
 
    free_ram=$(grep MemFree /proc/meminfo | awk '{print $2}')
    
  
    total_ram_gb=$(echo "scale=2; $total_ram / 1024 / 1024" | bc)
    free_ram_gb=$(echo "scale=2; $free_ram / 1024 / 1024" | bc)

   
    ram_usage=$(echo "scale=2; 100 - ($free_ram * 100 / $total_ram)" | bc)
    echo "Total RAM: ${total_ram_gb} GB" | tee -a "$LOGFILE"
    echo "Free RAM: ${free_ram_gb} GB"   | tee -a "$LOGFILE" 
    echo "RAM Usage: ${ram_usage}%"      | tee -a "$LOGFILE"

    echo -e "\nDisk"
       disk_usage=$(df / | awk 'NR==2 {print $5}')
    free_space=$(df -h / | awk 'NR==2 {print $4}')
    
    echo "Disk Usage: ${disk_usage}"        | tee -a "$LOGFILE"
    echo "Free Disk Space: ${free_space}"   | tee -a "$LOGFILE"
    sleep 5
}

devicesinfo(){
 echo -e "\n1. Change CPU policy"
 echo "2. Set battery threshold"
 echo "3. Control PC LEDs "
 read -p "Choose an option: " choice

 if [ "$choice" -eq 1 ]; then
    echo  -e "\n1. Powersave"
    echo "2. Performance"
    read -p "Choose an option: " x

    if [ "$x" -eq 1 ]; then
        echo "Setting to Powersave mode..."| tee -a "$LOGFILE"
        echo "powersave" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
    elif [ "$x" -eq 2 ]; then
        echo "Setting to Performance mode..." | tee -a "$LOGFILE"
        echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 
    else
        echo "Invalid option. Please try again."
    fi
elif [ "$choice" -eq 2 ]; then
    echo -e "\nSet battery threshold (ex. 60%) "
    read -p "Enter the number: " x
    echo "$x" > /sys/class/power_supply/BAT0/charge_control_end_threshold
    echo "Set battery threshold=$x"| tee -a "$LOGFILE"
    sleep 1


elif [ "$choice" -eq 3 ]; then
    echo -e "\n1.Keyboard"
    echo "2.Capslock"
    echo "3.Numlock"
    read -p "Choose an option: " y
      if [ "$y" -eq 1 ]; then
       read -p "Enter 1 for High or 0 for Low: " z
        if [ "$z" -eq 0 ] ; then
          echo 0 > /sys/class/leds/dell\:\:kbd_backlight/brightness 
          echo "keyboard light is off " | tee -a "$LOGFILE"
        elif [ "$z" -eq 1 ];then 
          echo "1" > /sys/class/leds/dell\:\:kbd_backlight/brightness 
          echo "keyboard light is on "| tee -a "$LOGFILE"
        else
         echo "Invalid option. Please try again."
        fi
         
      elif [ "$y" -eq 2 ]; then
      read -p "Enter 1 for High or 0 for Low: " z
        if [ "$z" -eq 0 ]; then
         echo 0 >/sys/class/leds/input3\:\:capslock/brightness 
           echo "Capslock light is off "| tee -a "$LOGFILE"
        elif [ "$z" -eq 1 ]; then
           echo 1 >/sys/class/leds/input3\:\:capslock/brightness 
           echo "capslock light is on "| tee -a "$LOGFILE"
         else
         echo "Invalid option. Please try again."
        fi

      elif [ "$y" -eq 3 ]; then
        read -p "Enter 1 for High or 0 for Low: " z
        if [ "$z" -eq 0 ];then
          echo 0 > /sys/class/leds/input3\:\:numlock/brightness
          echo "numlock light is off "| tee -a "$LOGFILE" 
        
        elif [ "$z" -eq 1 ]; then
           echo 1 > /sys/class/leds/input3\:\:numlock/brightness 
           echo "numlock light is on "| tee -a "$LOGFILE"
         else
         echo "Invalid option. Please try again."
        fi

      else
         echo "Invalid option. Please try again."
    fi

else
    echo "Invalid option. Please try again."
fi
}


networkinfo(){

    echo -e "\nIP Number"| tee -a "$LOGFILE"
    ifconfig | grep 'inet 19'  | awk '{print $2}' | tee -a "$LOGFILE"

    echo -e "\nDNS"| tee -a "$LOGFILE"
    cat /etc/resolv.conf | grep nameserver |awk '{ print $2}' | tee -a "$LOGFILE"
    sleep 3


}

main() {
    touch log.txt
    if [ "$(id -u)" -eq 0 ]; then
      
        admin_mode
    else
 
        user_mode
    fi
}

main
