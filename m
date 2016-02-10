Received: from imap.thunk.org ([74.207.234.97]:51033 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756108AbcBJBuM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 9 Feb 2016 20:50:12 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 08/12] xfstests: fix generic/312 on tmpfs, ignore /proc/partitions
Date: Tue,  9 Feb 2016 20:49:57 -0500
Message-Id: <1455069001-17846-9-git-send-email-tytso@mit.edu>
In-Reply-To: <1455069001-17846-1-git-send-email-tytso@mit.edu>
References: <1455069001-17846-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

312 avoid reading /proc/partitions for tmpfs, just assume enough space.

Signed-off-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/312 | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/generic/312 b/tests/generic/312
index b570814..a826071 100755
--- a/tests/generic/312
+++ b/tests/generic/312
@@ -51,12 +51,13 @@ _require_scratch
 
 # 5G in byte
 fssize=$((2**30 * 5))
-required_blocks=$(($fssize / 1024))
-dev_blocks=$(grep -w $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
-if [ $required_blocks -gt $dev_blocks ];then
-	_notrun "this test requires \$SCRATCH_DEV has ${fssize}B space"
+if [ "$FSTYP" != "tmpfs" ]; then
+	required_blocks=$(($fssize / 1024))
+	dev_blocks=$(grep -w $(_short_dev $SCRATCH_DEV) /proc/partitions | $AWK_PROG '{print $3}')
+	if [ $required_blocks -gt $dev_blocks ];then
+	    _notrun "this test requires \$SCRATCH_DEV has ${fssize}B space"
+	fi
 fi
-
 rm -f $seqres.full
 _scratch_mkfs_sized $fssize >>$seqres.full 2>&1
 _scratch_mount >>$seqres.full 2>&1
-- 
2.5.0

