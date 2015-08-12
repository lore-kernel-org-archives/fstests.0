Received: from mx1.redhat.com ([209.132.183.28]:52695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932605AbbHLRdw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 12 Aug 2015 13:33:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 9471019CBFE
	for <fstests@vger.kernel.org>; Wed, 12 Aug 2015 17:33:52 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/020: use -f option for xfs_repair a fs image
Date: Thu, 13 Aug 2015 01:33:48 +0800
Message-Id: <1439400828-23150-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

This case creates a 60t image file on TEST_DIR. Generally
this's no problem. But if the image sector size is smaller
than the TEST_DEV sector size, for example we create the
image on hard 4k TEST_DEV, the test will fail.

So use -f for xfs_repair will helpful.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/xfs/020 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/020 b/tests/xfs/020
index dc305c1..120492d 100755
--- a/tests/xfs/020
+++ b/tests/xfs/020
@@ -55,7 +55,7 @@ fsfile=$TEST_DIR/fsfile.$seq
 rm -f $fsfile
 
 $MKFS_PROG -t xfs -d size=60t,file,name=$fsfile >/dev/null
-$XFS_REPAIR_PROG -o ag_stride=32 -t 1 $fsfile >/dev/null 2>&1
+$XFS_REPAIR_PROG -f -o ag_stride=32 -t 1 $fsfile >/dev/null 2>&1
 
 status=$?
 exit
-- 
1.9.3

