Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbbCKLPz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Mar 2015 07:15:55 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2BBFrmM024395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 11 Mar 2015 07:15:54 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 4/4] xfs/073: be quiet about mouting with nouuid option
Date: Wed, 11 Mar 2015 19:15:34 +0800
Message-Id: <1426072534-12246-5-git-send-email-eguan@redhat.com>
In-Reply-To: <1426072534-12246-1-git-send-email-eguan@redhat.com>
References: <1426072534-12246-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

v4 and v5 xfs generate different outputs because v4 xfs only retries
mount with nouuid option once in the test, v5 xfs tries more times(with
xfs_copy running with -d option).

Just be quiet about mounting with nouuid option, it's much easier than
preparing two different 073.outs and selecting the proper one at runtime

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/xfs/073     | 2 +-
 tests/xfs/073.out | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/xfs/073 b/tests/xfs/073
index f955771..508725f 100755
--- a/tests/xfs/073
+++ b/tests/xfs/073
@@ -88,7 +88,7 @@ _verify_copy()
 
 	mount -t xfs -o loop $target $target_dir 2>/dev/null
 	if [ $? -ne 0 ]; then
-		echo retrying mount with nouuid option
+		echo retrying mount with nouuid option >>$seqres.full
 		mount -t xfs -o loop -o nouuid $target $target_dir
 		if [ $? -ne 0 ]; then
 			echo mount failed - evil!
diff --git a/tests/xfs/073.out b/tests/xfs/073.out
index f3b147e..3f27467 100644
--- a/tests/xfs/073.out
+++ b/tests/xfs/073.out
@@ -29,7 +29,6 @@ Creating file <FSIMAGE1>
 All copies completed.
 checking new image
 mounting new image on loopback
-retrying mount with nouuid option
 comparing new image files to old
 comparing new image directories to old
 comparing new image geometry to old
-- 
2.1.0

