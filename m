Received: from mga18.intel.com ([134.134.136.126]:57215 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935913AbeFMVHq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 13 Jun 2018 17:07:46 -0400
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [fstests PATCH] generic/223: skip when using DAX
Date: Wed, 13 Jun 2018 15:07:42 -0600
Message-Id: <20180613210742.28148-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-nvdimm@lists.01.org
List-ID: <fstests@vger.kernel.org>

As of these upstream kernel commits:

commit 6e2608dfd934 ("xfs, dax: introduce xfs_dax_aops")
commit 5f0663bb4a64 ("ext4, dax: introduce ext4_dax_aops")

generic/223 fails on XFS and ext4 because filesystems mounted with DAX no
longer support bmap.  This is desired behavior and will not be fixed,
according to:

https://lists.01.org/pipermail/linux-nvdimm/2018-April/015383.html

So, just skip over generic/223 when using DAX so we don't throw false
positive test failures.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tests/generic/223 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/223 b/tests/generic/223
index dfd8c41b..1a7cf269 100755
--- a/tests/generic/223
+++ b/tests/generic/223
@@ -31,6 +31,7 @@ _supported_os Linux
 
 _require_scratch
 _require_xfs_io_command "falloc"
+_exclude_scratch_mount_option dax
 
 rm -f $seqres.full
 
-- 
2.14.4

