Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67FCCA473
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 00:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiFBAbh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 20:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbiFBAbe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 20:31:34 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0901929B2CF
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 17:31:33 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 9F3B110E6FDF
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 10:31:30 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkK-001b7L-V0
        for fstests@vger.kernel.org; Thu, 02 Jun 2022 10:31:28 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nwYkK-00CBbD-U1
        for fstests@vger.kernel.org;
        Thu, 02 Jun 2022 10:31:28 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 3/8] generic/081: don't run on DAX capable devices
Date:   Thu,  2 Jun 2022 10:31:21 +1000
Message-Id: <20220602003126.2903779-4-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220602003126.2903779-1-david@fromorbit.com>
References: <20220602003126.2903779-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=629804e2
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=JPEYwPQDsx4A:10 a=20KFwNOVAAAA:8 a=ZX5orWydIAkmiaoJ8_sA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

LVM/DM has conniptions when you try to use snapshots on a device
that has DAX capability. It first sets up the underlying device as a
DAX capable mapping (type 3 or DM_TYPE_DAX_BIO_BASED) but because
snapshots require COW and shared mappings, it isn't supported on DAX
capable devices. Hence creating the snapshot device fails because it
requires a type 1 (DM_TYPE_BIO_BASED) device and DM can't change
types on a loaded mapping.

Hence we get this obscure error message in the log:

device-mapper: ioctl: can't change device type (old=3 vs new=1) after initial table load.

and these obscure, unhelpful error messages from the LVM command
outputs:

  device-mapper: reload ioctl on  (251:0) failed: Invalid argument
  Failed to suspend logical volume vg_081/base_081.
  Device vg_081-base_081-real (251:1) is used by another device.
  Failed to revert logical volume vg_081/base_081.
  Aborting. Manual intervention required.
Failed to create snapshot

How to turn off DAX capability is not documented in dmsetup or LVM
man pages, nor is dax mentioned anywhere in
Documentation/admin/device-mapper/ so I have no idea how to tell
LVM/DM "don't try to enable DAX support!".

As such, if the uderlying block device is dax capable, skip this
test.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/rc | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/common/rc b/common/rc
index 2f31ca46..c334cfbf 100644
--- a/common/rc
+++ b/common/rc
@@ -2116,21 +2116,33 @@ _require_sane_bdev_flush()
 # Decide if the scratch filesystem is likely to be mounted in fsdax mode.
 # It goes 3 ways based on mount options::
 #	1. "dax" or "dax=always" means always test using DAX
-#	2. "dax=never" means we'll never use DAX
+#	2. "dax=never" means we'll never use DAX.
 #	3. "dax=inode" or nothing means "use scratch dev capability" to
 #	    determine whether DAX is going to be used.
 #
-# Returns 0 if DAX will be used, 1 if DAX is not going to be used.
+# Case 2 and 3 basically mean the same thing for the purpose of
+# _require_dm_target(). If the fs is not forcing the use of DAX, then DAX
+# can only be enabled if the underlying block device supports it.
+#
+# Returns 0 if the filesytem will use DAX, 1 if it won't.
 __scratch_uses_fsdax()
 {
 	local ops=$(_normalize_mount_options "$MOUNT_OPTIONS")
 
 	echo $ops | egrep -qw "dax(=always| |$)" && return 0
-	echo $ops | grep -qw "dax=never" && return 1
+	return 1
+}
 
+# Determine if the scratch device is DAX capable. Even if the fs is not
+# using DAX, we still can't use certain device mapper targets if the block
+# device is DAX capable. Hence the check needs to be separat from the FS
+# capability.
+__scratch_dev_has_dax()
+{
 	local sysfs="/sys/block/$(_short_dev $SCRATCH_DEV)"
 	test -e "${sysfs}/dax" && return 0
 	test "$(cat "${sysfs}/queue/dax" 2>/dev/null)" = "1" && return 0
+
 	return 1
 }
 
@@ -2147,15 +2159,18 @@ _require_dm_target()
 	_require_sane_bdev_flush $SCRATCH_DEV
 	_require_command "$DMSETUP_PROG" dmsetup
 
-	if __scratch_uses_fsdax; then
-		case $target in
-		stripe|linear|log-writes)
-			;;
-		*)
-			_notrun "Cannot run tests with DAX on $target devices."
-			;;
-		esac
-	fi
+	case $target in
+	stripe|linear|log-writes)
+		;;
+	*)
+		if __scratch_uses_fsdax; then
+			_notrun "Cannot run tests with fsdax on $target devices."
+		fi
+		if __scratch_dev_has_dax; then
+			_notrun "Cannot use $target devices on DAX capable block devices."
+		fi
+		;;
+	esac
 
 	modprobe dm-$target >/dev/null 2>&1
 
-- 
2.35.1

