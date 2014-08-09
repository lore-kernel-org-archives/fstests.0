Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:52002 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbaHIFSQ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 9 Aug 2014 01:18:16 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] xfstests: allow chacl to be in any directory in $PATH
Date: Sat,  9 Aug 2014 01:18:08 -0400
Message-Id: <1407561488-30412-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Previously, xfstests checked for chacl in only a few hard-coded
directory: /bin, /sbin, and /usr/bin.  Use set_prog_path to allow
chacl to be in any directory in $PATH, which is how we find the
executable path for most other executables.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/attr   | 4 +---
 common/config | 1 +
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/common/attr b/common/attr
index 42a1a16..f33166e 100644
--- a/common/attr
+++ b/common/attr
@@ -165,9 +165,7 @@ _filter_aces_notypes()
 
 _require_acls()
 {
-    if [ ! -x /bin/chacl -a ! -x /usr/bin/chacl -a ! -x /sbin/chacl ]; then
-    	_notrun "chacl command not found"
-    fi
+    [ -n $CHACL_PROG ] || _notrun "chacl command not found"
 
     #
     # Test if chacl is able to list ACLs on the target filesystems.  On really
diff --git a/common/config b/common/config
index 0dbf0b9..10cc6fe 100644
--- a/common/config
+++ b/common/config
@@ -168,6 +168,7 @@ export XFSRESTORE_PROG="`set_prog_path xfsrestore`"
 export XFSINVUTIL_PROG="`set_prog_path xfsinvutil`"
 export GETFATTR_PROG="`set_prog_path getfattr`"
 export SETFATTR_PROG="`set_prog_path setfattr`"
+export CHACL_PROG="`set_prog_path chacl`"
 export ATTR_PROG="`set_prog_path attr`"
 export QUOTA_PROG="`set_prog_path quota`"
 export XFS_QUOTA_PROG="`set_prog_path xfs_quota`"
-- 
2.0.0

