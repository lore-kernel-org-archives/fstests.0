Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F5DC433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhLNITZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:25 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:65312 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229565AbhLNITY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:24 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AQNkm8al/0Bco0WfbR4s+1yLo5gydJERdPkR7XQ2?=
 =?us-ascii?q?eYbTBsI5bpzIAyWRKD2GCaf3eajajfop3OYvg/EIP78WEytFkQAJt+CA2RRqmi?=
 =?us-ascii?q?+KfW43BcR2Y0wB+jyH7ZBs+qZ1YM7EsFehsJpPnjkrrYuiJQUVUj/nSH+OmUbK?=
 =?us-ascii?q?cY0ideCc/IMsfoUM68wIGqt4w6TSJK1vlVeLa+6UzCnf8s9JHGj58B5a4lf9al?=
 =?us-ascii?q?K+aVAX0EbAJTasjUFf2zxH5BX+ETE27ByOQroJ8RoZWSwtfpYxV8F81/z91Yj+?=
 =?us-ascii?q?kur39NEMXQL/OJhXIgX1TM0SgqkEa4HVsjeBgb7xBAatUo2zhc9RZ0shEs4ehD?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCHv4ZPDkxOfG5fr67A0ZK0sBqUW4fp6Gn1?=
 =?us-ascii?q?V3eIXJSpLbR2Zge+yhrWhRYFRam4LRCXwFNpH/Cg+kneCVrB7Ka0vip7ivbdwt?=
 =?us-ascii?q?ArcTOgQdRoGW/ckVA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A9wNOdKgRjn/yhTKEZ/PDfiqIl3BQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878461"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:21 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id AEE2F4D144C6
        for <fstests@vger.kernel.org>; Tue, 14 Dec 2021 16:19:19 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:19 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:17 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 05/17] common/rc: Introduce _require_scratch_delalloc()
Date:   Tue, 14 Dec 2021 16:19:02 +0800
Message-ID: <20211214081914.2478122-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
References: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: AEE2F4D144C6.A3382
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Check whether delalloc is supported on current device.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 common/rc         | 13 +++++++++++++
 tests/generic/194 |  1 +
 tests/generic/195 |  1 +
 tests/generic/199 |  1 +
 tests/generic/200 |  1 +
 tests/generic/293 |  1 +
 tests/generic/295 |  1 +
 tests/generic/540 |  1 +
 tests/generic/541 |  1 +
 tests/generic/542 |  1 +
 tests/generic/543 |  1 +
 tests/xfs/172     | 12 +-----------
 tests/xfs/223     |  1 +
 tests/xfs/224     |  1 +
 tests/xfs/228     |  1 +
 tests/xfs/230     |  1 +
 tests/xfs/257     |  1 +
 tests/xfs/258     |  1 +
 18 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/common/rc b/common/rc
index 7973ceb5..a419b3ba 100644
--- a/common/rc
+++ b/common/rc
@@ -1748,6 +1748,19 @@ _require_scratch_16T_support()
 	esac
 }
 
+# Require scratch fs supports delay allocation.
+_require_scratch_delalloc()
+{
+	_require_command "$FILEFRAG_PROG" filefrag
+
+	_scratch_mkfs > $seqres.full
+	_scratch_mount
+	$XFS_IO_PROG -f -c 'pwrite 0 64k' $SCRATCH_MNT/testy &> /dev/null
+	$FILEFRAG_PROG -v $SCRATCH_MNT/testy 2>&1 | grep -q delalloc || \
+		_notrun "test requires delayed allocation buffered writes"
+	_scratch_unmount
+}
+
 # this test needs a test partition - check we're ok & mount it
 #
 _require_test()
diff --git a/tests/generic/194 b/tests/generic/194
index ce8c31ac..ff76438d 100755
--- a/tests/generic/194
+++ b/tests/generic/194
@@ -28,6 +28,7 @@ _cleanup()
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_odirect
 
diff --git a/tests/generic/195 b/tests/generic/195
index da502c39..e087b99c 100755
--- a/tests/generic/195
+++ b/tests/generic/195
@@ -28,6 +28,7 @@ _cleanup()
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 
 echo "Format and mount"
diff --git a/tests/generic/199 b/tests/generic/199
index ab13f58e..2a8cafcc 100755
--- a/tests/generic/199
+++ b/tests/generic/199
@@ -31,6 +31,7 @@ _cleanup()
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 _require_cp_reflink
diff --git a/tests/generic/200 b/tests/generic/200
index deadfeaa..a1a78ef4 100755
--- a/tests/generic/200
+++ b/tests/generic/200
@@ -31,6 +31,7 @@ _cleanup()
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "fpunch"
 _require_cp_reflink
diff --git a/tests/generic/293 b/tests/generic/293
index 74231b4d..0f1d8416 100755
--- a/tests/generic/293
+++ b/tests/generic/293
@@ -24,6 +24,7 @@ _begin_fstest auto quick clone
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 
 echo "Format and mount"
diff --git a/tests/generic/295 b/tests/generic/295
index b921c79b..f66c1805 100755
--- a/tests/generic/295
+++ b/tests/generic/295
@@ -24,6 +24,7 @@ _begin_fstest auto quick clone
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_odirect
 
diff --git a/tests/generic/540 b/tests/generic/540
index 69cf635f..38e00f97 100755
--- a/tests/generic/540
+++ b/tests/generic/540
@@ -26,6 +26,7 @@ _begin_fstest auto quick clone
 # real QA test starts here
 _supported_fs generic
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 
 echo "Format and mount"
diff --git a/tests/generic/541 b/tests/generic/541
index 925f346e..89b2adad 100755
--- a/tests/generic/541
+++ b/tests/generic/541
@@ -26,6 +26,7 @@ _begin_fstest auto quick clone
 # real QA test starts here
 _supported_fs generic
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 
 echo "Format and mount"
diff --git a/tests/generic/542 b/tests/generic/542
index e3e627a8..e7682f59 100755
--- a/tests/generic/542
+++ b/tests/generic/542
@@ -26,6 +26,7 @@ _begin_fstest auto quick clone
 # real QA test starts here
 _supported_fs generic
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 
 echo "Format and mount"
diff --git a/tests/generic/543 b/tests/generic/543
index 047bedd5..624cfc41 100755
--- a/tests/generic/543
+++ b/tests/generic/543
@@ -26,6 +26,7 @@ _begin_fstest auto quick clone
 # real QA test starts here
 _supported_fs generic
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 
 echo "Format and mount"
diff --git a/tests/xfs/172 b/tests/xfs/172
index c0495305..56c2583b 100755
--- a/tests/xfs/172
+++ b/tests/xfs/172
@@ -16,7 +16,6 @@ _begin_fstest rw filestreams
 
 # real QA test starts here
 _supported_fs xfs
-_require_command "$FILEFRAG_PROG" filefrag
 _require_scratch
 
 # The first _test_streams call sets up the filestreams allocator to fail and
@@ -36,16 +35,7 @@ _require_scratch
 # rescan thresholds and will keep pushing out the expiration time, with the
 # result that the filestreams allocator succeeds in maintaining the streams.
 # The test considers this a failure.
-#
-# Make sure that a regular buffered write produces delalloc reservations.
-# This effectively disables the test for files with extent size hints or DAX
-# mode set.
-_scratch_mkfs > $seqres.full
-_scratch_mount
-$XFS_IO_PROG -f -c 'pwrite 0 64k' $SCRATCH_MNT/testy &> /dev/null
-$FILEFRAG_PROG -v $SCRATCH_MNT/testy 2>&1 | grep -q delalloc || \
-	_notrun "test requires delayed allocation buffered writes"
-_scratch_unmount
+_require_scratch_delalloc
 
 _check_filestreams_support || _notrun "filestreams not available"
 
diff --git a/tests/xfs/223 b/tests/xfs/223
index f002f1de..11dbad14 100755
--- a/tests/xfs/223
+++ b/tests/xfs/223
@@ -22,6 +22,7 @@ _begin_fstest auto quick clone
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
 _require_odirect
diff --git a/tests/xfs/224 b/tests/xfs/224
index 11a54fa3..f8bab07e 100755
--- a/tests/xfs/224
+++ b/tests/xfs/224
@@ -22,6 +22,7 @@ _begin_fstest auto quick clone
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
 
diff --git a/tests/xfs/228 b/tests/xfs/228
index 5c644c0f..f2f2f6a9 100755
--- a/tests/xfs/228
+++ b/tests/xfs/228
@@ -25,6 +25,7 @@ _begin_fstest auto quick clone punch
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/230 b/tests/xfs/230
index 53e8dd78..15f6b684 100755
--- a/tests/xfs/230
+++ b/tests/xfs/230
@@ -25,6 +25,7 @@ _begin_fstest auto quick clone punch
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
 _require_xfs_io_command "fpunch"
diff --git a/tests/xfs/257 b/tests/xfs/257
index acd55c22..6a58f0ac 100755
--- a/tests/xfs/257
+++ b/tests/xfs/257
@@ -25,6 +25,7 @@ _begin_fstest auto quick clone
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
 
diff --git a/tests/xfs/258 b/tests/xfs/258
index 25e8eb60..2865cdf9 100755
--- a/tests/xfs/258
+++ b/tests/xfs/258
@@ -25,6 +25,7 @@ _begin_fstest auto quick clone
 
 # real QA test starts here
 _require_scratch_reflink
+_require_scratch_delalloc
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "cowextsize"
 _require_odirect
-- 
2.34.1



