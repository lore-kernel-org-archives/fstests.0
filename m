Received: from mx1.redhat.com ([209.132.183.28]:49461 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751816AbdB0Iax (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Feb 2017 03:30:53 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9AB184E4C6
        for <fstests@vger.kernel.org>; Mon, 27 Feb 2017 08:23:12 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] common/xfs: fix unexpected failure on real 4k sector device
Date: Mon, 27 Feb 2017 16:23:03 +0800
Message-Id: <1488183783-15194-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

_xfs_mkfs_validation_check() run "$cmd -s size=2s" to be sure if
xfsprogs support stricter input checks. But there's an unexpected
failure on 4k sector device:

  # blockdev --getbsz --getpbsz --getss $dev
  4096
  4096
  4096
  # mkfs.xfs -f -N -d file,name=$tmpfile,size=1g -s size=2s
  illegal sector size 1024; hw sector is 4096
  ....

So change the sector size from '2s' to '8s' to keep away this
failure.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

This's the V2 of "[PATCH] common/xfs: change _xfs_mkfs_validation_check return logic",
change '2s' to '8s'.

Thanks,
Zorro

 common/xfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index 767a481..4bd8465 100644
--- a/common/xfs
+++ b/common/xfs
@@ -542,7 +542,7 @@ _xfs_mkfs_validation_check()
 	local tmpfile=`mktemp`
 	local cmd="$MKFS_XFS_PROG -f -N -d file,name=$tmpfile,size=1g"
 
-	$cmd -s size=2s >/dev/null 2>&1
+	$cmd -s size=8s >/dev/null 2>&1
 	local sum=$?
 
 	$cmd -l version=2,su=260k >/dev/null 2>&1
-- 
2.7.4

