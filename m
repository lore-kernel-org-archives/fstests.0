Received: from mx1.redhat.com ([209.132.183.28]:38608 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751482AbdEDJww (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 4 May 2017 05:52:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A728F15561
        for <fstests@vger.kernel.org>; Thu,  4 May 2017 09:52:51 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/2] tasks-upstream: remove xfs finobt tests and add sparse inode tests
Date: Thu,  4 May 2017 17:52:38 +0800
Message-Id: <20170504095239.15901-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

finobt feature is enabled by default in upstream xfsprogs, there's
no need to test finobt explicitly.

Instead, test sparse inode feature, which is off by default.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 tasks-upstream/function-ltp-aiodio.task |  8 +++-----
 tasks-upstream/function-ltp.task        |  8 +++-----
 tasks-upstream/regression-xfs.task      |  8 ++++----
 tasks-upstream/regression-xfstests.task | 26 ++++++++++++--------------
 4 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/tasks-upstream/function-ltp-aiodio.task b/tasks-upstream/function-ltp-aiodio.task
index 8c7d4f7..6bbadf8 100644
--- a/tasks-upstream/function-ltp-aiodio.task
+++ b/tasks-upstream/function-ltp-aiodio.task
@@ -41,13 +41,11 @@ param=MKFS_OPTS=-m crc=1
 distro=-el6
 arch=all
 
-# free inode btree feature is only available on v5 xfs and it's off by default
-# this feature is only available on RHEL7.2 and later releases
-[xfs-finobt]
-desc=ltp-aiodio tests on xfs with crc and finobt enabled
+[xfs-sparse]
+desc=ltp-aiodio tests on xfs with crc and sparse enabled
 tag=tier3 xfs
 param=FSTYP=xfs
-param=MKFS_OPTS=-m crc=1,finobt=1
+param=MKFS_OPTS=-m crc=1 -i sparse=1
 # only RHEL7 supports v5 xfs
 distro=-el6
 arch=all
diff --git a/tasks-upstream/function-ltp.task b/tasks-upstream/function-ltp.task
index 4f0f1c1..9a92801 100644
--- a/tasks-upstream/function-ltp.task
+++ b/tasks-upstream/function-ltp.task
@@ -48,17 +48,15 @@ distro=-el6
 partition=fs="xfs" name="/mnt/ltp" size="5" type="part"
 arch=all
 
-# free inode btree feature is only available on v5 xfs and it's off by default
-# this feature is only available on RHEL7.2 and later releases
-[xfs-finobt]
-desc=ltp tests on xfs with crc and finobt enabled
+[xfs-sparse]
+desc=ltp tests on xfs with crc and sparse enabled
 tag=tier3 xfs
 param=FSTYP=xfs
 # TEST_MNT should not be /mnt/testarea, unable to umount /mnt/testarea since beaker
 # is using it. So let's grab the test device mounted on /mnt/ltp then mount it on
 # /mnt/testarea
 param=TEST_MNT=/mnt/ltp
-param=MKFS_OPTS=-m crc=1,finobt=1
+param=MKFS_OPTS=-m crc=1 -i sparse=1
 # only RHEL7 supports v5 xfs
 distro=-el6
 partition=fs="xfs" name="/mnt/ltp" size="5" type="part"
diff --git a/tasks-upstream/regression-xfs.task b/tasks-upstream/regression-xfs.task
index b52b3e6..b017177 100644
--- a/tasks-upstream/regression-xfs.task
+++ b/tasks-upstream/regression-xfs.task
@@ -18,13 +18,13 @@ task=/kernel/filesystems/xfs/regression
 arch=all
 param=MKFS_OPTS=-m crc=1
 
-[xfs-regression-finobt]
+[xfs-regression-sparse]
 type=regression
 schedule=alone
 tag=tier3 xfs
-# only RHEL7 supports v5 xfs(metadata checksum) and finobt feature
+# only RHEL7 supports v5 xfs(metadata checksum) and sparse feature
 distro=-el6
-desc=xfs regression tests with crc and finobt enabled
+desc=xfs regression tests with crc and sparse enabled
 task=/kernel/filesystems/xfs/regression
 arch=all
-param=MKFS_OPTS=-m crc=1,finobt=1
+param=MKFS_OPTS=-m crc=1 -i sparse=1
diff --git a/tasks-upstream/regression-xfstests.task b/tasks-upstream/regression-xfstests.task
index e4fe0ba..b332949 100644
--- a/tasks-upstream/regression-xfstests.task
+++ b/tasks-upstream/regression-xfstests.task
@@ -289,16 +289,14 @@ cond: arch_not_s390x ? param=TEST_PARAM_SCRATCH_MNT=/mnt/xfstests/mnt2
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt1" size="15" type="part"
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt2" size="15" type="part"
 
-# free inode btree feature is only available on v5 xfs and it's off by default
-# this feature is only available on RHEL7.2 and later releases
-[xfs-4k-finobt]
-desc=xfstests on xfs with crc and finobt enabled
+[xfs-4k-sparse]
+desc=xfstests on xfs with crc and sparse enabled
 tag=tier2 xfs
 arch=all
 distro=-el6
 param=TEST_PARAM_FSTYPE=xfs
-param=TEST_PARAM_MKFS_OPTS=-m crc=1,finobt=1
-param=TEST_PARAM_KNOWN_ISSUE=upstream_xfs__4k_finobt
+param=TEST_PARAM_MKFS_OPTS=-m crc=1 -i sparse=1
+param=TEST_PARAM_KNOWN_ISSUE=upstream_xfs__4k_sparse
 cond: arch_not_s390x ? param=TEST_PARAM_TEST_DIR=/mnt/xfstests/mnt1
 cond: arch_not_s390x ? param=TEST_PARAM_SCRATCH_MNT=/mnt/xfstests/mnt2
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt1" size="15" type="part"
@@ -331,15 +329,15 @@ cond: arch_not_s390x ? param=TEST_PARAM_SCRATCH_MNT=/mnt/xfstests/mnt2
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt1" size="15" type="part"
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt2" size="15" type="part"
 
-[xfs-2k-finobt]
-desc=xfstests on 2k block size xfs with crc and finobt enabled
+[xfs-2k-sparse]
+desc=xfstests on 2k block size xfs with crc and sparse enabled
 tag=tier3 xfs
 arch=all
 distro=-el6
 param=TEST_PARAM_FSTYPE=xfs
 param=TEST_PARAM_BLKSIZE=2048
-param=TEST_PARAM_MKFS_OPTS=-m crc=1,finobt=1
-param=TEST_PARAM_KNOWN_ISSUE=upstream_xfs__2k_finobt
+param=TEST_PARAM_MKFS_OPTS=-m crc=1 -i sparse=1
+param=TEST_PARAM_KNOWN_ISSUE=upstream_xfs__2k_sparse
 cond: arch_not_s390x ? param=TEST_PARAM_TEST_DIR=/mnt/xfstests/mnt1
 cond: arch_not_s390x ? param=TEST_PARAM_SCRATCH_MNT=/mnt/xfstests/mnt2
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt1" size="15" type="part"
@@ -372,15 +370,15 @@ cond: arch_not_s390x ? param=TEST_PARAM_SCRATCH_MNT=/mnt/xfstests/mnt2
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt1" size="15" type="part"
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt2" size="15" type="part"
 
-[xfs-1k-finobt]
-desc=xfstests on 1k block size xfs with crc and finobt enabled
+[xfs-1k-sparse]
+desc=xfstests on 1k block size xfs with crc and sparse enabled
 tag=tier3 xfs
 arch=all
 distro=-el6
 param=TEST_PARAM_FSTYPE=xfs
 param=TEST_PARAM_BLKSIZE=1024
-param=TEST_PARAM_MKFS_OPTS=-m crc=1,finobt=1
-param=TEST_PARAM_KNOWN_ISSUE=upstream_xfs__1k_finobt
+param=TEST_PARAM_MKFS_OPTS=-m crc=1 -i sparse=1
+param=TEST_PARAM_KNOWN_ISSUE=upstream_xfs__1k_sparse
 cond: arch_not_s390x ? param=TEST_PARAM_TEST_DIR=/mnt/xfstests/mnt1
 cond: arch_not_s390x ? param=TEST_PARAM_SCRATCH_MNT=/mnt/xfstests/mnt2
 cond: arch_not_s390x ? partition=fs="xfs" name="/mnt/xfstests/mnt1" size="15" type="part"
-- 
2.9.3

