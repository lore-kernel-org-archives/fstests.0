Received: from verein.lst.de ([213.95.11.211]:39697 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753023AbdICPvC (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 3 Sep 2017 11:51:02 -0400
Date: Sun, 3 Sep 2017 17:51:01 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: xfs/310: relax extent count check
Message-ID: <20170903155101.GA30258@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

If we got over the bmbt length we'll always allocate two extents,
its just that so far getbmap merged them.

Also fix/update some comments.

diff --git a/tests/xfs/310 b/tests/xfs/310
index c78f6f1..f33a15a 100755
--- a/tests/xfs/310
+++ b/tests/xfs/310
@@ -1,7 +1,7 @@
 #! /bin/bash
 # FS QA Test No. 310
 #
-# Create a file with more than 2^21 extents (the max length of a bmbt record).
+# Create a file with more than 2^21 blocks (the max length of a bmbt record).
 #
 #-----------------------------------------------------------------------
 # Copyright (c) 2016, Oracle and/or its affiliates.  All Rights Reserved.
@@ -75,8 +75,9 @@ mkdir $testdir
 blksz="$(_get_block_size $testdir)"
 $XFS_IO_PROG -f -c "falloc 0 $((nr_blks * blksz))" $testdir/file1 >> $seqres.full
 
+# make sure the allocator didn't allocate more than the needed two extents
 echo "Check extent count"
-xfs_bmap -l -p -v $testdir/file1 | grep '^[[:space:]]*1:' -q && xfs_bmap -l -p -v $testdir/file1
+xfs_bmap -l -p -v $testdir/file1 | grep '^[[:space:]]*2:' -q && xfs_bmap -l -p -v $testdir/file1
 inum=$(stat -c '%i' $testdir/file1)
 umount $SCRATCH_MNT
 
