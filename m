Received: from mx1.redhat.com ([209.132.183.28]:36328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937351AbdEYIio (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 May 2017 04:38:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C1D080F98
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 08:38:43 +0000 (UTC)
Received: from dhcp12-155.nay.redhat.com (dhcp-12-155.nay.redhat.com [10.66.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9439E5C540
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 08:38:42 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] xfs/288: filter out extra mkfs warning
Date: Thu, 25 May 2017 16:38:38 +0800
Message-Id: <1495701518-31539-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

>From xfsprogs v4.7, mkfs.xfs add respecification detection by
commit 9090e18. Then mkfs will fail and return if we run it
as below:

  mkfs.xfs -m crc=1,finobt=1 -m crc=0 ....

Then _scratch_mkfs_xfs can deal with this problem. But for old
xfsprogs ( < v4.7), it replace the first "crc=1" with the second
"crc=0". Then "crc=0,finobt=1" cause a warning, but keep running:

  "warning: finobt not supported without CRC support, disabled."

This extra warning breaks the golden image of xfs/288, so filter
it out in case.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

V2 changed the commit log to explain upstream xfsprogs has no this
problem.

Thanks,
Zorro

 tests/xfs/288 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/288 b/tests/xfs/288
index 6266dd8..0635001 100755
--- a/tests/xfs/288
+++ b/tests/xfs/288
@@ -58,7 +58,7 @@ if [ -z "$XFS_MKFS_HAS_NO_META_SUPPORT" ]; then
 	mkfs_opts="-m crc=0"
 fi
 # get block size ($dbsize) from the mkfs output
-_scratch_mkfs_xfs $mkfs_opts | _filter_mkfs 2>$tmp.mkfs >/dev/null
+_scratch_mkfs_xfs $mkfs_opts 2>/dev/null | _filter_mkfs 2>$tmp.mkfs >/dev/null
 . $tmp.mkfs
 
 _scratch_mount
-- 
2.7.4

