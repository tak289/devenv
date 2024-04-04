#!/bin/bash

userexists="`grep -w ^ubuntu /etc/passwd`"
if [ -z "$userexists" ]
then
    echo "No user found to be deleted".
else
    echo "Deleting user ubuntu".
    deluser --remove-home ubuntu
fi

groupexists="`grep -w ^ubuntu /etc/group`"
if [ -z "$groupexists" ]
then
    echo "No group found to be deleted".
else
    echo "Deleting group ubuntu".
    groupdel ubuntu
fi
