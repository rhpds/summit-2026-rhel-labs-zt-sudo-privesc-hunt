# Deployment Guide

## Lab Location
`generated/zt-sudo-privesc-hunt`

## Quick Start

### Local Testing
```bash
cd generated/zt-sudo-privesc-hunt
./utilities/lab-build
./utilities/lab-serve
```

Then open your browser to the URL shown.

### Clean Up
```bash
./utilities/lab-stop
./utilities/lab-clean
```

## Lab Configuration Summary

### Virtual Machine
- **Name**: rhel
- **Image**: rhel-10-0-07-09-25-3
- **Memory**: 4G
- **Cores**: 1
- **Disk**: 40G
- **Network**: default
- **Bootloader**: efi

### Firewall
- **Egress**: HTTPS (443) only

### Users Created
- **devuser**: Regular user with vulnerable sudo access (created during setup)
- **rhel**: Default user (added to wheel group)

## Module Structure

1. **Module 1 - The Alert** (Introduction, no solve button)
   - InfoSec alert and incident documentation
   - Manager Scott's email and Nate's guidance
   - Evidence logs

2. **Module 2 - Finding the Misconfiguration**
   - Investigating sudo configuration
   - Identifying the vulnerable rule
   - Understanding the security implications

3. **Module 3 - Testing the Vulnerability**
   - Controlled exploitation demonstration
   - Understanding command capabilities
   - Documenting the attack vector

4. **Module 4 - Remediation**
   - Removing the vulnerable configuration
   - Implementing proper access controls
   - Verification and testing

## The Vulnerability

### What Scott Created
```bash
# /etc/sudoers.d/devuser-logs
devuser ALL=(root) NOPASSWD: /usr/bin/less
```

### How It's Exploited
```bash
$ sudo /usr/bin/less /var/log/messages
# Inside less, type: !bash
# Now you have a root shell!
```

### Why It's Dangerous
- `less` can execute shell commands via `!command`
- `less` can open an editor via `v` (which can also spawn shells)
- When run with sudo, all spawned processes run as root
- Creates full privilege escalation from regular user to root

## The Fix

### Removed
- `/etc/sudoers.d/devuser-logs` (entire file deleted)

### Implemented
```bash
groupadd logreaders
usermod -aG logreaders devuser
chmod g+rx /var/log
chgrp logreaders /var/log/messages
chmod g+r /var/log/messages
```

This gives devuser read access to log files without any sudo privileges.

## Files Created During Setup

The setup script automatically creates:
- `/home/rhel/infosec_alert.txt` - Security alert
- `/home/rhel/email_from_scott.txt` - Manager Scott's email
- `/home/rhel/note_from_nate.txt` - Sysadmin Nate's guidance
- `/home/rhel/suspicious_activity_log.txt` - Evidence logs
- `/etc/sudoers.d/devuser-logs` - Vulnerable sudo rule
- `devuser` user account (password: SecurePass123!)

## Validation Points

Each module validates:
1. **Module 1**: All documentation files exist
2. **Module 2**: Vulnerable sudo rule is present and identified
3. **Module 3**: Vulnerability is still exploitable
4. **Module 4**:
   - Sudo rule removed
   - logreaders group created
   - devuser added to logreaders group
   - File permissions updated
   - No sudo access remains for devuser

## Learning Objectives

After completing this lab, participants will understand:
- How to investigate privilege escalation incidents
- The dangers of granting sudo access to interactive tools
- GTFOBins and command exploitation techniques
- Proper implementation of least-privilege access controls
- Security incident documentation and remediation

## Common Pitfalls for Lab Participants

1. **Trying to fix it in module 2 or 3** - Remediation is in module 4
2. **Just removing the sudo rule** - Module 4 also shows the proper way to meet the business need
3. **Not understanding why less is dangerous** - Module 3 provides hands-on demonstration
4. **Thinking any pager would be safe** - The lesson applies to many commands

## Educational Value

This lab teaches:
- **Real-world vulnerability**: Sudo misconfigurations are common
- **Security investigation**: Proper incident response workflow
- **Command capabilities**: Understanding tools beyond their primary purpose
- **Defense in depth**: Multiple ways to solve access control problems
- **Documentation**: Importance of thorough incident reporting

## Extension Ideas

Could be extended with:
- Additional vulnerable commands (vim, find, tar, etc.)
- Automated security scanning scripts
- Compliance reporting requirements
- Forensics exercises
- Multi-user scenarios
