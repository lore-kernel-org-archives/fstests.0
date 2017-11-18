Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1161422AbdKRF5M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 18 Nov 2017 00:57:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAI5sUTI097833
        for <fstests@vger.kernel.org>; Sat, 18 Nov 2017 00:57:11 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eaehc13ug-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Sat, 18 Nov 2017 00:57:11 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Sat, 18 Nov 2017 00:57:10 -0500
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH 1/3] overlay/017: Remove constant st_ino/d_ino test for hardlinks
Date: Sat, 18 Nov 2017 11:28:02 +0530
Message-Id: <20171118055804.17611-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, amir73il@gmail.com
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-unionfs@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

Constant st_ino/d_ino for hardlinks requires "index" config
feature/mount option to be enabled. overlay/018 already tests constant
st_ino feature for hardlinks. A future commit will add constant d_ino
test to overlay/018 test.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/overlay/017 | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/overlay/017 b/tests/overlay/017
index e9c8525..03955d0 100755
--- a/tests/overlay/017
+++ b/tests/overlay/017
@@ -72,10 +72,8 @@ mknod $lowerdir/chrdev c 1 1
 mknod $lowerdir/blkdev b 1 1
 mknod $lowerdir/fifo p
 $here/src/af_unix $lowerdir/socket
-touch $lowerdir/hardlink1
-ln $lowerdir/hardlink1 $lowerdir/hardlink2
 
-FILES="dir file symlink chrdev blkdev fifo socket hardlink1 hardlink2"
+FILES="dir file symlink chrdev blkdev fifo socket"
 
 # Record inode numbers in format <ino> <basename>
 function record_inode_numbers()
-- 
2.9.5

