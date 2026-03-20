#!/bin/sh
echo "Module 4 solve script - implementing remediation" >> /tmp/progress.log

# Remove the vulnerable sudo rule
rm -f /etc/sudoers.d/devuser-logs

# Create the logreaders group if it doesn't exist
if ! getent group logreaders > /dev/null 2>&1; then
    groupadd logreaders
fi

# Add devuser to the group
usermod -aG logreaders devuser

# Set permissions on /var/log
chmod g+rx /var/log

# Set permissions on messages log file
if [ -f /var/log/messages ]; then
    chgrp logreaders /var/log/messages
    chmod g+r /var/log/messages
fi

echo "Module 4 remediation completed" >> /tmp/progress.log
