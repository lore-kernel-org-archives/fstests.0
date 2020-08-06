Return-Path: <SRS0=LCFT=BQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD84C433E1
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 918DB20823
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgHFCVj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:21:39 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64121 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726150AbgHFCVi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Aug 2020 22:21:38 -0400
X-IronPort-AV: E=Sophos;i="5.75,440,1589212800"; 
   d="scan'208";a="97677614"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2020 10:21:20 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 38AC44CE34F3;
        Thu,  6 Aug 2020 10:21:16 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 6 Aug 2020 10:21:16 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 6 Aug 2020 10:21:16 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        <guaneryu@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v9 4/8] generic/413, xfs/260: Improve format operation for PMD fault testing
Date:   Thu, 6 Aug 2020 10:13:38 +0800
Message-ID: <20200806021342.10596-5-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
References: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 38AC44CE34F3.ACBF9
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

1) Simple code and fix the wrong value of stripe_width by _scratch_mkfs_geom().
2) Get hugepage size by _get_hugepagesize() and replace fixed 2M with
   hugepage size because hugepage size/PMD_SIZE is not 2M on some
   arches(e.g. hugepage size/PMD_SIZE is 512M on arm64).
3) For debugging, redirect the output of mkfs to $seqres.full.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/rc         | 10 ++++++++++
 tests/generic/413 | 10 ++--------
 tests/xfs/260     |  4 ++--
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/common/rc b/common/rc
index ad4d080d..98bb1454 100644
--- a/common/rc
+++ b/common/rc
@@ -170,6 +170,16 @@ _get_filesize()
     stat -c %s "$1"
 }
 
+# Get hugepagesize in bytes
+_get_hugepagesize()
+{
+	local hugepgsz=$(awk '/Hugepagesize/ {print $2}' /proc/meminfo)
+	# Call _notrun if $hugepgsz is not a number
+	echo "$hugepgsz" | egrep -q ^[0-9]+$ || \
+		_notrun "Cannot get the value of Hugepagesize"
+	echo $((hugepgsz * 1024))
+}
+
 _mount()
 {
     $MOUNT_PROG `_mount_ops_filter $*`
diff --git a/tests/generic/413 b/tests/generic/413
index 19e1b926..dfe2912b 100755
--- a/tests/generic/413
+++ b/tests/generic/413
@@ -111,14 +111,8 @@ do_tests()
 	t_mmap_dio_dax $((64 * 1024 * 1024))
 }
 
-# make fs 2Mb aligned for PMD fault testing
-mkfs_opts=""
-if [ "$FSTYP" == "ext4" ]; then
-	mkfs_opts="-E stride=512,stripe_width=1"
-elif [ "$FSTYP" == "xfs" ]; then
-	mkfs_opts="-d su=2m,sw=1"
-fi
-_scratch_mkfs "$mkfs_opts" > /dev/null 2>&1
+# make fs aligned for PMD fault testing
+_scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
 
 # mount SCRATCH_DEV with dax option, TEST_DEV not
 export MOUNT_OPTIONS=""
diff --git a/tests/xfs/260 b/tests/xfs/260
index bcdc6041..81b42f01 100755
--- a/tests/xfs/260
+++ b/tests/xfs/260
@@ -121,8 +121,8 @@ do_tests()
 	t_dax_flag_mmap_dio $((64 * 1024 * 1024))
 }
 
-# make xfs 2Mb aligned for PMD fault testing
-_scratch_mkfs "-d su=2m,sw=1" > /dev/null 2>&1
+# make xfs aligned for PMD fault testing
+_scratch_mkfs_geom $(_get_hugepagesize) 1 >> $seqres.full 2>&1
 
 # mount with dax option
 _scratch_mount "-o dax"
-- 
2.21.0



