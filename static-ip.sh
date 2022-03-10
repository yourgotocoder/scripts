#Script to assign a static IP

echo "Enter network interface name: "
read interface_name
path="/etc/network/interfaces"
echo "Enter your system number"
read host_id
host_id=$((host_id+10))
echo "# interfaces(5) file used by ifup(8) and ifdown(8)\n">$path
echo "auto lo">>$path
echo "iface lo inet loopback\n">>$path

echo "Assigning static ip address 192.168.10.$host_id..."
echo "auto $interface_name">>$path
echo "\t iface $interface_name inet static">>$path
echo "\t address 192.168.10.$host_id">>$path
echo "\t netmask 255.255.255.0">>$path

echo "Restarting networking module..."
#/etc/init.d/networking restart
echo "[DONE]: Static IP assigned, restart if changes not reflected..."
