#!/bin/sh
echo "Module 2 solve script - running participant commands" >> /tmp/progress.log

# Commands from module 2
su - rhel -c "sudo -i -u devuser sudo -l" > /dev/null 2>&1
su - rhel -c "sudo ls -la /etc/sudoers.d/" > /dev/null 2>&1
su - rhel -c "sudo cat /etc/sudoers.d/devuser-logs" > /dev/null 2>&1
su - rhel -c "sudo ls -l /etc/sudoers.d/devuser-logs" > /dev/null 2>&1

echo "Module 2 commands completed" >> /tmp/progress.log
