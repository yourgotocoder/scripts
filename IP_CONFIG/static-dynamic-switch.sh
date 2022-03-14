#Author: Sudarshan Rai
shopt -s xpg_echo #Used to make sure that echo command recognises \n and \t in newer versions of linux so that we dont have to add -e flag to every echo command
interface_names=$(ip -o link show | awk -F ': ' '{print $2} {print $1}') #Piped the output of ip command that lists the device info to only list the device names
arr_of_interface_names=($interface_names) #Converted the interface names into an array using ()
device_name="" 
space="  "

function getDevice() {
    SELECT_DEVICE=$(whiptail --title "Select device" --fb --menu "Choose an option" 15 60 4 \
                "${arr_of_interface_names[@]}"  3>&1 1>&2 2>&3)
    device_name=$SELECT_DEVICE
    echo $device_name
}


function staticDynamic() {
    ubuntu_version=$1
    echo $ubuntu_version
    STATIC_OR_DYNAMIC=$(whiptail --title "Select network mode" --fb --menu "Choose an option" 15 60 4 \
                "1" "Static" \
                "2" "Dynamic"  3>&1 1>&2 2>&3)
    if [[ "$ubuntu_version" -eq 18 ]]
    then
        case $STATIC_OR_DYNAMIC in
        1)
            echo "SET STATIC IP"
            getDevice
            path="/etc/network/interfaces" #Setting the path of the file that needs to be changed or created in order to 
            IP_ADDRESS=$(whiptail --inputbox "Enter system number" 8 39 1 --title "Set IP for device" 3>&1 1>&2 2>&3)
            # A trick to swap stdout and stderr.
            # Again, you can pack this inside if, but it seems really long for some 80-col terminal users.
            exitstatus=$?
            if [ $exitstatus = 0 ]; then
                echo "System number entered by you: $IP_ADDRESS " 
            else
                echo "You selected Cancel."
            fi
            echo "# interfaces(5) file used by ifup(8) and ifdown(8)\n">$path #Creating the file if it does not already exist or overwriting the file if it does exist
            echo "auto lo">>$path #Appending to the file
            echo "iface lo inet loopback\n">>$path
            echo "Assigning static ip address 192.168.10.$IP_ADDRESS..."
            echo "auto $device_name">>$path
            echo "\t iface $device_name inet static">>$path
            echo "\t address 192.168.10.$IP_ADDRESS">>$path
            echo "\t netmask 255.255.255.0">>$path
            echo "Restarting networking module..."
            sudo /etc/init.d/networking restart
            echo "[DONE]: Static IP assigned, restart if changes not reflected..."
        ;;
        2)
            echo "SET DYNAMIC IP"
            getDevice
            path="/etc/network/interfaces"
            echo "# interfaces(5) file used by ifup(8) and ifdown(8)\n">$path #Creating the file if it does not already exist or overwriting the file if it does exist
            echo "auto lo">>$path #Appending to the file
            echo "iface lo inet loopback\n">>$path
            echo "Assigning dynamic ip address ..."
            echo "auto $device_name">>$path
            echo "\t iface $device_name inet dhcp">>$path

        ;;
    esac
    else
        case $STATIC_OR_DYNAMIC in
        1)
            echo "SET STATIC IP"
            getDevice
            path="/etc/netplan/01-network-manager-all.yaml"  
            IP_ADDRESS=$(whiptail --inputbox "Enter system number" 8 39 1 --title "Set IP for device" 3>&1 1>&2 2>&3)
            
            exitstatus=$?
            if [ $exitstatus = 0 ]; then
                echo "System number entered by you: $IP_ADDRESS " 
            else
                echo "You selected Cancel."
            fi
            echo "# Nework manager will all devices  on this system\n">$path 
            echo "network:">>$path 
            echo "$space version: 2">>$path
            echo "$space renderer: NetworkManager">>$path
            echo "$space ethernets:">>$path
            echo "$space$space $device_name:">>$path
            echo "$space$space$space dhcp4: false">>$path
            echo "$space$space$space addresses: [192.168.10.$IP_ADDRESS/24]">>$path
            echo "$space$space$space gateway4: 192.168.10.1">>$path
            echo "$space$space$space nameservers:">>$path
            echo "$space$space$space$space addresses: [8.8.8.8, 4.4.4.4]">>$path
            echo "Assigning static ip address 192.168.10.$IP_ADDRESS..."
            sudo netplan apply
            echo "Restarting networking module..."
            sudo service network-manager restart
            echo "[DONE]: Static IP assigned, restart if changes not reflected..."
        ;;
        2)
            echo "SET DYNAMIC IP"
            getDevice
            path="/etc/netplan/01-network-manager-all.yaml"
            echo "# Nework manager will all devices  on this system\n">$path 
            echo "network:">>$path 
            echo "$space version: 2">>$path
            echo "$space renderer: NetworkManager">>$path
            echo "$space ethernets:">>$path
            echo "$space$space $device_name:">>$path
            echo "$space$space$space dhcp4: true">>$path
            echo "Assigning dynami ip address"
            sudo netplan apply
            echo "Restarting networking module..."
            sudo service network-manager restart
            echo "[DONE]: Dynamic IP assigned, restart if changes not reflected..."
        ;;
    esac
    fi
    
}

function advancedMenu() {
    ADVSEL=$(whiptail --title "Select Ubuntu Version" --fb --menu "Choose the ubuntu version" 15 60 4 \
        "1" "Ubuntu 18 and lower" \
        "2" "Ubuntu 20"  3>&1 1>&2 2>&3)
    case $ADVSEL in
        1)
            echo "Ubuntu 18 and lower"
            staticDynamic 18
        ;;
        2)
            echo "Ubuntu 20"
            staticDynamic 20
        ;;
    esac
}
advancedMenu