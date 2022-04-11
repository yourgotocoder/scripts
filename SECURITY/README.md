#### Use your usb pendrive as a key to automatically login and logout of your system (UBUNTU)
You will have to modify the udev rules in order to use your pendrive as a key for your linux system
First, use **sudo su** to gain super privileges.
Then **cd** to ***/etc/udev/rules.d***
Once you are in  ***/etc/udev/rules.d*** create a file called **80-usb.rules** using a text editor of your choice.
In that file, just copy paste the following code:

<code>
    ACTION=="add", SUBSYSTEMS=="usb", ATTR{idVendor}=="0781", ATTR{idProduct}=="558a", RUN+="/usr/local/bin/usb-lock.sh unlock"
    ACTION=="remove", SUBSYSTEMS=="usb", ENV{ID_VENDOR_ID}=="0781", ENV{ID_MODEL_ID}=="558a", RUN+="/usr/local/bin/usb-lock.sh lock"
</code>

Save that file and **cd** to ***/usr/local/bin***
Create a file called **usb-lock.sh** and copy paste the following lines of code into that file:

<code>
    session=$(loginctl | grep 'cse' | awk '{print $1;}')
    if [ "${1}" == "lock" ]; then
        loginctl lock-session ${session}
    elif [ "${1}" == "unlock" ]; then
        loginctl unlock-session ${session}
    fi
</code> 

Save that file and turn it into an executable file by typing **chmod +x usb-lcok.sh** into the terminal from the location of that  file

Once you are done with it, the udev rules will be updated automatically and your pendrive will act as a key for your system.
