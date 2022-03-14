#Author: Sudarshan Rai
shopt -s xpg_echo #Used to make sure that echo command recognises \n and \t in newer versions of linux so that we dont have to add -e flag to every echo command
interface_names=$(ip -o link show | awk -F ': ' '{print $2}') #Piped the output of ip command that lists the device info to only list the device names
arr_of_interface_names=($interface_names) #Converted the interface names into an array using ()
for device_name in ${arr_of_interface_names[@]} #Looping through the device names, have to use this strange syntax
do
    if echo "$device_name" | grep "enp\|eth" #Using echo to change device_name to a string and piping it grep to find the eth* or enp* devices
    then
        path="/etc/network/interfaces" #Setting the path of the file that needs to be changed or created in order to 
        echo "Enter your system number"
        read host_id
        host_id=$((host_id+10))
        echo "# interfaces(5) file used by ifup(8) and ifdown(8)\n">$path #Creating the file if it does not already exist or overwriting the file if it does exist
        echo "auto lo">>$path #Appending to the file
        echo "iface lo inet loopback\n">>$path

        echo "Assigning static ip address 192.168.10.$host_id..."
        echo "auto $device_name">>$path
        echo "\t iface $device_name inet static">>$path
        echo "\t address 192.168.10.$host_id">>$path
        echo "\t netmask 255.255.255.0">>$path

        echo "Restarting networking module..."
        #sudo /etc/init.d/networking restart
        echo "[DONE]: Static IP assigned, restart if changes not reflected..."
    fi
done