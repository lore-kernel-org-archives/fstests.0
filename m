Received: from mx1.redhat.com ([209.132.183.28]:53080 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbbG1OZY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 28 Jul 2015 10:25:24 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 0D8108C1B2
	for <fstests@vger.kernel.org>; Tue, 28 Jul 2015 14:25:24 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common: fix _count_extents and _count_holes
Date: Tue, 28 Jul 2015 22:25:04 +0800
Message-Id: <1438093504-25230-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: zlang@redhat.com, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

In _count_extents and _count_holes, the output of 'xfs_io -c "fiemap"'
is saved in var res, but the following "echo $res" will merge the
original output into one line. e.g.

	0: [0..63]: 96..159
	1: [64..127]: hole

will be

	0: [0..63]: 96..159 1: [64..127]: hole

so the extent count is always 0 if there's a hole.

This makes generic/046 fail occasionally. (Seems it's easier to
reproduce when the system is under some presure, e.g. with fsstress
running.)

Tested the new _count_extents and _count_holes with generic/04[3-9] and
tests all passed as expect.

Reported-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 15e7795..0d3570f 100644
--- a/common/rc
+++ b/common/rc
@@ -2434,14 +2434,12 @@ _require_fiemap()
 
 _count_extents()
 {
-	res=`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
-	echo $res | grep -v hole | wc -l | $AWK_PROG '{print $1}'
+	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep -v hole | wc -l
 }
 
 _count_holes()
 {
-	res=`$XFS_IO_PROG -c "fiemap" $1 | tail -n +2`
-	echo $res | grep hole | wc -l | $AWK_PROG '{print $1}'
+	$XFS_IO_PROG -c "fiemap" $1 | tail -n +2 | grep hole | wc -l
 }
 
 # arg 1 is dev to remove and is output of the below eg.
-- 
2.4.3

