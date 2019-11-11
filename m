Return-Path: <SRS0=0kg8=ZD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844A4C17445
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62994214E0
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Nov 2019 14:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKKOuC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:50:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:52790 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726832AbfKKOuB (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 11 Nov 2019 09:50:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B63EFAE68;
        Mon, 11 Nov 2019 14:49:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 524DC1E4AD6; Mon, 11 Nov 2019 15:49:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <fstests@vger.kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eryu Guan <guaneryu@gmail.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] generic/050: Handle xfs quota special case with different output
Date:   Mon, 11 Nov 2019 15:49:52 +0100
Message-Id: <20191111144953.23871-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191111144953.23871-1-jack@suse.cz>
References: <20191111144953.23871-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Instead of faking output for the case of XFS with quotas, just use a
different output file with appropriate output.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/generic/050              | 62 ++++++++++++------------------------------
 tests/generic/050.cfg          |  1 +
 tests/generic/050.out.xfsquota | 25 +++++++++++++++++
 3 files changed, 43 insertions(+), 45 deletions(-)
 create mode 100644 tests/generic/050.out.xfsquota

diff --git a/tests/generic/050 b/tests/generic/050
index a8d648e5eede..1c275d8b0601 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -39,27 +39,15 @@ _require_norecovery
 features=""
 if ! _has_metadata_journaling $SCRATCH_DEV >/dev/null; then
 	features="nojournal"
+elif [ "$FSTYP" = "xfs" ] && echo "$MOUNT_OPTIONS" | grep -q quota ; then
+	# Mounting with quota on XFS requires a writable fs, which means
+	# we expect to fail the ro blockdev test with with EPERM.
+	features="xfsquota"
 fi
 _link_out_file "$features"
 
 _scratch_mkfs >/dev/null 2>&1
 
-filter_ro_mount() {
-	local arg=""
-
-	if [ -n "$expect_mount_failure" ]; then
-		arg="s|mount: $SCRATCH_MNT: permission denied|mount: device write-protected, mounting read-only|g"
-	fi
-	sed -e "$arg" | _filter_ro_mount
-}
-
-# Mounting with quota on XFS requires a writable fs, which means
-# we expect to fail the ro blockdev test with with EPERM.
-expect_mount_failure=
-if [ "$FSTYP" = "xfs" ] && echo "$MOUNT_OPTIONS" | grep -q quota ; then
-	expect_mount_failure=1
-fi
-
 #
 # Mark the device read-only
 #
@@ -70,25 +58,16 @@ blockdev --setro $SCRATCH_DEV
 # Mount it, and make sure we can't write to it, and we can unmount it again
 #
 echo "mounting read-only block device:"
-_try_scratch_mount 2>&1 | filter_ro_mount
-if [ "${PIPESTATUS[0]}" -eq 0 ]; then
-	echo "touching file on read-only filesystem (should fail)"
-	touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
-
-	#
-	# Apparently this used to be broken at some point:
-	#	http://oss.sgi.com/bugzilla/show_bug.cgi?id=807
-	#
-	echo "unmounting read-only filesystem"
-	_scratch_unmount 2>&1 | _filter_scratch
-elif [ -n "${expect_mount_failure}" ]; then
-	# Mount failed, so simulate EROFS instead of scribbling on root fs
-	echo "touching file on read-only filesystem (should fail)"
-	echo "touch: cannot touch 'SCRATCH_MNT/foo': Read-only file system"
-	echo "unmounting read-only filesystem"
-else
-	echo "Mount failed, though it wasn't supposed to!"
-fi
+_try_scratch_mount 2>&1 | _filter_ro_mount
+echo "touching file on read-only filesystem (should fail)"
+touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
+
+#
+# Apparently this used to be broken at some point:
+#	http://oss.sgi.com/bugzilla/show_bug.cgi?id=807
+#
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch
 
 echo "setting device read-write"
 blockdev --setrw $SCRATCH_DEV
@@ -124,16 +103,9 @@ _scratch_unmount 2>&1 | _filter_scratch | _filter_ending_dot
 # data recovery hack.
 #
 echo "mounting filesystem with -o norecovery on a read-only device:"
-_try_scratch_mount -o norecovery 2>&1 | filter_ro_mount
-if [ "${PIPESTATUS[0]}" -eq 0 ]; then
-	echo "unmounting read-only filesystem"
-	_scratch_unmount 2>&1 | _filter_scratch
-elif [ -n "${expect_mount_failure}" ]; then
-	# Mount failed, simulate correct output
-	echo "unmounting read-only filesystem"
-else
-	echo "Mount failed, though it wasn't supposed to!"
-fi
+_try_scratch_mount -o norecovery 2>&1 | _filter_ro_mount
+echo "unmounting read-only filesystem"
+_scratch_unmount 2>&1 | _filter_scratch
 
 echo "setting device read-write"
 blockdev --setrw $SCRATCH_DEV
diff --git a/tests/generic/050.cfg b/tests/generic/050.cfg
index c76bd473873b..1d9d60bc69a0 100644
--- a/tests/generic/050.cfg
+++ b/tests/generic/050.cfg
@@ -1 +1,2 @@
 nojournal: nojournal
+xfsquota: xfsquota
diff --git a/tests/generic/050.out.xfsquota b/tests/generic/050.out.xfsquota
new file mode 100644
index 000000000000..49b46241b39f
--- /dev/null
+++ b/tests/generic/050.out.xfsquota
@@ -0,0 +1,25 @@
+QA output created by 050
+setting device read-only
+mounting read-only block device:
+mount: /mnt-scratch: permission denied
+touching file on read-only filesystem (should fail)
+unmounting read-only filesystem
+umount: SCRATCH_DEV: not mounted.
+setting device read-write
+mounting read-write block device:
+touch files
+going down:
+unmounting shutdown filesystem:
+setting device read-only
+mounting filesystem that needs recovery on a read-only device:
+mount: device write-protected, mounting read-only
+mount: cannot mount device read-only
+unmounting read-only filesystem
+umount: SCRATCH_DEV: not mounted
+mounting filesystem with -o norecovery on a read-only device:
+mount: /mnt-scratch: permission denied
+unmounting read-only filesystem
+umount: SCRATCH_DEV: not mounted.
+setting device read-write
+mounting filesystem that needs recovery with -o ro:
+*** done
-- 
2.16.4

