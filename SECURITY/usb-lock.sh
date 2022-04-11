#!/bin/bash
session=$(loginctl | grep 'cse' | awk '{print $1;}')
#Change the 'cse' to your corresponding computer name, your username can be found by using $USER in the terminal
#Using $USER in the grep command itself doesn't seem to work for some reason
#echo $session
if [ "${1}" == "lock" ]; then #Had to put the ${1} inbetween "" cause of some error
  loginctl lock-session ${session}
elif [ "${1}" == "unlock" ]; then
  loginctl unlock-session ${session}
fi
