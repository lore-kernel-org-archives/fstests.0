Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729305AbeKWQmd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Nov 2018 11:42:33 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wAN5sSpE101970
        for <fstests@vger.kernel.org>; Fri, 23 Nov 2018 00:59:49 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2nx24t9x31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Fri, 23 Nov 2018 00:59:48 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Fri, 23 Nov 2018 05:59:40 -0000
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 2/2] ext4/021: Work with 64k block size
Date: Fri, 23 Nov 2018 11:29:30 +0530
In-Reply-To: <20181123055930.21423-1-chandan@linux.vnet.ibm.com>
References: <20181123055930.21423-1-chandan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20181123055930.21423-2-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, guaneryu@gmail.com
List-ID: <fstests@vger.kernel.org>

For 64k blocksize, 10MiB as the filesystem size isn't sufficient to have
a journal included. Hence this commit computes the test FS size based on
the block size of the underlying filesystem.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/ext4/021 | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/ext4/021 b/tests/ext4/021
index 3d36efd0..519737e1 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -34,13 +34,16 @@ _supported_os Linux
 _require_scratch
 _require_dumpe2fs
 
-# 10M in bytes
-fssize=$((10 * 1024 * 1024))
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+blocksize=$(_get_block_size $SCRATCH_MNT)
+_scratch_unmount
+
+# With 4k block size, this amounts to 10M FS instance.
+fssize=$((2560 * $blocksize))
 _scratch_mkfs_sized $fssize >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 
-blocksize=`$DUMPE2FS_PROG -h $SCRATCH_DEV 2>/dev/null | grep "Block size" | \
-	awk '{print $3}'`
 offset=0
 found=0
 # this is the jbd2 journal superblock magic number on disk, in big endian
-- 
2.19.1
