Received: from mx1.redhat.com ([209.132.183.28]:52938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937218AbdEXOxF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 May 2017 10:53:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1576413AA1
        for <fstests@vger.kernel.org>; Wed, 24 May 2017 14:53:05 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-62.pek2.redhat.com [10.72.12.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C45EAEA68
        for <fstests@vger.kernel.org>; Wed, 24 May 2017 14:53:03 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/196: fallback to fail_writes for old kernel
Date: Wed, 24 May 2017 22:52:58 +0800
Message-Id: <1495637578-5255-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

linux XFS rename all "fail_writes" references to "drop_writes" in
v4.11. Some old kernel still use the name "fail_writes", e.g.
RHEL-7. For testing on old kernel, we need to fallback to
"fail_writes".

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/196 | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/196 b/tests/xfs/196
index b7d327e..e9b0649 100755
--- a/tests/xfs/196
+++ b/tests/xfs/196
@@ -53,7 +53,13 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_xfs_sysfs $(_short_dev $TEST_DEV)/drop_writes
+
+DROP_WRITES="drop_writes"
+# replace "drop_writes" with "fail_writes" for old kernel
+if [ -f /sys/fs/xfs/$(_short_dev $TEST_DEV)/fail_writes ];then
+	DROP_WRITES="fail_writes"
+fi
+_require_xfs_sysfs $(_short_dev $TEST_DEV)/${DROP_WRITES}
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
@@ -66,7 +72,7 @@ bytes=$((64 * 1024))
 $XFS_IO_PROG -f -c "pwrite 0 $bytes" $file >> $seqres.full 2>&1
 
 # Enable write drops. All buffered writes are dropped from this point on.
-echo 1 > /sys/fs/xfs/$sdev/drop_writes
+echo 1 > /sys/fs/xfs/$sdev/$DROP_WRITES
 
 # Write every other 4k range to split the larger delalloc extent into many more
 # smaller extents. Use pwrite because with write failures enabled, all
@@ -83,7 +89,7 @@ for i in $(seq 4096 8192 $endoff); do
 	$XFS_IO_PROG -c "pwrite $i 4k" $file >> $seqres.full 2>&1
 done
 
-echo 0 > /sys/fs/xfs/$sdev/drop_writes
+echo 0 > /sys/fs/xfs/$sdev/$DROP_WRITES
 
 _scratch_cycle_mount
 $XFS_IO_PROG -c 'bmap -vp' $file | _filter_bmap
@@ -98,9 +104,9 @@ for offset in $(seq 0 100 500); do
 	$XFS_IO_PROG -fc "pwrite ${offset}m 100m" $file >> $seqres.full 2>&1
 
 	punchoffset=$((offset + 75))
-	echo 1 > /sys/fs/xfs/$sdev/drop_writes
+	echo 1 > /sys/fs/xfs/$sdev/$DROP_WRITES
 	$XFS_IO_PROG -c "pwrite ${punchoffset}m 4k" $file >> $seqres.full 2>&1
-	echo 0 > /sys/fs/xfs/$sdev/drop_writes
+	echo 0 > /sys/fs/xfs/$sdev/$DROP_WRITES
 done
 
 echo "Silence is golden."
-- 
2.7.4

