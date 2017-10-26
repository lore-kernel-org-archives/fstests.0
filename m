Received: from mail.cn.fujitsu.com ([183.91.158.132]:13956 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750957AbdJZF6M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Oct 2017 01:58:12 -0400
From: Gu Jinxiang <gujx@cn.fujitsu.com>
Subject: [PATCH] xfstests: Add message indicating btrfs-progs support FST in read-only mode
Date: Thu, 26 Oct 2017 13:57:46 +0800
Message-ID: <1508997466-12859-1-git-send-email-gujx@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Gu JinXiang <gujx@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

From: Gu JinXiang <gujx@cn.fujitsu.com>

btrfs-progs now support FST in read-only mode, so when space_cache=v2
enabled, this test case will fail.
Add message to help user to understand this status.

Signed-off-by: Gu JinXiang <gujx@cn.fujitsu.com>
---
 tests/btrfs/012 | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index 85c82f07..529e6eca 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -96,6 +96,12 @@ cp -aR /lib/modules/`uname -r`/ $SCRATCH_MNT/new
 
 _scratch_unmount
 
+space_cache_version=$(echo "$MOUNT_OPTIONS" | grep "space_cache=v2")
+if [ -n "$space_cache_version" ]; then
+	_fail "since used space_cache=v2 when mount," \
+	       "and for FST btrfs-progs support is read-only."\
+	      "so btrfs-convert rollback will fail"
+fi
 # Now restore the ext4 device
 $BTRFS_CONVERT_PROG -r $SCRATCH_DEV >> $seqres.full 2>&1 || \
 	_fail "btrfs-convert rollback failed"
-- 
2.13.5



