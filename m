Received: from mx1.redhat.com ([209.132.183.28]:59932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbeL2IxR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 29 Dec 2018 03:53:17 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2A32558E32
        for <fstests@vger.kernel.org>; Sat, 29 Dec 2018 08:53:17 +0000 (UTC)
From: Xiong Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH] common/nfs: add FSX_AVOID when testing on NFS
Date: Sat, 29 Dec 2018 16:53:04 +0800
Message-Id: <20181229085304.4310-1-xzhou@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiong Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

copy_file_range on NFSv4.2 requires that src offset and dest offset
are aligned with server blocksize. So does copy count, except that
after this copy, we'll reach the EOF. See Linux commit 811b7b85.

ltp/fsx.c tests copy_file_range on random offset with random size
by default. This makes these tests get EINVAL on NFS.

Signed-off-by: Xiong Murphy Zhou <xzhou@redhat.com>
---
 common/nfs | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/nfs b/common/nfs
index a03eaf48..5600147d 100644
--- a/common/nfs
+++ b/common/nfs
@@ -33,3 +33,12 @@ _require_scratch_nfs_version()
 	fi
 	_scratch_unmount
 }
+
+# copy_file_range on NFSv4.2 requires src offset and dest offset
+# are aligned with server blocksize. So does copy count, except that
+# after this copy, we'll reach the EOF. See Linux commit 811b7b85
+# for details.
+# ltp/fsx.c tests copy_file_range on random offset with random size
+# by default. This makes these tests get EINVAL on NFS.
+# Now add FSX_AVOID to make fsx tests on NFS rational.
+FSX_AVOID="-r 4096 -w 4096 -O -o 4096 -Z $FSX_AVOID"
-- 
2.17.0.252.gfe0a9ea
