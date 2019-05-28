Received: from mx2.suse.de ([195.135.220.15]:60140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfE1Q1g (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 28 May 2019 12:27:36 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CD620AE07
        for <fstests@vger.kernel.org>; Tue, 28 May 2019 16:27:35 +0000 (UTC)
From: Anthony Iliopoulos <ailiopoulos@suse.com>
Subject: [PATCH] xfs/278: use _scratch_xfs_repair helper instead of xfs_repair
Date: Tue, 28 May 2019 18:27:44 +0200
Message-Id: <20190528162744.18359-1-ailiopoulos@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Anthony Iliopoulos <ailiopoulos@suse.com>
List-ID: <fstests@vger.kernel.org>

Use _scratch_xfs_repair helper instead of calling xfs_repair
directly, as local.config may want to define $XFS_REPAIR_PROG
and override the default binary in the search path.

Signed-off-by: Anthony Iliopoulos <ailiopoulos@suse.com>
---
 tests/xfs/278 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/278 b/tests/xfs/278
index c208e61b..ee1464dd 100755
--- a/tests/xfs/278
+++ b/tests/xfs/278
@@ -69,7 +69,7 @@ set_ifield "core.nlinkv2" "$SUBDIR_INO"
 echo "===== BEGIN of xfs_repair =====" >> $seqres.full
 echo "" >>$seqres.full
 
-xfs_repair  $SCRATCH_DEV >> $seqres.full 2>&1
+_scratch_xfs_repair >> $seqres.full 2>&1
 echo "===== END of xfs_repair =====" >> $seqres.full
 
 exit
-- 
2.16.4
