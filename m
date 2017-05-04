Received: from mx1.redhat.com ([209.132.183.28]:52530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbdEDJwx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 05:52:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7A8937F7A5
        for <fstests@vger.kernel.org>; Thu,  4 May 2017 09:52:53 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/2] tasks-upstream: add xfs rmapbt and reflink tests to xfs regression and ltp tests
Date: Thu,  4 May 2017 17:52:39 +0800
Message-Id: <20170504095239.15901-2-eguan@redhat.com>
In-Reply-To: <20170504095239.15901-1-eguan@redhat.com>
References: <20170504095239.15901-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tasks-upstream/function-ltp-aiodio.task | 16 ++++++++++++++++
 tasks-upstream/function-ltp.task        | 26 ++++++++++++++++++++++++--
 tasks-upstream/regression-xfs.task      | 18 ++++++++++++++++++
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/tasks-upstream/function-ltp-aiodio.task b/tasks-upstream/function-ltp-aiodio.task
index 6bbadf8..644b8e8 100644
--- a/tasks-upstream/function-ltp-aiodio.task
+++ b/tasks-upstream/function-ltp-aiodio.task
@@ -41,6 +41,22 @@ param=MKFS_OPTS=-m crc=1
 distro=-el6
 arch=all
 
+[xfs-rmap]
+desc=ltp-aiodio tests on xfs with rmapbt enabled
+tag=tier2 xfs
+param=FSTYP=xfs
+param=MKFS_OPTS=-m rmap=1
+distro=-el6
+arch=all
+
+[xfs-reflink]
+desc=ltp-aiodio tests on xfs with reflink enabled
+tag=tier2 xfs
+param=FSTYP=xfs
+param=MKFS_OPTS=-m reflink=1
+distro=-el6
+arch=all
+
 [xfs-sparse]
 desc=ltp-aiodio tests on xfs with crc and sparse enabled
 tag=tier3 xfs
diff --git a/tasks-upstream/function-ltp.task b/tasks-upstream/function-ltp.task
index 9a92801..e477860 100644
--- a/tasks-upstream/function-ltp.task
+++ b/tasks-upstream/function-ltp.task
@@ -48,6 +48,30 @@ distro=-el6
 partition=fs="xfs" name="/mnt/ltp" size="5" type="part"
 arch=all
 
+[xfs-rmap]
+desc=ltp tests on xfs with rmapbt enabled
+tag=tier2 xfs
+param=FSTYP=xfs
+# TEST_MNT should not be /mnt/testarea, unable to umount /mnt/testarea since beaker
+# is using it. So let's grab the test device mounted on /mnt/ltp then mount it on
+# /mnt/testarea
+param=TEST_MNT=/mnt/ltp
+param=MKFS_OPTS=-m rmap=1
+partition=fs="xfs" name="/mnt/ltp" size="5" type="part"
+arch=all
+
+[xfs-reflink]
+desc=ltp tests on xfs with reflink enabled
+tag=tier2 xfs
+param=FSTYP=xfs
+# TEST_MNT should not be /mnt/testarea, unable to umount /mnt/testarea since beaker
+# is using it. So let's grab the test device mounted on /mnt/ltp then mount it on
+# /mnt/testarea
+param=TEST_MNT=/mnt/ltp
+param=MKFS_OPTS=-m reflink=1
+partition=fs="xfs" name="/mnt/ltp" size="5" type="part"
+arch=all
+
 [xfs-sparse]
 desc=ltp tests on xfs with crc and sparse enabled
 tag=tier3 xfs
@@ -57,8 +81,6 @@ param=FSTYP=xfs
 # /mnt/testarea
 param=TEST_MNT=/mnt/ltp
 param=MKFS_OPTS=-m crc=1 -i sparse=1
-# only RHEL7 supports v5 xfs
-distro=-el6
 partition=fs="xfs" name="/mnt/ltp" size="5" type="part"
 arch=all
 
diff --git a/tasks-upstream/regression-xfs.task b/tasks-upstream/regression-xfs.task
index b017177..32758c2 100644
--- a/tasks-upstream/regression-xfs.task
+++ b/tasks-upstream/regression-xfs.task
@@ -18,6 +18,24 @@ task=/kernel/filesystems/xfs/regression
 arch=all
 param=MKFS_OPTS=-m crc=1
 
+[xfs-regression-rmap]
+type=regression
+schedule=alone
+tag=tier2 xfs
+desc=xfs regression tests with rmap enabled
+task=/kernel/filesystems/xfs/regression
+arch=all
+param=MKFS_OPTS=-m rmap=1
+
+[xfs-regression-reflink]
+type=regression
+schedule=alone
+tag=tier2 xfs
+desc=xfs regression tests with reflink enabled
+task=/kernel/filesystems/xfs/regression
+arch=all
+param=MKFS_OPTS=-m reflink=1
+
 [xfs-regression-sparse]
 type=regression
 schedule=alone
-- 
2.9.3

