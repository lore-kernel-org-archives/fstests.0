Received: from mx1.redhat.com ([209.132.183.28]:55826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfHEW1m (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 5 Aug 2019 18:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 033D230655F5
        for <fstests@vger.kernel.org>; Mon,  5 Aug 2019 22:27:42 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] generic/322: remove bad xfs_io sync_range
Date: Tue,  6 Aug 2019 00:27:38 +0200
Message-Id: <20190805222738.21422-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

The xfs_io sync_range command requires offset and length arguments.  Those are
missing here, so the command fails with:

  bad argument count 1 to sync_range, expected at least 2 arguments

This went unnoticed because xfs_io still exits with status 0 in such cases,
which looks like a separate bug.

I'm assuming that the test did catch regressions as is and that the sync_range
command isn't needed.  If this isn't the case, please fix the test.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/322 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/322 b/tests/generic/322
index 2afd7127..22797c04 100755
--- a/tests/generic/322
+++ b/tests/generic/322
@@ -65,7 +65,7 @@ _write_after_fsync_rename_test()
 	echo "fsync rename test"
 	_mount_flakey
 	$XFS_IO_PROG -f -c "pwrite 0 1M" -c "fsync" -c "pwrite 2M 1M" \
-		-c "sync_range -b" $SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"
+		$SCRATCH_MNT/foo > $seqres.full 2>&1 || _fail "xfs_io failed"
 	mv $SCRATCH_MNT/foo $SCRATCH_MNT/bar
 	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/bar
 	md5sum $SCRATCH_MNT/bar | _filter_scratch
-- 
2.20.1
