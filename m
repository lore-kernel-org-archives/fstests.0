Received: from mx1.redhat.com ([209.132.183.28]:37364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfABED1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Jan 2019 23:03:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87B38461F8
        for <fstests@vger.kernel.org>; Wed,  2 Jan 2019 04:03:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B19CD60123
        for <fstests@vger.kernel.org>; Wed,  2 Jan 2019 04:03:26 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/2] generic/474: shift target directory to a sub-dir of SCRATCH_MNT
Date: Wed,  2 Jan 2019 12:03:18 +0800
Message-Id: <20190102040319.7668-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If testing on large fs, there's a huge size .use_space file in
$SCRATCH_MNT, then `fssum $SCRATCH_MNT` trys to read whole huge
file. That's wasting time, so change the target path to a sub-dir
of $SCRATCH_MNT.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

These 2 patches try to fix case issues which cause testing hang on(not real hang)
large-fs.

Thanks,
Zorro

 tests/generic/474 | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/generic/474 b/tests/generic/474
index 12157a39..5ce72d75 100755
--- a/tests/generic/474
+++ b/tests/generic/474
@@ -55,14 +55,18 @@ _scratch_mount
 
 sync
 
-$XFS_IO_PROG -f -c "pwrite 0 4K" $SCRATCH_MNT/testfile >/dev/null 2>&1
+# Large fs has a huge size .use_space file, will take long time on running
+# fssum $SCRATCH_MNT. So change the target path to a sub-dir of $SCRATCH_MNT.
+localdir=$SCRATCH_MNT/dir
+mkdir $localdir
+$XFS_IO_PROG -f -c "pwrite 0 4K" $localdir/testfile >/dev/null 2>&1
 
 # fssum used for comparing checksum of test file(data & metedata),
 # exclude checking about atime, block structure, open error.
-$FSSUM_PROG -ugomAcdES -f -w $tmp.fssum $SCRATCH_MNT
-$XFS_IO_PROG -c "syncfs" $SCRATCH_MNT/testfile >/dev/null 2>&1
+$FSSUM_PROG -ugomAcdES -f -w $tmp.fssum $localdir
+$XFS_IO_PROG -c "syncfs" $localdir/testfile >/dev/null 2>&1
 _scratch_shutdown
 _scratch_cycle_mount
-$FSSUM_PROG -r $tmp.fssum $SCRATCH_MNT
+$FSSUM_PROG -r $tmp.fssum $localdir
 
 exit
-- 
2.17.2
