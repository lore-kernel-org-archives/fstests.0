Received: from mx1.redhat.com ([209.132.183.28]:43010 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbcGADTS (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jun 2016 23:19:18 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4DD1463E07
	for <fstests@vger.kernel.org>; Fri,  1 Jul 2016 03:19:04 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] generic: add _require_block_device to more tests
Date: Fri,  1 Jul 2016 11:18:32 +0800
Message-Id: <1467343112-26227-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

generic/067 mounts $SCRATCH_DEV directly in the test, assuming it's
a block device. generic/299 and generic/300 query the size of
$SCRATCH_DEV by running 'blockdev --getsz $SCRATCH_DEV'.

So add the check to make sure $SCRATCH_DEV is a real block device in
these tests.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/067 | 1 +
 tests/generic/299 | 1 +
 tests/generic/300 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/067 b/tests/generic/067
index 8a7a55c..8f2baf5 100755
--- a/tests/generic/067
+++ b/tests/generic/067
@@ -56,6 +56,7 @@ _require_test_symlinks
 _require_test
 _require_scratch
 _require_loop
+_require_block_device $SCRATCH_DEV
 
 rm -f $seqres.full
 
diff --git a/tests/generic/299 b/tests/generic/299
index 40265c8..c9ed0e0 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -43,6 +43,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_odirect
+_require_block_device $SCRATCH_DEV
 
 NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
diff --git a/tests/generic/300 b/tests/generic/300
index c187f43..181594e 100755
--- a/tests/generic/300
+++ b/tests/generic/300
@@ -43,6 +43,7 @@ _supported_fs generic
 _supported_os Linux
 _require_scratch
 _require_odirect
+_require_block_device $SCRATCH_DEV
 
 # xfs_io is not required for this test, but it's the best way to verify
 # the test system supports fallocate() for allocation and hole punching
-- 
2.7.4

