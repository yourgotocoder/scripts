## Use your usb pendrive as a key to automatically login and logout of your system (UBUNTU)

You will have to modify the udev rules in order to use your pendrive as a key for your linux system
First, use **sudo su** to gain super privileges.
Then **cd** to **_/etc/udev/rules.d_**
Once you are in **_/etc/udev/rules.d_** create a file called **80-usb.rules** using a text editor of your choice.
In that file, just copy paste the following code:

<code>
    ACTION=="add", SUBSYSTEMS=="usb", ATTR{idVendor}=="0781", ATTR{idProduct}=="558a", RUN+="/usr/local/bin/usb-lock.sh unlock"
    ACTION=="remove", SUBSYSTEMS=="usb", ENV{ID_VENDOR_ID}=="0781", ENV{ID_MODEL_ID}=="558a", RUN+="/usr/local/bin/usb-lock.sh lock"
</code>

<p>
    The value for <b>ATTR{idVendor}</b> i.e <b>0781</b> should be changed to the vendor id of your pendrive. You can get your pendrives' vendor id using the lsusb command to list all the usb devices in your computer.
</p>

<p>
    In my case running the command lsubs gave me multiple lines of output where <br/> 
    <b>Bus 001 Device 006: ID 0781:558a SanDisk Corp. Ultra</b> <br/> was of significance as it gave me the vendor id and the product, both of which I need for my script. Here <b>0781</b> is my vendor id and <b>558a</b> is my product id. You can figure out your pendrives' vendor and product ids using the same priciple.
</p>

Save that file and **cd** to **_/usr/local/bin_**
Create a file called **usb-lock.sh** and copy paste the following lines of code into that file:

<code>
    session=$(loginctl | grep 'cse' | awk '{print $1;}')
    if [ "${1}" == "lock" ]; then
        loginctl lock-session ${session}
    elif [ "${1}" == "unlock" ]; then
        loginctl unlock-session ${session}
    fi
</code>

Save that file and turn it into an executable file by typing **chmod +x usb-lock.sh** into the terminal from the location of that file

Once you are done with it, the udev rules will be updated automatically and your pendrive will act as a key for your system.

If your udev rules haven't been update automatically, type:
**sudo udevadm control --reload** from the terminal to activate the new rules or just **reboot**
