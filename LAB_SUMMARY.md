# Sudo Privilege Escalation Hunt Lab

## Overview
A comprehensive troubleshooting lab where participants investigate and remediate a privilege escalation vulnerability caused by a misconfigured sudo rule.

## Lab Scenario
Manager Scott tried to help developer "devuser" by giving them sudo access to view log files using the `less` command. However, this created a critical security vulnerability because `less` can spawn shells when run with sudo privileges.

The InfoSec team detected suspicious root access from the devuser account, and participants must:
1. Investigate the security alert
2. Find the misconfigured sudo rule
3. Understand how the vulnerability works
4. Properly remediate the issue

## Module Breakdown

### Module 1: The Alert (Introduction)
- **Objective**: Understand the security incident
- **Content**: InfoSec alert, Manager Scott's email, Sysadmin Nate's guidance
- **Activities**: Read incident documentation and evidence logs
- **Solve Button**: false (informational module)

### Module 2: Finding the Misconfiguration
- **Objective**: Locate the vulnerable sudo configuration
- **Content**: Understanding sudo, investigating /etc/sudoers.d/, identifying the flaw
- **Activities**: Check sudo permissions, examine sudoers files
- **Key Learning**: Understanding sudo rule syntax and common dangerous commands
- **Solve Button**: true

### Module 3: Testing the Vulnerability
- **Objective**: Demonstrate the privilege escalation in a controlled way
- **Content**: Hands-on exploitation using `!bash` and other less features
- **Activities**: Switch to devuser, exploit the sudo rule, verify root access
- **Key Learning**: How innocent-looking commands can be exploited
- **Solve Button**: true

### Module 4: Remediation
- **Objective**: Fix the vulnerability properly
- **Content**: Multiple remediation approaches, implementing least-privilege solution
- **Activities**: Remove vulnerable rule, implement group-based permissions
- **Key Learning**: Security best practices and proper access control
- **Solve Button**: true

## Personas Used

### Manager Scott
- Created the vulnerable sudo rule with good intentions
- Demonstrates the danger of insufficient security knowledge
- Provides realistic "well-meaning but wrong" scenario

### Sysadmin Nate
- Provides helpful guidance and context
- Offers hints without giving away complete solutions
- Represents experienced mentor figure

### InfoSec Team
- Provides the initial alert and evidence
- Demonstrates realistic security monitoring and detection

## Technical Implementation

### The Vulnerability
```bash
# /etc/sudoers.d/devuser-logs
devuser ALL=(root) NOPASSWD: /usr/bin/less
```

**The Exploit:**
1. User runs: `sudo /usr/bin/less /var/log/messages`
2. While in less, user types: `!bash`
3. Less spawns a bash shell with root privileges
4. User now has complete root access

### The Remediation
**Removed:** Dangerous sudo rule

**Implemented:** Group-based permissions
```bash
groupadd logreaders
usermod -aG logreaders devuser
chgrp logreaders /var/log/messages
chmod g+r /var/log/messages
```

## Learning Outcomes

Participants will learn:
1. **Security Investigation**: How to respond to privilege escalation alerts
2. **Sudo Security**: Understanding command capabilities beyond their primary purpose
3. **GTFOBins Awareness**: Knowledge of commands that can be exploited (less, vim, find, etc.)
4. **Least Privilege**: Implementing access controls that meet business needs securely
5. **Incident Response**: Documenting findings and remediation steps

## Setup Automation

The lab automatically creates:
- `devuser` account with password
- Vulnerable sudo rule in `/etc/sudoers.d/devuser-logs`
- Manager Scott's email explaining what he did
- InfoSec alert with evidence
- Sysadmin Nate's helpful note with guidance
- Simulated suspicious activity logs

## Validation

Each module validates:
- **Module 1**: Presence of all documentation files
- **Module 2**: Vulnerable sudo rule exists and is correctly identified
- **Module 3**: Vulnerability still exploitable (before remediation)
- **Module 4**: Sudo rule removed, group created, permissions set, no sudo access remains

## Key Files

### Configuration
- `config/instances.yaml` - Single RHEL 10 VM with 4G RAM
- `config/networks.yaml` - Default network only
- `config/firewall.yaml` - HTTPS egress only

### Setup
- `setup-automation/setup-rhel.sh` - Creates vulnerable environment and documentation

### Runtime Scripts (per module)
- `setup-rhel.sh` - Module initialization
- `solve-rhel.sh` - Automated solution for testing
- `validation-rhel.sh` - Validates module completion

## Real-World Relevance

This lab teaches a critical real-world skill. Privilege escalation through sudo misconfigurations is:
- **Common**: Many admins don't understand full command capabilities
- **Dangerous**: Grants complete system control
- **Subtle**: Audit logs show "authorized" sudo usage
- **Preventable**: With proper review and least-privilege design

The GTFOBins project (gtfobins.github.io) documents hundreds of Unix binaries that can be exploited this way, making this a well-known class of vulnerability in the security community.

## Extension Possibilities

This lab could be extended with:
- Additional vulnerable commands (vim, find, tar, etc.)
- SIEM log analysis exercises
- Automated sudo rule auditing scripts
- Comparison of different remediation approaches
- Post-incident forensics activities
