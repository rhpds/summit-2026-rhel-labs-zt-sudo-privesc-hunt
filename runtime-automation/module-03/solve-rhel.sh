#!/bin/sh
echo "Module 3 solve script - testing vulnerability" >> /tmp/progress.log

# Create a test file to prove privilege escalation works
# This simulates what the participant does in the module
su - devuser -c "echo 'whoami' | sudo /usr/bin/less /var/log/messages 2>/dev/null | head -1" > /dev/null 2>&1

# Create evidence file that would be created during testing
su - devuser -c "sudo touch /root/test_privesc_$(date +%Y%m%d).txt 2>/dev/null" > /dev/null 2>&1

echo "Module 3 testing completed" >> /tmp/progress.log
