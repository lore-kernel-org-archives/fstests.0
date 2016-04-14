Received: from mx1.redhat.com ([209.132.183.28]:52023 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423AbcDNFcd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Apr 2016 01:32:33 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A37462643
	for <fstests@vger.kernel.org>; Thu, 14 Apr 2016 05:32:32 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] xfs/299: change variable name from "temp" to "tmp" for typo error
Date: Thu, 14 Apr 2016 13:32:23 +0800
Message-Id: <1460611943-14660-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

In xfs/299, project IDs are in $tmp.projid file. But there's one
line code try to use $temp.projid. Fortunately, it doesn't bring
any problems until now, but if keep using $temp.projid it really
don't make sense.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

When I found xfs/299 run failed, I try to dig into it. Although
I sent a duplicate patch for XFS, but there's another tiny
problem I found when I check xfs/299 failure.

I know this problem is very potty, so if someone is writting
another patch about xfs/299, you can fix this incidentally.

Thanks,
Zorro

 tests/xfs/299 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/299 b/tests/xfs/299
index 1f61eea..d2670f8 100755
--- a/tests/xfs/299
+++ b/tests/xfs/299
@@ -143,7 +143,7 @@ _exercise()
 	_file_as_id $SCRATCH_MNT/initme $id $type 1024 0
 	echo "ls -l $SCRATCH_MNT" >>$seqres.full
 	ls -l $SCRATCH_MNT >>$seqres.full
-	xfs_quota -D $tmp.projects -P $temp.projid -x \
+	xfs_quota -D $tmp.projects -P $tmp.projid -x \
 		-c "limit -$type bsoft=${bsoft}k bhard=${bhard}k $id" \
 		-c "limit -$type isoft=$isoft ihard=$ihard $id" \
 		$SCRATCH_DEV
-- 
2.5.5

