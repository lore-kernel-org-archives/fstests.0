Received: from szxga06-in.huawei.com ([45.249.212.32]:36362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726048AbeJ0Key (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 27 Oct 2018 06:34:54 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v3] generic/508: fix to check inode creation time feature on scratch mountpoint
Date: Sat, 27 Oct 2018 09:55:20 +0800
Message-ID: <20181027015520.7355-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

_require_btime() just check inode creation time feature on TEST_DIR
mountpoint, but generic/508 needs to do that check on SCRATCH_MNT
mountpoint. Let's add _require_scratch_btime() for that, meanwhile
handling scratch_{mkfs,mount,umount} inside the function to decouple
with caller.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3:
- hanlde scratch mkfs/mount/umount inside _require_scratch_btime
- relocate _require_scratch_btime
 common/rc         | 14 ++++++++++++++
 tests/generic/508 |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b4987a9cd7f7..a882fada7d02 100644
--- a/common/rc
+++ b/common/rc
@@ -3851,6 +3851,20 @@ _require_btime()
 	rm -f $TEST_DIR/test_creation_time
 }
 
+_require_scratch_btime()
+{
+	_require_scratch
+	_scratch_mkfs > /dev/null 2>&1
+	_scratch_mount
+
+	$XFS_IO_PROG -f $SCRATCH_MNT/test_creation_time -c "statx -v" \
+		| grep btime >>$seqres.full 2>&1 || \
+		_notrun "inode creation time not supported by this filesystem"
+	rm -f $SCRATCH_MNT/test_creation_time
+
+	_scratch_unmount
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/generic/508 b/tests/generic/508
index b869b3a9c260..3c2d4aa11169 100755
--- a/tests/generic/508
+++ b/tests/generic/508
@@ -46,10 +46,10 @@ _supported_os Linux
 _require_test_lsattr
 _require_statx
 _require_xfs_io_command "statx" "-v"
-_require_btime
 
 _require_scratch
 _require_scratch_shutdown
+_require_scratch_btime
 
 _scratch_mkfs >/dev/null 2>&1
 _require_metadata_journaling $SCRATCH_DEV
-- 
2.18.0.rc1
