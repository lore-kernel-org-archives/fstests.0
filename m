Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:9164 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752982AbbDGB5F (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 6 Apr 2015 21:57:05 -0400
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1YfIl0-0000O8-W6
	for fstests@vger.kernel.org; Tue, 07 Apr 2015 11:56:51 +1000
Received: from dave by disappointment with local (Exim 4.82_1-5b7a7c0-XX)
	(envelope-from <dave@disappointment.disaster>)
	id 1YfIl0-0002tP-V2
	for fstests@vger.kernel.org; Tue, 07 Apr 2015 11:56:50 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] generic: LVM and ram disks don't play well
Date: Tue,  7 Apr 2015 11:56:50 +1000
Message-Id: <1428371810-11085-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

The "brd" kernel ram disk abuses BLKFLSBUF to mean "free all memory
in the ram drive" when in fact it actually means "flush all dirty
buffers to stable storage". the brd driver ignores BLKFLSBUF if
there is an active reference to the block device, (e.g. a fs is
mounted on it), but when a device is layered over the top of it
(e.g. dm-flakey, lvm devices, etc) then the applications and
filesystems hold references to the upper device, not the brd device.
Hence when the upper device passes down BLKFLSBUF to brd, it removes
all the pages in the brd, effectively erasing it.  This causes all
sorts of problems.....

Fix this by black listing "/dev/ramXXX" devices from tests that
require DM in some way. The _requires_sane_bdev_flush() macro is
called by the _requires_dm.... checks so that we don't have to
remember to add this to all new tests that use dm in some way.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc         | 34 +++++++++++++++++++++++-----------
 tests/generic/081 |  1 -
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/common/rc b/common/rc
index c5db0dd..ca8da7f 100644
--- a/common/rc
+++ b/common/rc
@@ -1305,26 +1305,38 @@ _require_block_device()
 	fi
 }
 
+# brd based ram disks erase the device when they receive a flush command when no
+# active references are present. This causes problems for DM devices sitting on
+# top of brd devices as DM doesn't hold active references to the brd device.
+_require_sane_bdev_flush()
+{
+	echo $1 | grep -q "^/dev/ram[0-9]\+$"
+	if [ $? -eq 0 ]; then
+		_notrun "This test requires a sane block device flush"
+	fi
+}
+
 # this test requires the device mapper flakey target
 #
 _require_dm_flakey()
 {
-    # require SCRATCH_DEV to be a valid block device
-    _require_block_device $SCRATCH_DEV
-    _require_command "$DMSETUP_PROG" dmsetup
+	# require SCRATCH_DEV to be a valid block device with sane BLKFLSBUF
+	# behaviour
+	_require_block_device $SCRATCH_DEV
+	_require_sane_bdev_flush $SCRATCH_DEV
+	_require_command "$DMSETUP_PROG" dmsetup
 
-    modprobe dm-flakey >/dev/null 2>&1
-    $DMSETUP_PROG targets | grep flakey >/dev/null 2>&1
-    if [ $? -eq 0 ]
-    then
-	:
-    else
-	_notrun "This test requires dm flakey support"
-    fi
+	modprobe dm-flakey >/dev/null 2>&1
+	$DMSETUP_PROG targets | grep flakey >/dev/null 2>&1
+	if [ $? -ne 0 ]; then
+		_notrun "This test requires dm flakey support"
+	fi
 }
 
 _require_dm_snapshot()
 {
+	_require_block_device $SCRATCH_DEV
+	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
 	modprobe dm-snapshot >/dev/null 2>&1
 	$DMSETUP_PROG targets | grep -q snapshot
diff --git a/tests/generic/081 b/tests/generic/081
index e242c4c..5d38c11 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -50,7 +50,6 @@ _supported_os Linux
 _require_test
 _require_scratch_nocheck
 _require_dm_snapshot
-_require_block_device $SCRATCH_DEV
 _require_command $LVM_PROG lvm
 
 echo "Silence is golden"
-- 
2.0.0

