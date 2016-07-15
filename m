Received: from mx1.redhat.com ([209.132.183.28]:40344 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750870AbcGOE7e (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 Jul 2016 00:59:34 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7E032C0624AD
	for <fstests@vger.kernel.org>; Fri, 15 Jul 2016 04:59:34 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] xfs: fix wrong seq order in group file
Date: Fri, 15 Jul 2016 12:59:21 +0800
Message-Id: <1468558761-22665-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

006 and 007 are in reverse order, and this breaks tools to find the
next available seq number in group file (e.g. tools/nextid).

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
I made this mistake when merging xfs/006, sorry!

 tests/xfs/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/group b/tests/xfs/group
index 9f8ca0f..59d2a85 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -3,8 +3,8 @@
 003 db auto quick
 004 db auto quick
 005 auto quick
-007 auto quota quick
 006 auto quick mount
+007 auto quota quick
 008 rw ioctl auto quick
 009 rw ioctl auto prealloc quick
 010 auto quick repair
-- 
2.7.4

