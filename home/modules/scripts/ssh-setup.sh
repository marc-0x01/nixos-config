#!/bin/bash

SSHDIR="$HOME/.ssh"

# Get keys from the vault
# NOTE: This is only for my personal keys, pro keys are in a corporate vault

cd $SSHDIR

echo "*** Setup SSH keys from the Vault ***"
out=$(rbw login)
if [ $? -ne 0 ];
then
    echo "Login Failed"
    exit 1
else
    echo "Logging Succeeded"
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

echo -n "Locking and purging database... "
out=$(rbw purge)
if [ $? -ne 0 ];
then
    echo "Failed"
    exit 1
else
    echo "Succeeded"
fi

echo -n "Done "
echo
exit 0
