# Communications Updates Summary for zt-sudo-privesc-hunt

This document summarizes all the communication updates needed to apply the consistent theme across all modules.

## Theme Guidelines

**Manager Scott:**
- Vague about technical details
- Overly confident but not knowledgeable
- Doesn't give away the answer
- Might deflect or minimize when things go wrong
- Means well but doesn't understand the implications

**Sysadmin Nate:**
- Experienced and somewhat weary
- Shares war stories about Scott's previous "help"
- Provides guidance without giving direct answers
- Casual, colleague-to-colleague tone
- Acknowledges Scott means well but is dangerous

**InfoSec:**
- Professional and formal
- Provides facts and evidence
- Clear about urgency and requirements
- Doesn't speculate on root cause

## Files to Update

### 1. Module 01 - COMPLETE REWRITE
**File:** `content/modules/ROOT/pages/module-01.adoc`
**Action:** Replace entire file with `module-01-revised.adoc`
**Changes:**
- All communications moved inline (no more cat ~/file.txt)
- InfoSec alert as NOTE block
- Scott's email as quote block (vague, no technical details)
- Nate's message as quote block (shares previous Scott incidents)
- Evidence log as inline source block

### 2. Setup Script - SIMPLIFY
**File:** `setup-automation/setup-rhel.sh`
**Action:** Replace with `setup-rhel-revised.sh`
**Changes:**
- Remove all text file creation (lines 25-162 in original)
- Keep only: devuser creation + sudoers rule creation
- From ~165 lines to ~25 lines

### 3. Module 02 - UPDATE ONE QUOTE
**File:** `content/modules/ROOT/pages/module-02.adoc`
**Line:** 108
**Action:** Replace Nate's quote
**From:** Technical explanation about GTFOBins
**To:** Story about previous Scott incident with `find -exec`, then mentions GTFOBins casually

**New version:**
```adoc
[quote, Sysadmin Nate]
____
Yep, classic mistake. I've seen this pattern before.

Scott gave someone sudo to `find` once because "they just need to search for files." Didn't realize find has `-exec` that can run any command as root. That was a fun afternoon.

The problem is that a lot of Unix tools do way more than their name suggests. Viewers can edit. Editors can run shells. Search tools can execute commands. If you give someone sudo to ANY of these, you're basically giving them root access with extra steps.

There's actually a whole catalog of binaries that can be exploited like this - GTFOBins or something like that. Worth looking at before you approve any sudo request.
____
```

### 4. Module 03 - UPDATE SCOTT'S QUOTE
**File:** `content/modules/ROOT/pages/module-03.adoc`
**Line:** 202
**Action:** Replace Scott's "lesson learned" quote
**From:** Self-aware reflection about his mistake
**To:** Defensive email that minimizes and deflects

**Option 1 (Defensive, doesn't get it):**
```adoc
[quote, Manager Scott <scott@super-business.local>]
____
*RE: About that devuser sudo thing*

Hey,

So I heard from InfoSec there was some kind of issue with that sudo rule I created. I'm still not entirely clear on what the problem is - I gave them access to a FILE VIEWER. How is that a security risk?

Anyway, I guess going forward you guys want to handle the sudo configurations. That's fine, I've got plenty of other high-priority items on my plate.

Let me know if you need me to update any documentation about this.

Scott

*P.S. - I still think the core idea was sound, just maybe less wasn't the right tool. What about more? That's even more limited, right?*
____
```

**Option 2 (Slightly aware but still deflecting):**
```adoc
[quote, Manager Scott <scott@super-business.local>]
____
*RE: About that devuser access*

Look, I get that there was technically a way someone could exploit what I set up, but let's be real here - devuser is a trusted developer. They weren't actually TRYING to get root access, they just needed to read logs.

Maybe less wasn't the perfect choice, but the real issue is that we need better tools for this kind of thing. I was trying to solve a business problem with the tools available.

Going forward I guess I'll loop you in on these things, but honestly the whole sudo system seems overly complicated if you ask me.

Scott
____
```

### 5. Module 04 - NO CHANGES NEEDED
**File:** `content/modules/ROOT/pages/module-04.adoc`
**Line:** 337 (Nate's final quote)
**Status:** Already good - appropriate tone, wraps up well

## Application Order

1. Replace `setup-automation/setup-rhel.sh` with revised version
2. Replace `content/modules/ROOT/pages/module-01.adoc` with revised version
3. Update quote in `content/modules/ROOT/pages/module-02.adoc` line 108
4. Update quote in `content/modules/ROOT/pages/module-03.adoc` line 202 (choose Option 1 or 2)

## Verification

After updates, verify:
- No `cat ~/` commands remain in module-01
- No text files created in setup script (except /tmp/progress.log)
- Scott never gives specific technical details
- Nate provides context through stories, not direct answers
- Communications feel realistic (email/Slack appropriate)
