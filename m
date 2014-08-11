Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:53698 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbaHKDI1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 10 Aug 2014 23:08:27 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] common: allow dmflakey tests to work without udev
Date: Sun, 10 Aug 2014 23:08:20 -0400
Message-Id: <1407726500-27480-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

If udev is not present, we need to run "dmsetup mknodes" to make sure
/dev/mapper/flakey-test is created or destroyed as appropriate.  On a
system with udev, running "dmsetup mknodes" will be a no-op.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/dmflakey | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/dmflakey b/common/dmflakey
index bc984bd..e55aefd 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -29,6 +29,7 @@ _init_flakey()
 	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
 	$DMSETUP_PROG create flakey-test --table "$FLAKEY_TABLE" || \
 		_fatal "failed to create flakey device"
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
 _mount_flakey()
@@ -48,6 +49,7 @@ _cleanup_flakey()
 	$DMSETUP_PROG resume flakey-test > /dev/null 2>&1
 	$UMOUNT_PROG $SCRATCH_MNT > /dev/null 2>&1
 	$DMSETUP_PROG remove flakey-test > /dev/null 2>&1
+	$DMSETUP_PROG mknodes > /dev/null 2>&1
 }
 
 # _load_flakey_table <table> [lockfs]
-- 
2.0.0

