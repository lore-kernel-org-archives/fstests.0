Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752690AbdLFGpw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Dec 2017 01:45:52 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB66jImD004004
        for <fstests@vger.kernel.org>; Wed, 6 Dec 2017 01:45:52 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2epb5t8xnu-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Wed, 06 Dec 2017 01:45:52 -0500
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <harish@linux.vnet.ibm.com>;
        Wed, 6 Dec 2017 06:45:50 -0000
From: Harish <harish@linux.vnet.ibm.com>
Subject: [PATCH] btrfs/057: Fix test case to work on 64K page size
Date: Wed,  6 Dec 2017 12:15:45 +0530
Message-Id: <1512542745-26243-1-git-send-email-harish@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Harish <harish@linux.vnet.ibm.com>
List-ID: <fstests@vger.kernel.org>

On platforms with a page size greater than 4Kb, at the moment btrfs
doesn't support a node/leaf size smaller than the page size, but it
supports a larger one. So use the max supported node size (64Kb) so
that the test runs on any platform currently supported by Linux.

Signed-off-by: Harish <harish@linux.vnet.ibm.com>
---
 tests/btrfs/057     | 7 +++++--
 tests/btrfs/057.out | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/057 b/tests/btrfs/057
index 8d35579..06b2be9 100755
--- a/tests/btrfs/057
+++ b/tests/btrfs/057
@@ -48,8 +48,11 @@ _require_scratch
 
 rm -f $seqres.full
 
-# use small leaf size to get higher btree height.
-run_check _scratch_mkfs "-b 1g --nodesize 4096"
+# Currently in btrfs the node/leaf size can not be smaller than the page
+# size (but it can be greater than the page size). So use the largest
+# supported node/leaf size (64Kb) so that the test can run on any platform
+# that Linux supports.
+run_check _scratch_mkfs "-b 1g --nodesize 65536"
 
 # inode cache is saved in the FS tree itself for every
 # individual FS tree,that affects the sizes reported by qgroup show
diff --git a/tests/btrfs/057.out b/tests/btrfs/057.out
index 60cb92d..f2d9e9c 100644
--- a/tests/btrfs/057.out
+++ b/tests/btrfs/057.out
@@ -1,3 +1,3 @@
 QA output created by 057
-4096 4096
-4096 4096
+65536 65536
+65536 65536
-- 
2.7.4

