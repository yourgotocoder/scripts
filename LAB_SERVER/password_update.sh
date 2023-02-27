#!/bin/bash

filename="users.csv"

while read line; do
  user=$(echo $line | cut -d ',' -f1)
  password=$(echo $line | cut -d ',' -f2)
  echo "Updating password for user $user"
  echo "$password" | passwd --stdin "$user"
  if [ $? -eq 0 ]; then
    echo "Password updated successfully for user $user"
  else
    echo "Error updating password for user $user"
  fi
done < "$filename"