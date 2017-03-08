Received: from mx1.redhat.com ([209.132.183.28]:49554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751336AbdCHJUV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Mar 2017 04:20:21 -0500
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/411: change sub-path name that's duplicate of TEST_DIR
Date: Wed,  8 Mar 2017 15:26:31 +0800
Message-Id: <1488957991-18194-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

Darrick found generic/411 golden output mismatch if use
TEST_DIR=/mnt. Because g/411 use some test path named
/mnt/XXXX/mnt1/mnt2, _filter_test_dir will replace all
"/mnt" things to "TEST_DIR".

For stop this failure, change all directory names to be
"$seq-XXX", that's less likely to be mistaken for TEST_*
and SCRATCH_*.

Reported-by: Darrick J. Wong <darrick.wong@oracle.com>
Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/411     | 10 +++++-----
 tests/generic/411.out |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/generic/411 b/tests/generic/411
index 414d3a5..8a45f14 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -123,18 +123,18 @@ crash_test()
 	start_test shared
 
 	_get_mount $SCRATCH_DEV $mpA
-	mkdir $mpA/mnt1
+	mkdir $mpA/${seq}-mnt1
 	$MOUNT_PROG --make-shared $mpA
 	_get_mount --bind $mpA $mpB
 	_get_mount --bind $mpA $mpC
 	$MOUNT_PROG --make-slave $mpB
 	$MOUNT_PROG --make-slave $mpC
-	_get_mount $SCRATCH_DEV $mpA/mnt1
-	mkdir $mpA/mnt1/mnt2
+	_get_mount $SCRATCH_DEV $mpA/${seq}-mnt1
+	mkdir $mpA/${seq}-mnt1/${seq}-mnt2
 
-	_get_mount $SCRATCH_DEV $mpB/mnt1/mnt2
+	_get_mount $SCRATCH_DEV $mpB/${seq}-mnt1/${seq}-mnt2
 	find_mnt
-	fs_stress $mpB/mnt1/mnt2
+	fs_stress $mpB/${seq}-mnt1/${seq}-mnt2
 
 	end_test
 	echo "crash test passed"
diff --git a/tests/generic/411.out b/tests/generic/411.out
index 16dadaf..01a0cdd 100644
--- a/tests/generic/411.out
+++ b/tests/generic/411.out
@@ -2,11 +2,11 @@ QA output created by 411
 ------
 TEST_DIR/411 SCRATCH_DEV
 mpA SCRATCH_DEV
-mpA/mnt1 SCRATCH_DEV
+mpA/411-mnt1 SCRATCH_DEV
 mpB SCRATCH_DEV
-mpB/mnt1 SCRATCH_DEV
-mpB/mnt1/mnt2 SCRATCH_DEV
+mpB/411-mnt1 SCRATCH_DEV
+mpB/411-mnt1/411-mnt2 SCRATCH_DEV
 mpC SCRATCH_DEV
-mpC/mnt1 SCRATCH_DEV
+mpC/411-mnt1 SCRATCH_DEV
 ======
 crash test passed
-- 
2.7.4

