Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92F0C001DB
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 14:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjHNOni (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjHNOnN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 10:43:13 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 07:43:12 PDT
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com [207.54.90.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2BDAA
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 07:43:12 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="127929625"
X-IronPort-AV: E=Sophos;i="6.01,172,1684767600"; 
   d="scan'208";a="127929625"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:42:06 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 7B5D0D50B5
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 23:42:04 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9E9F3D50B6
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 23:42:03 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.131])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id D1A2720050183;
        Mon, 14 Aug 2023 23:42:02 +0900 (JST)
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org, axboe@kernel.dk, tytso@mit.edu, shr@fb.com,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH] generic/471: Remove this broken case
Date:   Mon, 14 Aug 2023 22:41:41 +0800
Message-Id: <1692024101-3967-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27812.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27812.006
X-TMASE-Result: 10--22.271300-10.000000
X-TMASE-MatchedRID: i/8xuBmZOeHsR/15S/KqDng2y0j5vXZG9LMB0hXFSeiiC7BD4niBmAjJ
        lierVE/nX9FkyF3xRuQo2WsGjfkpagzlifXGuD0lC7D4xVwcmkre22ctUL9zM0yi1T9AUgUbtBL
        8rEoidRLK7A+F0xO3x9t49GVNlw9Tl1bc/4UP/k5DRebSlZYuSpbRfsVvs4VI0mU2/P/r9E2GTA
        ma0kIVvljkSH9LOiJWz068CLGTHDqIKyp7CdRkYL+a7Hw+x9qZP8UQejhp29rAuQ0xDMaXkH4qt
        YI9sRE/Oelg+pLqPPEv/zJQ0aiPJlE/ARLVFdXasjFnB5RHQ19r2qJoNIuCjS196sn93sBvE7R/
        wXN7ZgkAhdCp3mGaIdCx59LlYtdTx92QiUSIjaTQA62yD5U1x2mQExgOfwV4e9hy6oWpRq2nOmB
        s4/7O1A+E6/XRcFXoRBFLm7DY5F1as3j/nymmYnaNJ/iTxXCafS0Ip2eEHnz3IzXlXlpamPoLR4
        +zsDTtAqYBE3k9Mpw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I remember this case fails on last year becuase of
kernel commit cae2de69 ("iomap: Add async buffered write support")
kernel commit 1aa91d9 ("xfs: Add async buffered write support").
as below:
     pwrite: Resource temporarily unavailable
     wrote 8388608/8388608 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
    -RWF_NOWAIT time is within limits.
    +pwrite: Resource temporarily unavailable
    +(standard_in) 1: syntax error
    +RWF_NOWAIT took  seconds

So For async buffered write requests, the request will return -EAGAIN
if the ilock cannot be obtained immediately.

Here also a discussion[1] that seems generic/471 has been broken.

Now, I met this problem in my linux distribution, then I found the above
discussion. IMO, remove this case is ok and then we can avoid to meet this
false report again.

[1]https://lore.kernel.org/linux-xfs/b2865bd6-2346-8f4d-168b-17f06bbedbed@kernel.dk/
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/471     | 67 -------------------------------------------
 tests/generic/471.out | 13 ---------
 2 files changed, 80 deletions(-)
 delete mode 100755 tests/generic/471
 delete mode 100644 tests/generic/471.out

diff --git a/tests/generic/471 b/tests/generic/471
deleted file mode 100755
index fbd0b12a..00000000
--- a/tests/generic/471
+++ /dev/null
@@ -1,67 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2017, SUSE Linux Products.  All Rights Reserved.
-#
-# FS QA Test No. 471
-#
-# write a file with RWF_NOWAIT and it would fail because there are no
-# blocks allocated. Create a file with direct I/O and re-write it
-# using RWF_NOWAIT. I/O should finish within 50 microsecods since
-# block allocations are already performed.
-#
-. ./common/preamble
-_begin_fstest auto quick rw
-
-# Import common functions.
-. ./common/populate
-. ./common/filter
-. ./common/attr
-
-# real QA test starts here
-_require_odirect
-_require_test
-_require_xfs_io_command pwrite -N
-
-# Remove reminiscence of previously run tests
-testdir=$TEST_DIR/$seq
-if [ -e $testdir ]; then
-	rm -Rf $testdir
-fi
-
-mkdir $testdir
-
-# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail with -EAGAIN
-# when writing to a file range except if it's a NOCOW file and an extent for the
-# range already exists or if it's a COW file and preallocated/unwritten extent
-# exists in the target range. So to make sure that the last write succeeds on
-# all filesystems, use a NOCOW file on btrfs.
-if [ $FSTYP == "btrfs" ]; then
-	_require_chattr C
-	# Zoned btrfs does not support NOCOW
-	_require_non_zoned_device $TEST_DEV
-	touch $testdir/f1
-	$CHATTR_PROG +C $testdir/f1
-fi
-
-# Create a file with pwrite nowait (will fail with EAGAIN)
-$XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
-
-# Write the file without nowait
-$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -W -w -V 1 -b 1M 0 8M" $testdir/f1 | _filter_xfs_io
-
-time_taken=`$XFS_IO_PROG -d -c "pwrite -S 0xbb -N -V 1 -b 1M 2M 1M" $testdir/f1 | awk '/^1/ {print $5}'`
-
-# RWF_NOWAIT should finish within a short period of time so we are choosing
-# a conservative value of 50 ms. Anything longer means it is waiting
-# for something in the kernel which would be a fail.
-if (( $(echo "$time_taken < 0.05" | bc -l) )); then
-	echo "RWF_NOWAIT time is within limits."
-else
-	echo "RWF_NOWAIT took $time_taken seconds"
-fi
-
-$XFS_IO_PROG -c "pread -v 0 8M" $testdir/f1 | _filter_xfs_io_unique
-
-# success, all done
-status=0
-exit
diff --git a/tests/generic/471.out b/tests/generic/471.out
deleted file mode 100644
index ab23272e..00000000
--- a/tests/generic/471.out
+++ /dev/null
@@ -1,13 +0,0 @@
-QA output created by 471
-pwrite: Resource temporarily unavailable
-wrote 8388608/8388608 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-RWF_NOWAIT time is within limits.
-00000000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-*
-00200000:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb  ................
-*
-00300000:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
-*
-read 8388608/8388608 bytes at offset 0
-XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-- 
2.27.0

