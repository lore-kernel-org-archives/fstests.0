Received: from cn.fujitsu.com ([59.151.112.132]:31189 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S936583AbdAEI4d (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Jan 2017 03:56:33 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/102: Update strict check
Date: Thu, 5 Jan 2017 16:56:09 +0800
Message-ID: <1483606569-6515-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Low memory may lead to "written less bytes than
requested".  We only care about if xfs_io returned
ENOSPC or not, so we can check stderr of xfs_io
instead of stdout.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/102     |  5 +++--
 tests/generic/102.out | 20 --------------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/tests/generic/102 b/tests/generic/102
index 3cdc2ba..104edc0 100755
--- a/tests/generic/102
+++ b/tests/generic/102
@@ -54,8 +54,9 @@ _scratch_mount
 for ((i = 0; i < 10; i++)); do
 	echo "loop $i" >>$seqres.full
 
-	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file | \
-_filter_xfs_io | _filter_scratch
+	out="$($XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file 2>&1)"
+	echo $out >>$seqres.full 2>&1
+	echo $out | grep -q "No space left on device" && echo "pwrite failed with ENOSPC"
 
 	rm -f "$SCRATCH_MNT"/file
 done
diff --git a/tests/generic/102.out b/tests/generic/102.out
index fc9275d..6fea359 100644
--- a/tests/generic/102.out
+++ b/tests/generic/102.out
@@ -1,21 +1 @@
 QA output created by 102
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 419430400/419430400 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
1.8.3.1



