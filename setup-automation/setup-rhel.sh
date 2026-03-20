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

# Create Scott's "helpful" email in rhel's home directory
echo "Creating email from Manager Scott..." >> /tmp/progress.log
cat > /home/rhel/email_from_scott.txt << 'EOF'
From: Manager Scott <scott@super-business.local>
To: IT Team <it@super-business.local>
Date: $(date '+%Y-%m-%d %H:%M')
Subject: Gave devuser log access - you're welcome!

Hey team,

Just wanted to let you know I took care of that ticket from devuser. They needed
to be able to read some protected log files for troubleshooting their application
issues. I know you all are super busy with that big migration project, so I went
ahead and handled it myself.

I added a sudoers rule so devuser can use 'less' to view any log files they need.
Pretty clever, right? This way they can read the logs but can't actually modify
anything or mess with the system. Security win!

The rule is in /etc/sudoers.d/devuser-logs if you want to check my work.

You're welcome,
Scott

P.S. - I'm thinking of putting together a "Sudo Best Practices" training. I've
gotten pretty good at this stuff!
EOF

# Create InfoSec alert in rhel's home directory
echo "Creating InfoSec alert..." >> /tmp/progress.log
cat > /home/rhel/infosec_alert.txt << 'EOF'
SECURITY ALERT - INVESTIGATION REQUIRED
========================================
Priority: HIGH
Date: $(date '+%Y-%m-%d')
From: Information Security Team

Our Security Information and Event Management (SIEM) system has detected
suspicious privilege escalation activity on server rhel.super-business.local.

FINDINGS:
---------
• User 'devuser' has been observed executing commands with root privileges
• The privilege escalation method does NOT match normal sudo usage patterns
• Root-level file system modifications detected from devuser's session
• Activity pattern suggests unauthorized privilege escalation

EVIDENCE:
---------
The following suspicious activity was logged:
  - devuser obtained root shell access on 3 separate occasions
  - Created files in /root directory
  - Modified system configuration files
  - Accessed sensitive log files beyond normal scope

REQUIRED ACTION:
----------------
1. Investigate how devuser is gaining root privileges
2. Identify the misconfiguration or vulnerability being exploited
3. Document the escalation method for our security records
4. Remediate the vulnerability immediately
5. Report findings to InfoSec team

This does NOT appear to be a compromise of devuser's account. The activity
suggests they are exploiting a legitimate system misconfiguration to gain
unauthorized elevated privileges.

Please treat this as URGENT. Contact Sysadmin Nate if you need guidance.

--
InfoSec Incident Response Team
EOF

# Create Nate's helpful note
echo "Creating note from Nate..." >> /tmp/progress.log
cat > /home/rhel/note_from_nate.txt << 'EOF'
Hey,

Saw the InfoSec alert. Yeah, this is probably another one of Scott's "helpful"
moments. He mentioned he gave devuser some kind of sudo access to read logs.

I haven't had a chance to dig into it yet - been dealing with the storage array
migration. But knowing Scott, he probably created a sudo rule without fully
understanding the implications.

Some things to check:
  • Look in /etc/sudoers.d/ - Scott likes to add rules there
  • Read Scott's email (should be in your home directory)
  • Check what commands devuser can actually run with sudo
  • Remember: some commands can do more than they appear to do

The InfoSec alert says devuser got a root shell somehow through their sudo
access. So whatever Scott allowed them to run... it can probably spawn a shell.

Tools that can spawn shells when run with elevated privileges:
  • Editors (vi, vim, nano, emacs)
  • Pagers (less, more)
  • File operations (find, tar, zip)
  • Many others...

GTG Checker (https://gtfobins.github.io/) is a good resource for this kind of
thing, but you can probably figure it out by looking at what Scott gave them
access to and testing it yourself.

Good luck. Let me know when you've got it sorted.

-Nate

P.S. - When you fix it, maybe we should implement a policy that Scott can't
modify sudoers files anymore. Just a thought.
EOF

# Set ownership
chown rhel:rhel /home/rhel/email_from_scott.txt
chown rhel:rhel /home/rhel/infosec_alert.txt
chown rhel:rhel /home/rhel/note_from_nate.txt

# Create some simulated auth log entries showing devuser's sudo usage
# (This would normally be in /var/log/secure but we'll create a summary)
echo "Creating log summary..." >> /tmp/progress.log
cat > /home/rhel/suspicious_activity_log.txt << 'EOF'
SUMMARY OF SUSPICIOUS SUDO ACTIVITY
====================================
Extracted from /var/log/secure

[2025-03-18 14:23:17] devuser : TTY=pts/0 ; PWD=/home/devuser ; USER=root ; COMMAND=/usr/bin/less /var/log/messages
[2025-03-18 14:24:33] devuser : TTY=pts/0 ; PWD=/home/devuser ; USER=root ; COMMAND=/usr/bin/less /var/log/secure
[2025-03-18 14:25:01] ROOT SHELL DETECTED - devuser session elevated to UID 0
[2025-03-18 14:26:15] File created: /root/test_file.txt by UID 0 (originated from devuser session)

[2025-03-19 09:15:42] devuser : TTY=pts/1 ; PWD=/home/devuser ; USER=root ; COMMAND=/usr/bin/less /var/log/audit/audit.log
[2025-03-19 09:16:58] ROOT SHELL DETECTED - devuser session elevated to UID 0
[2025-03-19 09:17:22] Modified: /etc/hosts by UID 0 (originated from devuser session)

[2025-03-20 11:33:07] devuser : TTY=pts/0 ; PWD=/home/devuser ; USER=root ; COMMAND=/usr/bin/less /var/log/dnf.log
[2025-03-20 11:34:19] ROOT SHELL DETECTED - devuser session elevated to UID 0

ALERT: Pattern indicates privilege escalation via allowed sudo command
EOF
chown rhel:rhel /home/rhel/suspicious_activity_log.txt

echo "Lab setup complete" >> /tmp/progress.log
