Received: from szxga07-in.huawei.com ([45.249.212.35]:36958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbeJXPvf (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 24 Oct 2018 11:51:35 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] generic/508: fix to check inode creation time feature on scratch mountpoint
Date: Wed, 24 Oct 2018 15:24:33 +0800
Message-ID: <20181024072433.109167-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, david@fromorbit.com
Cc: fstests@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

_require_btime() just check inode creation time feature on TEST_DIR
mountpoint, but generic/508 needs to do that check on SCRATCH_MNT
mountpoint. Let's add _require_scratch_btime() for that, meanwhile
moving the check behind scratch_mkfs/scratch_moun.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
As Dave Chinner suggested:
- introduce _require_scratch_btime() to check inode creation time
feature in scratch mountpoint, adjust generic/508 to use it.
- relocate the check behind scratch_mkfs/scratch_mount.
 common/rc         | 8 ++++++++
 tests/generic/508 | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b4987a9cd7f7..111ba5410506 100644
--- a/common/rc
+++ b/common/rc
@@ -3851,6 +3851,14 @@ _require_btime()
 	rm -f $TEST_DIR/test_creation_time
 }
 
+_require_scratch_btime()
+{
+	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
+		| grep btime >>$seqres.full 2>&1 || \
+		_notrun "inode creation time not supported by this filesystem"
+	rm -f $SCRATCH_MNT/test_creation_time
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/508 b/tests/generic/508
index b869b3a9c260..f1cda52fa44c 100755
--- a/tests/generic/508
+++ b/tests/generic/508
@@ -46,7 +46,6 @@ _supported_os Linux
 _require_test_lsattr
 _require_statx
 _require_xfs_io_command "statx" "-v"
-_require_btime
 
 _require_scratch
 _require_scratch_shutdown
@@ -59,6 +58,7 @@ testfile=$SCRATCH_MNT/testfile
 do_check()
 {
 	_scratch_mount
+	_require_scratch_btime
 
 	touch $testfile
 
-- 
2.18.0.rc1
