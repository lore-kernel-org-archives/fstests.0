Received: from mx1.redhat.com ([209.132.183.28]:36726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750842AbcI3G6w (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 30 Sep 2016 02:58:52 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1DF3431B315
        for <fstests@vger.kernel.org>; Fri, 30 Sep 2016 06:58:52 +0000 (UTC)
Received: from localhost.localdomain.com (vpn1-6-203.pek2.redhat.com [10.72.6.203])
        by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u8U6wohx017055
        for <fstests@vger.kernel.org>; Fri, 30 Sep 2016 02:58:51 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfs/032: test the next block size if mkfs fails
Date: Fri, 30 Sep 2016 14:58:46 +0800
Message-Id: <1475218726-22265-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If test on a 512b sector size device, xfs/032 will try to do:

  mkfs.xfs -s size=512 -b size=512 ...

The 512b block size is not acceptable for V5 XFS. So if mkfs.xfs
fails, try next block size (blksize *= 2) directly.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

V1 try to find the minimum acceptable block size at first, V2 drop
that method, and then *continue* the test if _scratch_mkfs return
error.

Thanks,
Zorro

 tests/xfs/032 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/xfs/032 b/tests/xfs/032
index 6216379..4b675ee 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -60,6 +60,11 @@ while [ $SECTORSIZE -le $PAGESIZE ]; do
 
 		echo "=== Sector size $SECTORSIZE Block size $BLOCKSIZE ==" >> $seqres.full
 		_scratch_mkfs -s size=$SECTORSIZE -b size=$BLOCKSIZE -d size=1g >> $seqres.full 2>&1
+		# Maybe return error at here, e.g: mkfs.xfs -m crc=1 -b size=512
+		if [ $? -ne 0 ]; then
+			BLOCKSIZE=$(($BLOCKSIZE * 2))
+			continue
+		fi
 		_scratch_mount
 		# light population of the fs
 		$FSSTRESS_PROG -n 100 -d $SCRATCH_MNT >> $seqres.full 2>&1
-- 
2.7.4

