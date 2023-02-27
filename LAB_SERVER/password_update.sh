#!/bin/bash

filename="users.csv"

while read line; do
  user=$(echo $line | cut -d ',' -f1)
  password=$(echo $line | cut -d ',' -f2)
  echo "Updating password for user cse_$user"
  echo "$password" | passwd --stdin "cse_$user"
  if [ $? -eq 0 ]; then
    echo "Password updated successfully for user cse_$user with $password"
  else
    echo "Error updating password for user cse_$user"
  fi
done < "$filename"