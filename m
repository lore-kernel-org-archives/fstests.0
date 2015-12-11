Received: from mx1.redhat.com ([209.132.183.28]:33555 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752380AbbLKIf4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Dec 2015 03:35:56 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id AB0B940C5B
	for <fstests@vger.kernel.org>; Fri, 11 Dec 2015 08:35:56 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 3/4] generic/062: don't create WHITEOUT_DEV
Date: Fri, 11 Dec 2015 16:35:06 +0800
Message-Id: <1449822907-31197-4-git-send-email-eguan@redhat.com>
In-Reply-To: <1449822907-31197-1-git-send-email-eguan@redhat.com>
References: <1449822907-31197-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

overlay doesn't support creating WHITEOUT_DEV (major and minor device ID
are both 0). Create null device instead.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/062 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/062 b/tests/generic/062
index 90fcbda..e4dc2cc 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -63,7 +63,7 @@ _create_test_bed()
 	ln -s $SCRATCH_MNT/dir $SCRATCH_MNT/lnk
 	mkdir $SCRATCH_MNT/dev
 	mknod $SCRATCH_MNT/dev/b b 0 0
-	mknod $SCRATCH_MNT/dev/c c 0 0
+	mknod $SCRATCH_MNT/dev/c c 1 3
 	mknod $SCRATCH_MNT/dev/p p
 	# sanity check
 	find $SCRATCH_MNT | LC_COLLATE=POSIX sort | _filter_scratch | grep -v "lost+found"
-- 
2.5.0

