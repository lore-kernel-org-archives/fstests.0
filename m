Received: from aserp1040.oracle.com ([141.146.126.69]:32694 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753775AbdKPAuQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Nov 2017 19:50:16 -0500
From: Liu Bo <bo.li.liu@oracle.com>
Subject: [PATCH v2] fstests: btrfs/143: make test case more reliable
Date: Wed, 15 Nov 2017 16:47:59 -0700
Message-Id: <20171115234759.19168-1-bo.li.liu@oracle.com>
In-Reply-To: <20171023205733.14896-1-bo.li.liu@oracle.com>
References: <20171023205733.14896-1-bo.li.liu@oracle.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

This changes to use '_scratch_cycle_mount' to drop all caches btrfs could have
in order to avoid an issue that drop_caches somehow doesn't work on Nikolay's
box.

Also use bash -c to run 'read' only when %pid is odd so that we can read the
faulty disk.

Reported-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---
v2: Change 'fadvise -d' to _scratch_cycle_mount.

To Nikolay,

I didn't add your tested-by, but could you please verify if this also
works on your test box?


 tests/btrfs/143 | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tests/btrfs/143 b/tests/btrfs/143
index da7bfd8..3875b6c 100755
--- a/tests/btrfs/143
+++ b/tests/btrfs/143
@@ -127,16 +127,16 @@ echo "step 3......repair the bad copy" >>$seqres.full
 # since raid1 consists of two copies, and the bad copy was put on stripe #1
 # while the good copy lies on stripe #0, the bad copy only gets access when the
 # reader's pid % 2 == 1 is true
-while true; do
-	# start_fail only fails the following buffered read so the repair is
-	# supposed to work.
-	echo 3 > /proc/sys/vm/drop_caches
-	start_fail
-	$XFS_IO_PROG -c "pread 0 4K" "$SCRATCH_MNT/foobar" > /dev/null &
-	pid=$!
-	wait
-	stop_fail
-	[ $((pid % 2)) == 1 ] && break
+while [[ -z ${result} ]]; do
+    # invalidate the page cache.
+    _scratch_cycle_mount
+
+    start_fail
+    result=$(bash -c "
+        if [[ \$((\$\$ % 2)) -eq 1 ]]; then
+                exec $XFS_IO_PROG -c \"pread 0 4K\" \"$SCRATCH_MNT/foobar\"
+        fi");
+    stop_fail
 done
 
 _scratch_unmount
-- 
2.5.0

