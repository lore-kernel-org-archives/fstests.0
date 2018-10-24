Received: from szxga07-in.huawei.com ([45.249.212.35]:35885 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725998AbeJXLiP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Oct 2018 07:38:15 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] common/rc: fix to check inode creation on scratch_mnt in _require_btime()
Date: Wed, 24 Oct 2018 10:26:45 +0800
Message-ID: <20181024022645.74084-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

_require_btime() should check inode creation feature on SCRATCH_MNT
mountpoint intead of TEST_DIR mountpoint, otherwise generic/508 will
fail due to incorrect check of this function.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index b4987a9cd7f7..5154241a5cee 100644
--- a/common/rc
+++ b/common/rc
@@ -3845,10 +3845,10 @@ _dmsetup_create()
 
 _require_btime()
 {
-	$XFS_IO_PROG -f $TEST_DIR/test_creation_time -c "statx -v" \
+	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
 		| grep btime >>$seqres.full 2>&1 || \
 		_notrun "inode creation time not supported by this filesystem"
-	rm -f $TEST_DIR/test_creation_time
+	rm -f $SCRATCH_MNT/test_creation_time
 }
 
 init_rc
-- 
2.18.0.rc1
