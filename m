Received: from mx1.redhat.com ([209.132.183.28]:46592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755034AbdCGI5A (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 Mar 2017 03:57:00 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 117BF7298D
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2017 08:55:17 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] generic/409-411: remove all after unbind mountpoints
Date: Tue,  7 Mar 2017 16:55:12 +0800
Message-Id: <1488876912-23775-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: zlang@redhat.com
List-ID: <fstests@vger.kernel.org>

After some shared subtrees test (bind/slave/shared/private), maybe
some dentries isn't freed. For example, EBUSY maybe returned due to
some bugs. This patch tries to verify that.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/409 | 3 +++
 tests/generic/410 | 3 +++
 tests/generic/411 | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/tests/generic/409 b/tests/generic/409
index d7c39d6..4bfedf7 100755
--- a/tests/generic/409
+++ b/tests/generic/409
@@ -48,6 +48,8 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_clear_mount_stack
+	# make sure there's no bug cause dentry isn't be freed
+	rm -rf $MNTHEAD
 }
 
 # get standard environment, filters and checks
@@ -87,6 +89,7 @@ fs_stress()
 
 # prepare some mountpoint dir
 MNTHEAD=$TEST_DIR/$seq
+rm -rf $MNTHEAD
 mkdir $MNTHEAD 2>>$seqres.full
 mpA=$MNTHEAD/"$$"_mpA
 mpB=$MNTHEAD/"$$"_mpB
diff --git a/tests/generic/410 b/tests/generic/410
index e627cfe..f2e0d1b 100755
--- a/tests/generic/410
+++ b/tests/generic/410
@@ -56,6 +56,8 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_clear_mount_stack
+	# make sure there's no bug cause dentry isn't be freed
+	rm -rf $MNTHEAD
 }
 
 # get standard environment, filters and checks
@@ -95,6 +97,7 @@ fs_stress()
 
 # prepare some mountpoint dir
 MNTHEAD=$TEST_DIR/$seq
+rm -rf $MNTHEAD
 mkdir $MNTHEAD 2>>$seqres.full
 mpA=$MNTHEAD/"$$"_mpA
 mpB=$MNTHEAD/"$$"_mpB
diff --git a/tests/generic/411 b/tests/generic/411
index 414d3a5..7b2dd33 100755
--- a/tests/generic/411
+++ b/tests/generic/411
@@ -37,6 +37,8 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	_clear_mount_stack
+	# make sure there's no bug cause dentry isn't be freed
+	rm -rf $MNTHEAD
 }
 
 # get standard environment, filters and checks
@@ -78,6 +80,7 @@ fs_stress()
 
 # prepare some mountpoint dir
 MNTHEAD=$TEST_DIR/$seq
+rm -rf $MNTHEAD
 mkdir $MNTHEAD 2>>$seqres.full
 mpA=$MNTHEAD/"$$"_mpA
 mpB=$MNTHEAD/"$$"_mpB
-- 
2.7.4

