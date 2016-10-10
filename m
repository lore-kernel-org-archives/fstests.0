Received: from cn.fujitsu.com ([222.73.24.84]:36998 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbcJJFMk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 10 Oct 2016 01:12:40 -0400
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Subject: [PATCH] generic/175: disable inline data feature for btrfs
Date: Mon, 10 Oct 2016 13:06:47 +0800
Message-Id: <20161010050647.30262-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

For btrfs, if compression is enabled, it may generate inline data for a
blocksize data range, this inline data is stored in fs tree, will not have
a individual extent, try to reflink this data range at a not-zero offset
will return EOPNOTSUPP, so here we disable inline data feature for btrfs.

Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
---
 tests/generic/175 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/generic/175 b/tests/generic/175
index 964580c..b3f90dc 100755
--- a/tests/generic/175
+++ b/tests/generic/175
@@ -50,6 +50,13 @@ rm -f "$seqres.full"
 
 echo "Format and mount"
 _scratch_mkfs > "$seqres.full" 2>&1
+# For btrfs, if compression is enabled, it may generate inline data for a
+# blocksize data range, this inline data is stored in fs tree, will not have
+# a individual extent, try to reflink this data range at a not-zero offset
+# will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
+if [ "$FSTYP" = "btrfs" ]; then
+	export MOUNT_OPTIONS="-o max_inline=0 $MOUNT_OPTIONS"
+fi
 _scratch_mount >> "$seqres.full" 2>&1
 
 testdir="$SCRATCH_MNT/test-$seq"
-- 
2.9.0



