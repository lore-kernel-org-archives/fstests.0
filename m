Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B71C433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 02:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847B261996
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 02:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhC3CSf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:18:35 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35226 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231205AbhC3CSG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Mar 2021 22:18:06 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AkdfpGaOqdeipKcBcT4P155DYdL4zR+YMi2QD?=
 =?us-ascii?q?/WoZc3JoW+afkN2jm+le6AT9jywfVGpltdeLPqSBRn20z+8Q3aA6O7C+UA76/F?=
 =?us-ascii?q?a5NY0K1/qE/xTMEzDzn9Q86Y5OaK57YeedMXFfreLXpDa1CMwhxt7vytHMuc77?=
 =?us-ascii?q?w212RQ9nL4FMhj0JaTqzKUF9SAlYCZdRLvP1jaArmxObZX8VYs6nb0NlY8H/ob?=
 =?us-ascii?q?Tw+67OUFojDx4j5BLmt0LL1JfKVyKA1hNbaS5G3Ks5mFK16DDR1+Gyte2h0B/A?=
 =?us-ascii?q?2yv255RSotHozdxOH6W3+7EoAwSpmgC1f55gRrHHmDg0pduk4FEsnMKJjAwnO6?=
 =?us-ascii?q?1ImgvsV1DwsR3wwBPhzTprz3fjzGWTiXzlrde8ZB9SMbsmub5k?=
X-IronPort-AV: E=Sophos;i="5.81,289,1610380800"; 
   d="scan'208";a="106367609"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Mar 2021 10:18:03 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id C4DAF4CF2679;
        Tue, 30 Mar 2021 10:18:00 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 30 Mar 2021 10:18:02 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 30 Mar 2021 10:17:59 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <lihao2018.fnst@fujitsu.com>,
        <david@fromorbit.com>, <xifeng@redhat.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3 1/2] generic/608: Remove drop cache and umount & mount cycle
Date:   Tue, 30 Mar 2021 10:06:54 +0800
Message-ID: <20210330020655.7310-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C4DAF4CF2679.A9E55
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since commit 77573fa310d9, toggling FS_XFLAG_DAX on an existing file can make
S_DAX on the file change immediately when all applications close the file.
As a result, we don't need the redundant drop cache and umount & mount cycle.

Signed-off-by: Xiaoli Feng <xifeng@redhat.com>
Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 tests/generic/608 | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/tests/generic/608 b/tests/generic/608
index 861bbff5..5ca2442f 100755
--- a/tests/generic/608
+++ b/tests/generic/608
@@ -3,10 +3,10 @@
 # Copyright (c) 2020 Fujitsu.  All Rights Reserved.
 #
 # FS QA Test 608
-# Change FS_XFLAG_DAX on an existing file and check if S_DAX on
-# the file can take effect immediately by the following steps:
-# 1) Stop all applications which are using the file.
-# 2) Do drop_caches or umount & mount cycle.
+# Toggling FS_XFLAG_DAX on an existing file can make S_DAX on the
+# file change immediately when all applications close the file.
+# It's a regression test for:
+# 'commit 77573fa310d9 ("fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set")'
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -36,7 +36,7 @@ _require_dax_iflag
 _require_xfs_io_command "lsattr" "-v"
 _require_xfs_io_command "statx" "-r"
 
-test_drop_caches()
+test_enable_dax()
 {
 	local t_file=$SCRATCH_MNT/testfile
 
@@ -49,24 +49,19 @@ test_drop_caches()
 
 	$XFS_IO_PROG -c 'chattr +x' $t_file
 	_check_xflag $t_file 1
-	_check_s_dax $t_file 0
-
-	# One application is using test file and check if S_DAX on
-	# the file doesn't take effect immediately by drop_caches
-	echo 2 > /proc/sys/vm/drop_caches
+	# One application is using test file and S_DAX
+	# on the file is not changed immediately
 	_check_s_dax $t_file 0
 
 	exec 3<&-
 
-	# No application is using test file and check if S_DAX on
-	# the file takes effect immediately by drop_caches
-	echo 2 > /proc/sys/vm/drop_caches
+	# No application is using test file and S_DAX
+	# on the file is changed immediately
 	_check_s_dax $t_file 1
 }
 
-test_cycle_mount()
+test_disable_dax()
 {
-	local option=$1
 	local t_dir=$SCRATCH_MNT/testdir
 	local t_file=$t_dir/testfile
 
@@ -81,29 +76,29 @@ test_cycle_mount()
 
 	$XFS_IO_PROG -c 'chattr -x' $t_file
 	_check_xflag $t_file 0
+	# One application is using test file and S_DAX
+	# on the file is not changed immediately
 	_check_s_dax $t_file 1
 
 	exec 3<&-
 
-	# No application is using test file and check if S_DAX on
-	# the file takes effect immediately by umount & mount
-	_scratch_cycle_mount "$option"
+	# No application is using test file and S_DAX
+	# on the file is changed immediately
 	_check_s_dax $t_file 0
 }
 
 do_tests()
 {
 	local mount_option=$1
-	local cycle_mount_option=$2
 
 	_scratch_mount "$mount_option"
 
 	# Make sure the root dir doesn't have FS_XFLAG_DAX set before we start.
 	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT &>> $seqres.full
 
-	test_drop_caches
-
-	test_cycle_mount "$cycle_mount_option"
+	# Do test for commit 77573fa310d9
+	test_enable_dax
+	test_disable_dax
 
 	_scratch_unmount
 }
@@ -111,7 +106,7 @@ do_tests()
 _scratch_mkfs >> $seqres.full 2>&1
 
 # Mount with dax option
-do_tests "-o dax=inode" "dax=inode"
+do_tests "-o dax=inode"
 
 # Mount without dax option
 export MOUNT_OPTIONS=""
-- 
2.21.0



