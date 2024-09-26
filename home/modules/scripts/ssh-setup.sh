#!/bin/bash

SSHDIR="$HOME/.ssh"

# Get keys from the vault
# NOTE: This is only for my personal keys, pro keys are in a corporate vault

cd $SSHDIR

echo
echo -n "Login to the vault... "
out=$(rbw login)
if [ $? -ne 0 ];
then
    echo "Failed"
    exit 1
else
    echo "Succeeded"
fi

echo -n "Unlocking the vault... "
out=$(rbw unlock)
if [ $? -ne 0 ];
then
    echo "Failed"
    exit 1
else
    echo "Succeeded"
fi

echo -n "Fetching SSH keys... "
out=$(rbw get id-ed25519-key >> id-ed25519.key && rbw get id-ed25519-pub-default >> id-ed25519-pub.key)
if [ $? -ne 0 ];
then
    echo "Failed"
    exit 1
else
    echo "Succeeded"
fi

echo
echo -n "Locking and purging database... "
out=$(rbw purge)
if [ $? -ne 0 ];
then
    echo "Failed"
    exit 1
else
    echo "Succeeded"
fi

echo
echo -n "Done "
echo
exit 0
