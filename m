Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41337 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755260AbcLZRcr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 26 Dec 2016 12:32:47 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBQHTw6l136609
        for <fstests@vger.kernel.org>; Mon, 26 Dec 2016 12:32:47 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27k5e8c4p5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Mon, 26 Dec 2016 12:32:47 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Mon, 26 Dec 2016 10:32:46 -0700
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH] btrfs/012: Enable test to be executed on non-4k block size filesystems
Date: Mon, 26 Dec 2016 23:02:32 +0530
Message-Id: <1482773552-15696-1-git-send-email-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, quwenruo@cn.fujitsu.com
List-ID: <fstests@vger.kernel.org>

To get the test to work on non-4k block sized filesystems, this commit
obtains the block size of the Btrfs filesystem from $TEST_DIR.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/btrfs/012 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/btrfs/012 b/tests/btrfs/012
index b39dec0..cbd3882 100755
--- a/tests/btrfs/012
+++ b/tests/btrfs/012
@@ -63,8 +63,10 @@ _require_command "$E2FSCK_PROG" e2fsck
 
 rm -f $seqres.full
 
+BLOCK_SIZE=`get_block_size $TEST_DIR`
+
 # Create & populate an ext4 filesystem
-$MKFS_EXT4_PROG -F -b 4096 $SCRATCH_DEV > $seqres.full 2>&1 || \
+$MKFS_EXT4_PROG -F -b $BLOCK_SIZE $SCRATCH_DEV > $seqres.full 2>&1 || \
 	_notrun "Could not create ext4 filesystem"
 # Manual mount so we don't use -t btrfs or selinux context
 mount -t ext4 $SCRATCH_DEV $SCRATCH_MNT
-- 
2.5.5

