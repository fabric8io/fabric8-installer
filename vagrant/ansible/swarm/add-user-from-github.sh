#!/bin/bash

for user in "$@"
do
  echo "Adding ${user}"
  useradd -m ${user}
  mkdir /home/${user}/.ssh
  curl https://github.com/${user}.keys >> /home/${user}/.ssh/authorized_keys
  chmod 700 /home/${user}/.ssh
  chmod 600 /home/${user}/.ssh/authorized_keys
  chown -R ${user}:${user} /home/${user}/.ssh
  usermod -a -G wheel ${user}
done
