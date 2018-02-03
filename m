Received: from mx1.redhat.com ([209.132.183.28]:43964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeBCS5m (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 3 Feb 2018 13:57:42 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4311481DEC
        for <fstests@vger.kernel.org>; Sat,  3 Feb 2018 18:57:42 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 3/3] generic/270: Check for scratch mount success
Date: Sat,  3 Feb 2018 19:57:37 +0100
Message-Id: <20180203185737.21025-3-agruenba@redhat.com>
In-Reply-To: <20180203185737.21025-1-agruenba@redhat.com>
References: <20180203185737.21025-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

We don't want to fill up the scratch mount point if the scratch mount
fails.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 tests/generic/270 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/270 b/tests/generic/270
index f5026ba0..318f532a 100755
--- a/tests/generic/270
+++ b/tests/generic/270
@@ -83,7 +83,7 @@ _require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 _scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
-_scratch_mount "-o usrquota,grpquota"
+_scratch_mount "-o usrquota,grpquota" || _fail "mount failed"
 chmod 777 $SCRATCH_MNT
 quotacheck -u -g $SCRATCH_MNT 2>/dev/null
 quotaon -u -g $SCRATCH_MNT 2>/dev/null
-- 
2.14.3

