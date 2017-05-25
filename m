Received: from mx1.redhat.com ([209.132.183.28]:44000 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751421AbdEYHbX (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 25 May 2017 03:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A60133D94D
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 07:31:21 +0000 (UTC)
Received: from dhcp12-155.nay.redhat.com (unknown [10.66.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F275219E95
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 07:31:20 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/288: filter out extra mkfs warning
Date: Thu, 25 May 2017 15:31:15 +0800
Message-Id: <1495697475-25711-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If we use MKFS_OPTIONS="-m crc=1,finobt=1", xfs/288 will print
one more line:

  "warning: finobt not supported without CRC support, disabled."

That breaks the golden image, so filter it out.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
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

