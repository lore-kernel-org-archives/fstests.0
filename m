Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757615AbeD0IW7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Apr 2018 04:22:59 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0C84140676C0
        for <fstests@vger.kernel.org>; Fri, 27 Apr 2018 08:22:59 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-165.pek2.redhat.com [10.72.12.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13301215CDCB
        for <fstests@vger.kernel.org>; Fri, 27 Apr 2018 08:22:57 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs: limit xfs_growfs size if test with --large-fs
Date: Fri, 27 Apr 2018 16:22:54 +0800
Message-Id: <20180427082254.25524-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When test on large SCRATCH_DEV, grow a small XFS to huge size is a
horrible thing (e.g grow 128m to 500T). So add a helper named
_scratch_xfs_growfs_limited() to do below things:

1) If --large-fs is used, limit growfs size.
2) If a limit size parameter is specified, make sure growfs won't
beyond this size.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/xfs    | 34 ++++++++++++++++++++++++++++++++++
 tests/xfs/002 |  2 +-
 tests/xfs/127 |  2 +-
 tests/xfs/233 |  2 +-
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/common/xfs b/common/xfs
index e0bc3f43..6200297c 100644
--- a/common/xfs
+++ b/common/xfs
@@ -721,3 +721,37 @@ _require_xfs_db_write_array()
 	rm -f $TEST_DIR/$seq.img
 	[ $supported -eq 0 ] && _notrun "xfs_db write can't support array"
 }
+
+# If test on large device or a limit size is specified, this helper make sure
+# xfs_growfs won't beyond this limit (try to grow 10 times current fs size by
+# default).
+#   usage: _scratch_xfs_growfs_limited [size_by_byte]
+_scratch_xfs_growfs_limited()
+{
+
+	local limit_size="$1"
+	local option=""
+
+	if [ "$LARGE_SCRATCH_DEV" = "yes" -o -n "$limit_size" ]; then
+		local tmp=`mktemp -u`
+		xfs_info $SCRATCH_MNT | _filter_mkfs > /dev/null 2>$tmp.info
+		. $tmp.info
+		rm -f $tmp.info
+
+		local fs_size=$((dbsize * dblocks))
+		local dev_size_kb=`_get_device_size $SCRATCH_DEV`
+
+		# default limit_size is 10 times current fs size.
+		if [ -z "$limit_size" ]; then
+			limit_size=$((fs_size * 10))
+		fi
+		# don't limit growfs size if device size is smaller
+		if [ $((dev_size_kb * 1024)) -gt $limit_size ]; then
+			option="-D $((limit_size / dbsize))"
+		else
+			option=""
+		fi
+	fi
+
+	$XFS_GROWFS_PROG $option $SCRATCH_MNT
+}
diff --git a/tests/xfs/002 b/tests/xfs/002
index 741117be..42d2e2d7 100755
--- a/tests/xfs/002
+++ b/tests/xfs/002
@@ -68,7 +68,7 @@ _scratch_xfs_db -x -c "sb 2" -c "type data" -c "write fill 0xff 224 4"
 _scratch_mount
 
 # This should pass
-$XFS_GROWFS_PROG $SCRATCH_MNT >> $seqres.full 2>&1 || _fail "growfs failed"
+_scratch_xfs_growfs_limited >> $seqres.full 2>&1 || _fail "growfs failed"
 
 # success, all done
 status=0
diff --git a/tests/xfs/127 b/tests/xfs/127
index 9df99904..c05fcee9 100755
--- a/tests/xfs/127
+++ b/tests/xfs/127
@@ -61,7 +61,7 @@ _cp_reflink $testdir/original $testdir/copy1
 _cp_reflink $testdir/copy1 $testdir/copy2
 
 echo "Grow fs"
-$XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
+_scratch_xfs_growfs_limited 2>&1 | _filter_growfs >> $seqres.full
 _scratch_cycle_mount
 
 echo "Create more reflink copies"
diff --git a/tests/xfs/233 b/tests/xfs/233
index e61c444d..a0dd42e7 100755
--- a/tests/xfs/233
+++ b/tests/xfs/233
@@ -59,7 +59,7 @@ cp -p $testdir/original $testdir/copy1
 cp -p $testdir/copy1 $testdir/copy2
 
 echo "Grow fs"
-$XFS_GROWFS_PROG $SCRATCH_MNT 2>&1 |  _filter_growfs >> $seqres.full
+_scratch_xfs_growfs_limited 2>&1 |  _filter_growfs >> $seqres.full
 _scratch_cycle_mount
 
 echo "Create more copies"
-- 
2.14.3

