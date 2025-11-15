#!/bin/bash
USERNAME='insert_your_username'
PUBKEY='insert_your_public_key'

adduser ${USERNAME} &&
cd /home/${USERNAME} &&
mkdir .ssh &&
echo ${PUBKEY} >> .ssh/authorized_keys &&
chown ${USERNAME}:${USERNAME} -R .ssh &&
chmod 700 -R .ssh/ &&
echo "$USERNAME      ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers
