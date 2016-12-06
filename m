Received: from mx1.redhat.com ([209.132.183.28]:49766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752135AbcLFIUP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 6 Dec 2016 03:20:15 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6236A7F7C8
        for <fstests@vger.kernel.org>; Tue,  6 Dec 2016 08:09:46 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic/35[67]: update selinux context for mkswap
Date: Tue,  6 Dec 2016 16:09:27 +0800
Message-Id: <20161206080927.22379-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

With selinux enabled & the default selinux context in fstests,
mkswap is denied, generic/35[67] fail as:

+mkswap: unable to relabel /mnt/testarea/scratch/test-357/file1 to system_u:object_r:swapfile_t:s0: Operation not supported

So mount SCRATCH_DEV with swapfile selinux context if selinux is
enabled (SELINUX_MOUNT_OPTIONS not empty).

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/356 | 4 ++++
 tests/generic/357 | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/tests/generic/356 b/tests/generic/356
index 6bb90c0..8bebad2 100755
--- a/tests/generic/356
+++ b/tests/generic/356
@@ -49,6 +49,10 @@ _require_cp_reflink
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
+# the default selinux context won't allow mkswap
+if [ "$SELINUX_MOUNT_OPTIONS" != "" ]; then
+	export SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
+fi
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
diff --git a/tests/generic/357 b/tests/generic/357
index 439b314..8941927 100755
--- a/tests/generic/357
+++ b/tests/generic/357
@@ -49,6 +49,10 @@ _require_cp_reflink
 
 echo "Format and mount"
 _scratch_mkfs > $seqres.full 2>&1
+# the default selinux context won't allow mkswap
+if [ "$SELINUX_MOUNT_OPTIONS" != "" ]; then
+	export SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:swapfile_t:s0"
+fi
 _scratch_mount >> $seqres.full 2>&1
 
 testdir=$SCRATCH_MNT/test-$seq
-- 
2.9.3

