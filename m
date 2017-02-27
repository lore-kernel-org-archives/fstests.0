Received: from mx1.redhat.com ([209.132.183.28]:37854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbdB0FbR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Feb 2017 00:31:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CDEE7F368
        for <fstests@vger.kernel.org>; Mon, 27 Feb 2017 05:08:07 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] common/xfs: change _xfs_mkfs_validation_check return logic
Date: Mon, 27 Feb 2017 13:07:59 +0800
Message-Id: <1488172079-7170-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

_xfs_mkfs_validation_check() try to make sure mkfs.xfs the stricter
input checks. It runs two test command lines with illegal parameters:

  $cmd -s size=2s
  $cmd -l version=2,su=260k

The current logic think if both of them return 0 (can't find
illegal input), then it means the current xfsprogs doesn't support
the stricter input checks.

But when test on machine with 4k sector size disk, the first command
will return non-zero, and then _xfs_mkfs_validation_check() return
non-zero to _require_xfs_mkfs_validation(). The latter will assume
xfsprogs support the stricter input checks.

So I think the proper logic should be if "any" of test command lines
return 0, then it means xfsprogs can't do stricter input test.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/xfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index 767a481..0eaa974 100644
--- a/common/xfs
+++ b/common/xfs
@@ -546,7 +546,7 @@ _xfs_mkfs_validation_check()
 	local sum=$?
 
 	$cmd -l version=2,su=260k >/dev/null 2>&1
-	sum=`expr $sum + $?`
+	sum=`expr $sum \* $?`
 
 	rm -f $tmpfile
 	return $sum
-- 
2.7.4

