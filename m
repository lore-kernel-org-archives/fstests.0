Received: from mx1.redhat.com ([209.132.183.28]:51756 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751398AbdJJKVR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Oct 2017 06:21:17 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AA350C059B64
        for <fstests@vger.kernel.org>; Tue, 10 Oct 2017 10:21:17 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/422: Do not hardcode space used by files
Date: Tue, 10 Oct 2017 12:21:14 +0200
Message-Id: <20171010102114.23074-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Test generic/422 hardcodes in the output file how much space files it
creates are supposed to take up on disk.  This doesn't work when
additional space is allocated for extended attributes for ACLs or
SELinux labels.

Instead, record the actual space used in generic/422.full, and only
check if the writeback changes the space used.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/422     | 51 ++++++++++++++++++++++++++++-----------------------
 tests/generic/422.out | 23 +----------------------
 2 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/tests/generic/422 b/tests/generic/422
index a42a30da..1513bf4a 100755
--- a/tests/generic/422
+++ b/tests/generic/422
@@ -88,40 +88,45 @@ $XFS_IO_PROG -c "pwrite -S 0xff 64K 64K" $SCRATCH_MNT/foo3 | _filter_xfs_io
 $XFS_IO_PROG -c "pwrite -S 0xab 0 64K" $SCRATCH_MNT/foo4 | _filter_xfs_io
 $XFS_IO_PROG -d -c "pwrite -S 0xef 0 64K" $SCRATCH_MNT/foo4 | _filter_xfs_io
 
-echo
-echo "Before writeback"
-echo
+space_used() {
+    echo "Space used by file foo1:"
+    du -h $SCRATCH_MNT/foo1 | _filter_scratch
 
-echo "Space used by file foo1:"
-du -h $SCRATCH_MNT/foo1 | _filter_scratch
+    echo "Space used by file foo2:"
+    du -h $SCRATCH_MNT/foo2 | _filter_scratch
 
-echo "Space used by file foo2:"
-du -h $SCRATCH_MNT/foo2 | _filter_scratch
+    echo "Space used by file foo3:"
+    du -h $SCRATCH_MNT/foo3 | _filter_scratch
 
-echo "Space used by file foo3:"
-du -h $SCRATCH_MNT/foo3 | _filter_scratch
+    echo "Space used by file foo4:"
+    du -h $SCRATCH_MNT/foo4 | _filter_scratch
+}
+
+space_used > $SCRATCH_MNT/$seq.before
+(
+    echo
+    echo "Before writeback"
+    echo
 
-echo "Space used by file foo4:"
-du -h $SCRATCH_MNT/foo4 | _filter_scratch
+    cat $SCRATCH_MNT/$seq.before
+) >> $seqres.full
 
 sync
 
 # We expect the same file sizes reported by 'du' after writeback finishes.
-echo
-echo "After writeback"
-echo
-
-echo "Space used by file foo1:"
-du -h $SCRATCH_MNT/foo1 | _filter_scratch
 
-echo "Space used by file foo2:"
-du -h $SCRATCH_MNT/foo2 | _filter_scratch
+space_used > $SCRATCH_MNT/$seq.after
+(
+    echo
+    echo "After writeback"
+    echo
 
-echo "Space used by file foo3:"
-du -h $SCRATCH_MNT/foo3 | _filter_scratch
+    cat $SCRATCH_MNT/$seq.after
+) >> $seqres.full
 
-echo "Space used by file foo4:"
-du -h $SCRATCH_MNT/foo4 | _filter_scratch
+if diff -q $SCRATCH_MNT/$seq.before $SCRATCH_MNT/$seq.after; then
+    echo "Space used before and after writeback is equal"
+fi
 
 status=0
 exit
diff --git a/tests/generic/422.out b/tests/generic/422.out
index 36960886..8d21003f 100644
--- a/tests/generic/422.out
+++ b/tests/generic/422.out
@@ -17,25 +17,4 @@ wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 wrote 65536/65536 bytes at offset 0
 XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-
-Before writeback
-
-Space used by file foo1:
-64K	SCRATCH_MNT/foo1
-Space used by file foo2:
-128K	SCRATCH_MNT/foo2
-Space used by file foo3:
-128K	SCRATCH_MNT/foo3
-Space used by file foo4:
-64K	SCRATCH_MNT/foo4
-
-After writeback
-
-Space used by file foo1:
-64K	SCRATCH_MNT/foo1
-Space used by file foo2:
-128K	SCRATCH_MNT/foo2
-Space used by file foo3:
-128K	SCRATCH_MNT/foo3
-Space used by file foo4:
-64K	SCRATCH_MNT/foo4
+Space used before and after writeback is equal
-- 
2.13.5

