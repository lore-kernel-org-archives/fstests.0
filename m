Return-Path: <SRS0=vVM5=AU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CA7C433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42C1520708
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Jul 2020 09:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgGIJ4Z (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:56:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:45172 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726756AbgGIJ4Y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Jul 2020 05:56:24 -0400
X-IronPort-AV: E=Sophos;i="5.75,331,1589212800"; 
   d="scan'208";a="95982685"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Jul 2020 17:56:20 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 016884CE506F;
        Thu,  9 Jul 2020 17:56:18 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 9 Jul 2020 17:56:19 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 9 Jul 2020 17:56:18 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v5 2/8] fstests: Use _require_scratch_dax_mountopt() and _require_dax_iflag()
Date:   Thu, 9 Jul 2020 17:49:11 +0800
Message-ID: <20200709094917.13923-3-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
References: <20200709094917.13923-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 016884CE506F.AEE92
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make related tests use _require_scratch_dax_mountopt() and _require_dax_iflag()

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
---
 tests/ext4/030    | 2 +-
 tests/ext4/031    | 4 ++--
 tests/generic/413 | 2 +-
 tests/generic/462 | 2 +-
 tests/xfs/260     | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

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



