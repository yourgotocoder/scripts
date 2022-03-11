#!/bin/bash
#Author: Sudarshan Rai
shopt -s xpg_echo #Used to make sure that echo command recognises \n and \t in newer versions of linux so that we dont have to add -e flag to every echo command
interface_names=$(ip -o link show | awk -F ': ' '{print $2}') #Piped the output of ip command that lists the device info to only list the device names
arr_of_interface_names=($interface_names) #Converted the interface names into an array using ()
if (whiptail --title "Static IP Tool" --yes-button "Ubuntu 18" --no-button "Ubuntu 20"  --yesno "Select your Ubuntu Version" 10 60) then
        for device_name in ${arr_of_interface_names[@]} #Looping through the device names, have to use this strange syntax
        do
            if echo "$device_name" | grep "^enp\|^eth" #Using echo to change device_name to a string and piping it grep to find the eth* or enp* devices
            then
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
            fi
        done
else
    #Handle case for Ubuntu 20 since it uses netplan to manage ip of network interfaces
    for device_name in ${arr_of_interface_names[@]} 
        do
            if echo "$device_name" | grep "^enp\|^eth" 
            then
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
                echo "\t version: 2">>$path
                echo "\t renderer: NetworkManager">>$path
                echo "\t ethernets:">>$path
                echo "\t\t $device_name:">>$path
                echo "\t\t\t dchp4: false">>$path
                echo "\t\t\t addresses: [192.168.10.$IP_ADDRESS/24]">>$path
                echo "\t\t\t gateway4: 192.168.10.1">>$path
                echo "\t\t\t nameservers:">>$path
                echo "\t\t\t\t addresses: [8.8.8.8, 4.4.4.4]">>$path
                echo "Assigning static ip address 192.168.10.$IP_ADDRESS..."
                sudo netplan apply
                echo "Restarting networking module..."
                sudo service network-manager restart
                echo "[DONE]: Static IP assigned, restart if changes not reflected..."
            fi
        done
fi
