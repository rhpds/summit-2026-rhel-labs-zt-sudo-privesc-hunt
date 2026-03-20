#!/bin/sh
echo "Validating module called module-01" >> /tmp/progress.log

# Module 1 is informational, just verify the files exist
if [ -f /home/rhel/infosec_alert.txt ] && \
   [ -f /home/rhel/email_from_scott.txt ] && \
   [ -f /home/rhel/note_from_nate.txt ] && \
   [ -f /home/rhel/suspicious_activity_log.txt ]; then
    echo "PASS: All required files exist"
    exit 0
else
    echo "FAIL: Required files are missing"
    exit 1
fi
