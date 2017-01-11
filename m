Received: from cn.fujitsu.com ([59.151.112.132]:23074 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933704AbdAKIYg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2017 03:24:36 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] generic/102: Update strict check
Date: Wed, 11 Jan 2017 16:24:47 +0800
Message-ID: <1484123087-31114-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170105093843.GU1859@eguan.usersys.redhat.com>
References: <20170105093843.GU1859@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Low memory may lead to "written less bytes than requested".
We only care about if xfs_io returned ENOSPC or not, so we
can check stderr of xfs_io instead of stdout.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/102     |  4 +---
 tests/generic/102.out | 20 --------------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/tests/generic/102 b/tests/generic/102
index 3cdc2ba..3ecf39e 100755
--- a/tests/generic/102
+++ b/tests/generic/102
@@ -54,9 +54,7 @@ _scratch_mount
 for ((i = 0; i < 10; i++)); do
 	echo "loop $i" >>$seqres.full
 
-	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file | \
-_filter_xfs_io | _filter_scratch
-
+	$XFS_IO_PROG -f -c "pwrite -b 1m 0 400m" "$SCRATCH_MNT"/file >/dev/null
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



