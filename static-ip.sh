#Script to assign a static IP
shopt -s xpg_echo
echo "Enter network interface name: "
read interface_name
path="/etc/network/interfaces"
echo "Enter your system number"
read host_id
host_id=$((host_id+10))
printf "# interfaces(5) file used by ifup(8) and ifdown(8)\n">$path
printf "auto lo">>$path
printf "iface lo inet loopback\n">>$path

printf "Assigning static ip address 192.168.10.$host_id..."
printf "auto $interface_name">>$path
printf "\t iface $interface_name inet static">>$path
printf "\t address 192.168.10.$host_id">>$path
printf "\t netmask 255.255.255.0">>$path

printf "Restarting networking module..."
#/etc/init.d/networking restart
printf "[DONE]: Static IP assigned, restart if changes not reflected..."
