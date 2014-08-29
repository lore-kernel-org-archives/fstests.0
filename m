Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:46891 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbaH2Tmf (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 29 Aug 2014 15:42:35 -0400
From: Pavel Shilovsky <pshilovsky@samba.org>
Subject: [PATCH v3 1/3] generic/013: encapsulate remount during cleanup
Date: Fri, 29 Aug 2014 23:42:18 +0400
Message-Id: <1409341340-27031-2-git-send-email-pshilovsky@samba.org>
In-Reply-To: <1409341340-27031-1-git-send-email-pshilovsky@samba.org>
References: <1409341340-27031-1-git-send-email-pshilovsky@samba.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, samba-technical@samba.org, David Disseldorp <ddiss@suse.de>, Steve French <smfrench@gmail.com>
List-ID: <fstests@vger.kernel.org>

The existing code calls remount for $TEST_DEV with constantly defined
mount options. This can fail if a user specifies different mount options.
Fix this by using new _test_remount() call that remounts $TEST_DEV.

Reviewed-by: Steve French <smfrench@gmail.com>
Signed-off-by: Pavel Shilovsky <pshilovsky@samba.org>
---
 common/rc         | 6 ++++++
 tests/generic/013 | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 16da898..d9c9995 100644
--- a/common/rc
+++ b/common/rc
@@ -218,6 +218,12 @@ _test_mount()
     _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
 }
 
+_test_remount()
+{
+    $UMOUNT_PROG $TEST_DEV
+    _test_mount
+}
+
 _scratch_mkfs_options()
 {
     _scratch_options mkfs
diff --git a/tests/generic/013 b/tests/generic/013
index 93d9904..534c9f0 100755
--- a/tests/generic/013
+++ b/tests/generic/013
@@ -35,7 +35,7 @@ _cleanup()
 {
     cd /
     # we might get here with a RO FS
-    mount -o remount,rw $TEST_DEV >/dev/null 2>&1
+    _test_remount
     # now remove fsstress directory.
     # N.B. rm(1) on IRIX can find problems when building up a long pathname
     # such that what it has is greater the 1024 chars and will
-- 
1.9.1

