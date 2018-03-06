Received: from mail.cn.fujitsu.com ([183.91.158.132]:26693 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750727AbeCFHCt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Mar 2018 02:02:49 -0500
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH] fstests: btrfs/004: increase the buffer size of logical-resolve to the maximum value 64K
Date: Tue, 6 Mar 2018 15:02:31 +0800
Message-ID: <20180306070231.16880-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Because of commit e76e13ce8c0b ("fsstress: implement the
clonerange/deduperange ioctls"), dedupe makes the number of references to
the same extent item increase so much that the default 4K buffer of
logical-resolve is no longer sufficient.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
 tests/btrfs/004 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/004 b/tests/btrfs/004
index de583cc355d4..0d2efb91dba7 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -103,7 +103,7 @@ _btrfs_inspect_addr()
 	expect_addr=$3
 	expect_inum=$4
 	file=$5
-	cmd="$BTRFS_UTIL_PROG inspect-internal logical-resolve -P $addr $mp"
+	cmd="$BTRFS_UTIL_PROG inspect-internal logical-resolve -s 65536 -P $addr $mp"
 	echo "# $cmd" >> $seqres.full
 	out=`$cmd`
 	echo "$out" >> $seqres.full
-- 
2.16.2



