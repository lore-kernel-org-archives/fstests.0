Received: from mx1.redhat.com ([209.132.183.28]:56820 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfHSI5j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Aug 2019 04:57:39 -0400
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/322: fix bad xfs_io sync_range command
Date: Mon, 19 Aug 2019 10:57:36 +0200
Message-Id: <20190819085736.25304-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add the missing range arguments to the sync_range command in this test:
according to Josef Bacik, the sync_range command is required to make the test
reproduce the critical situation reliably.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/322 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/322 b/tests/generic/322
index 2afd7127..29bfa688 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -65,7 +65,8 @@ _write_after_fsync_rename_test()
 	echo "fsync rename test"
 	_mount_flakey
 	$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" -c "pwrite 2M 1M" \
-		-c "sync_range -b" $SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"
+		-c "sync_range -b 2M 1M" $SCRATCH_MNT/foo \
+		> $seqres.full 2>&1 || _fail "xfs_io failed"
 	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
-- 
2.20.1
