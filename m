Received: from mx1.redhat.com ([209.132.183.28]:58032 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfGFOwZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 6 Jul 2019 10:52:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 78888C057F4F
        for <fstests@vger.kernel.org>; Sat,  6 Jul 2019 14:52:25 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-66.pek2.redhat.com [10.72.12.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CABF84401
        for <fstests@vger.kernel.org>; Sat,  6 Jul 2019 14:52:24 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/449: test xfs_info on a mounted block device
Date: Sat,  6 Jul 2019 22:52:17 +0800
Message-Id: <20190706145217.13336-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

There was a bug, xfs_info fails on a mounted block device:

  # xfs_info /dev/mapper/testdev
  xfs_info: /dev/mapper/testdev contains a mounted filesystem

  fatal error -- couldn't initialize XFS library

  xfsprogs has fixed it by:

    bbb43745 xfs_info: use findmnt to handle mounted block devices

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/449 | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/449 b/tests/xfs/449
index 6a031685..7aae1545 100755
--- a/tests/xfs/449
+++ b/tests/xfs/449
@@ -60,10 +60,15 @@ echo GROWFS >> $seqres.full
 cat $tmp.growfs >> $seqres.full
 diff -u $tmp.mkfs $tmp.growfs
 
-$XFS_INFO_PROG $SCRATCH_MNT > $tmp.info
-echo INFO >> $seqres.full
-cat $tmp.info >> $seqres.full
-diff -u $tmp.mkfs $tmp.info
+$XFS_INFO_PROG $SCRATCH_MNT > $tmp.info.mnt
+echo INFO_MNT >> $seqres.full
+cat $tmp.info.mnt >> $seqres.full
+diff -u $tmp.mkfs $tmp.info.mnt
+
+$XFS_INFO_PROG $SCRATCH_DEV > $tmp.info.dev
+echo INFO_DEV >> $seqres.full
+cat $tmp.info.dev >> $seqres.full
+diff -u $tmp.mkfs $tmp.info.dev
 
 echo "Silence is golden."
 status=0
-- 
2.17.2
