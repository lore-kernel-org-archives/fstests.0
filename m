Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC36C433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD0B20772
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgGIJ4b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:56:31 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45174 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726750AbgGIJ4a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 05:56:30 -0400
X-IronPort-AV: E=Sophos;i="5.75,331,1589212800"; 
   d="scan'208";a="95982697"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Jul 2020 17:56:26 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 3C89B4CE3F11;
        Thu,  9 Jul 2020 17:56:21 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 9 Jul 2020 17:56:22 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 9 Jul 2020 17:56:22 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v5 6/8] xfs/260: Move and update xfs/260
Date:   Thu, 9 Jul 2020 17:49:15 +0800
Message-ID: <20200709094917.13923-7-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
References: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3C89B4CE3F11.ACB35
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Both ext4 and xfs have supported FS_XFLAG_DAX so move it to generic.
2) Modifying FS_XFLAG_DAX on flies does not take effect immediately so
   make files inherit the DAX state of parent directory.
3) Setting/clearing FS_XFLAG_DAX have no chance to change S_DAX flag if
   mount with dax option so remove the related subtest.
4) Setting/clearing FS_XFLAG_DAX doesn't change S_DAX flag on older xfs
   due to commit 742d84290739 ("xfs: disable per-inode DAX flag") so
   only do test when fs supports new dax=inode option.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 tests/{xfs/260 => generic/603} | 68 +++++++++++++++++-----------------
 tests/generic/603.out          |  2 +
 tests/generic/group            |  1 +
 tests/xfs/260.out              |  2 -
 tests/xfs/group                |  1 -
 5 files changed, 36 insertions(+), 38 deletions(-)
 rename tests/{xfs/260 => generic/603} (57%)
 create mode 100644 tests/generic/603.out
 delete mode 100644 tests/xfs/260.out

diff --git a/tests/xfs/260 b/tests/generic/603
similarity index 57%
rename from tests/xfs/260
rename to tests/generic/603
index 81b42f01..1f6a2d45 100755
--- a/tests/xfs/260
+++ b/tests/generic/603
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2017 Red Hat Inc.  All Rights Reserved.
 #
-# FS QA Test 260
+# FS QA Test 603
 #
 # Test per-inode DAX flag by mmap direct/buffered IO.
 #
@@ -28,76 +28,80 @@ _cleanup()
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
-_supported_fs xfs
+_supported_fs generic
 _supported_os Linux
-_require_scratch_dax_mountopt "dax"
+_require_scratch_dax_mountopt "dax=inode"
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_dax_iflag
 _require_xfs_io_command "falloc"
 
-prep_files()
+SRC_DIR=$SCRATCH_MNT/src
+SRC_FILE=$SRC_DIR/tf_s
+DST_DIR=$SCRATCH_MNT/dst
+DST_FILE=$DST_DIR/tf_d
+
+prep_directories()
 {
-	rm -f $SCRATCH_MNT/tf_{s,d}
+	mkdir -p $SRC_DIR $DST_DIR
+}
 
+prep_files()
+{
+	rm -f $SRC_FILE $DST_FILE
 	$XFS_IO_PROG -f -c "falloc 0 $tsize" \
-		$SCRATCH_MNT/tf_{s,d} >> $seqres.full 2>&1
+		$SRC_FILE $DST_FILE >> $seqres.full 2>&1
 }
 
 t_both_dax()
 {
+	$XFS_IO_PROG -c "chattr +x" $SRC_DIR $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
 	# with O_DIRECT first
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} $1 "dio both dax"
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
+		$1 "dio both dax"
 
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_{s,d}
 	# again with buffered IO
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered both dax"
 }
 
 t_nondax_to_dax()
 {
+	$XFS_IO_PROG -c "chattr -x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr +x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
 		$1 "dio nondax to dax"
 
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered nondax to dax"
 }
 
 t_dax_to_nondax()
 {
+	$XFS_IO_PROG -c "chattr +x" $SRC_DIR
+	$XFS_IO_PROG -c "chattr -x" $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
 		$1 "dio dax to nondax"
 
 	prep_files
-	$XFS_IO_PROG -c "chattr +x" $SCRATCH_MNT/tf_s
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_d
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered dax to nondax"
 }
 
 t_both_nondax()
 {
+	$XFS_IO_PROG -c "chattr -x" $SRC_DIR $DST_DIR
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	$here/src/t_mmap_dio $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio $SRC_FILE $DST_FILE \
 		$1 "dio both nondax"
 
 	prep_files
-	$XFS_IO_PROG -c "chattr -x" $SCRATCH_MNT/tf_{s,d}
-	$here/src/t_mmap_dio -b $SCRATCH_MNT/tf_{s,d} \
+	$here/src/t_mmap_dio -b $SRC_FILE $DST_FILE \
 		$1 "buffered both nondax"
 }
 
@@ -112,6 +116,7 @@ t_dax_flag_mmap_dio()
 
 do_tests()
 {
+	prep_directories
 	# less than page size
 	t_dax_flag_mmap_dio 1024
 	# page size
@@ -124,17 +129,10 @@ do_tests()
 # make xfs aligned for PMD fault testing
 _scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
 
-# mount with dax option
-_scratch_mount "-o dax"
-
 tsize=$((128 * 1024 * 1024))
 
-do_tests
-_scratch_unmount
-
-# mount again without dax option
-export MOUNT_OPTIONS=""
-_scratch_mount
+# mount with dax=inode option
+_scratch_mount "-o dax=inode"
 do_tests
 
 # success, all done
diff --git a/tests/generic/603.out b/tests/generic/603.out
new file mode 100644
index 00000000..6810da89
--- /dev/null
+++ b/tests/generic/603.out
@@ -0,0 +1,2 @@
+QA output created by 603
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index d9ab9a31..1d0d5606 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -605,3 +605,4 @@
 600 auto quick quota
 601 auto quick quota
 602 auto quick encrypt
+603 auto attr quick dax
diff --git a/tests/xfs/260.out b/tests/xfs/260.out
deleted file mode 100644
index 18ca517c..00000000
--- a/tests/xfs/260.out
+++ /dev/null
@@ -1,2 +0,0 @@
-QA output created by 260
-Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index daf54add..71c30898 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -257,7 +257,6 @@
 257 auto quick clone
 258 auto quick clone
 259 auto quick
-260 auto attr quick dax
 261 auto quick quota
 262 dangerous_fuzzers dangerous_scrub dangerous_online_repair
 263 auto quick quota
-- 
2.21.0



