Received: from mx1.redhat.com ([209.132.183.28]:60988 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751828AbdGFSGW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Jul 2017 14:06:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 23D3B3345BA
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2017 18:06:22 +0000 (UTC)
Received: from bfoster.bfoster (dhcp-41-20.bos.redhat.com [10.18.41.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 06FF66F92E
        for <fstests@vger.kernel.org>; Thu,  6 Jul 2017 18:06:22 +0000 (UTC)
From: Brian Foster <bfoster@redhat.com>
Subject: [PATCH] xfs/297: fail test if _scratch_mount fails
Date: Thu,  6 Jul 2017 14:06:20 -0400
Message-Id: <20170706180620.58376-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfs/297 formats the scratch device with test specific mkfs options
that limit the use of certain mount options (i.e., if logbsize !=
256k). If an incompatible mount option is set, the mount fails but
the test proceeds to run against the root filesystem.

Update xfs/297 to fail if the mount of the scratch device fails for
whatever reason.

Signed-off-by: Brian Foster <bfoster@redhat.com>
---

A couple other options here are to exclude the use of logbsize
(effectively _notrun the test) or to hardcode the mount with '-o
logbsize=256k' in the test.  I didn't like the former because it
excludes even when a valid logbsize is set.  The latter requires us to
use _require_scratch_nocheck, otherwise the post-test remount fails.
This configuration is rare enough that this seemed like the least bad
option.

Brian

 tests/xfs/297 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/297 b/tests/xfs/297
index fe92441..9accffd 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -52,7 +52,7 @@ _require_command "$KILLALL_PROG" killall
 
 rm -f $seqres.full
 _scratch_mkfs_xfs -d agcount=16,su=256k,sw=12 -l su=256k,size=5120b >/dev/null 2>&1
-_scratch_mount >/dev/null 2>&1
+_scratch_mount >>$seqres.full 2>&1 || _fail "mount failed"
 
 STRESS_DIR="$SCRATCH_MNT/testdir"
 mkdir -p $STRESS_DIR
-- 
2.9.4

