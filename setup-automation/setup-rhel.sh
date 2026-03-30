#!/bin/bash
USER=rhel

echo "Adding wheel" > /root/post-run.log
usermod -aG wheel rhel

echo "Setup vm rhel" > /tmp/progress.log

chmod 666 /tmp/progress.log

# Create the "developer" user that Scott "helped"
echo "Creating developer account..." >> /tmp/progress.log
useradd -m -s /bin/bash devuser
echo "devuser:SecurePass123!" | chpasswd

# Create Manager Scott's flawed sudoers rule
# This allows devuser to run less with sudo, which can spawn a shell!
echo "Creating sudoers rule..." >> /tmp/progress.log
cat > /etc/sudoers.d/devuser-logs << 'EOF'
# Added by Manager Scott - devuser needs to view protected log files
devuser ALL=(root) NOPASSWD: /usr/bin/less
EOF
chmod 0440 /etc/sudoers.d/devuser-logs

echo "Lab setup complete" >> /tmp/progress.log
