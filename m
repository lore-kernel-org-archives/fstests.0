Return-Path: <SRS0=LCFT=BQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C2FC433DF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0353D22B40
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFCVn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:21:43 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64121 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbgHFCVn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Aug 2020 22:21:43 -0400
X-IronPort-AV: E=Sophos;i="5.75,440,1589212800"; 
   d="scan'208";a="97677618"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2020 10:21:20 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 371C84CE34EF;
        Thu,  6 Aug 2020 10:21:15 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 6 Aug 2020 10:21:16 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 6 Aug 2020 10:21:15 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        <guaneryu@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v9 2/8] fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
Date:   Thu, 6 Aug 2020 10:13:36 +0800
Message-ID: <20200806021342.10596-3-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
References: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 371C84CE34EF.ACB16
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Make related tests use _require_scratch_dax_mountopt() and _require_dax_iflag().
2) Remove unused _require_scratch_dax().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/rc         | 14 --------------
 tests/ext4/030    |  2 +-
 tests/ext4/031    |  4 ++--
 tests/generic/413 |  2 +-
 tests/generic/462 |  2 +-
 tests/xfs/260     |  4 ++--
 6 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/common/rc b/common/rc
index fa70453d..359d03ad 100644
--- a/common/rc
+++ b/common/rc
@@ -3174,20 +3174,6 @@ _require_scratch_shutdown()
 	_scratch_unmount
 }
 
-# Does dax mount option work on this dev/fs?
-_require_scratch_dax()
-{
-	_require_scratch
-	_scratch_mkfs > /dev/null 2>&1
-	_try_scratch_mount -o dax || \
-		_notrun "mount $SCRATCH_DEV with dax failed"
-	# Check options to be sure. XFS ignores dax option
-	# and goes on if dev underneath does not support dax.
-	_fs_options $SCRATCH_DEV | grep -qw "dax" || \
-		_notrun "$SCRATCH_DEV $FSTYP does not support -o dax"
-	_scratch_unmount
-}
-
 # Check if dax mount options are supported
 #
 # $1 can be either 'dax=always' or 'dax'
diff --git a/tests/ext4/030 b/tests/ext4/030
index 93bbca86..fb5cf451 100755
--- a/tests/ext4/030
+++ b/tests/ext4/030
@@ -33,7 +33,7 @@ rm -f $seqres.full
 # Modify as appropriate.
 _supported_os Linux
 _supported_fs ext4
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_journal_corruption"
 _require_command "$CHATTR_PROG" chattr
 
diff --git a/tests/ext4/031 b/tests/ext4/031
index dc58214e..20e2fab7 100755
--- a/tests/ext4/031
+++ b/tests/ext4/031
@@ -37,7 +37,7 @@ MOUNT_OPTIONS=""
 # Modify as appropriate.
 _supported_os Linux
 _supported_fs ext4
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "t_ext4_dax_inline_corruption"
 _require_scratch_ext4_feature "inline_data"
 
@@ -56,7 +56,7 @@ _scratch_unmount >> $seqres.full 2>&1
 _try_scratch_mount "-o dax" >> $seqres.full 2>&1
 
 if [[ $? != 0 ]]; then
-	# _require_scratch_dax already verified that we could mount with DAX.
+	# _require_scratch_dax_mountopt already verified that we could mount with DAX.
 	# Failure here is expected because we have inline data.
 	echo "Silence is golden"
 	status=0
diff --git a/tests/generic/413 b/tests/generic/413
index 1ce89aff..19e1b926 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -31,7 +31,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
 _require_xfs_io_command "falloc"
diff --git a/tests/generic/462 b/tests/generic/462
index 1ab6cadc..4a940239 100755
--- a/tests/generic/462
+++ b/tests/generic/462
@@ -37,7 +37,7 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_test
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "t_mmap_write_ro"
 # running by unpriviliged user is not necessary to reproduce
 # this bug, just trying to test more.
diff --git a/tests/xfs/260 b/tests/xfs/260
index 3464ffef..bcdc6041 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -30,10 +30,10 @@ rm -f $seqres.full
 
 _supported_fs xfs
 _supported_os Linux
-_require_scratch_dax
+_require_scratch_dax_mountopt "dax"
 _require_test_program "feature"
 _require_test_program "t_mmap_dio"
-_require_xfs_io_command "chattr" "x"
+_require_dax_iflag
 _require_xfs_io_command "falloc"
 
 prep_files()
-- 
2.21.0



