#!/bin/sh
echo "Module 1 solve script - running participant commands" >> /tmp/progress.log

# Switch to rhel user and run the commands from module 1
su - rhel -c "cat ~/infosec_alert.txt" > /dev/null 2>&1
su - rhel -c "ls -la ~/*.txt" > /dev/null 2>&1
su - rhel -c "cat ~/email_from_scott.txt" > /dev/null 2>&1
su - rhel -c "cat ~/note_from_nate.txt" > /dev/null 2>&1
su - rhel -c "cat ~/suspicious_activity_log.txt" > /dev/null 2>&1

echo "Module 1 commands completed" >> /tmp/progress.log
