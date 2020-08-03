Return-Path: <SRS0=C+DF=BN=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7C2C433E0
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82F32070A
	for <linux-fstests@archiver.kernel.org>; Mon,  3 Aug 2020 08:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHCIqU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 3 Aug 2020 04:46:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:44092 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726011AbgHCIqT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 3 Aug 2020 04:46:19 -0400
X-IronPort-AV: E=Sophos;i="5.75,429,1589212800"; 
   d="scan'208";a="97500116"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Aug 2020 16:46:07 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 6E6FD4CE545F;
        Mon,  3 Aug 2020 16:46:05 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 3 Aug 2020 16:46:09 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 3 Aug 2020 16:46:08 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <darrick.wong@oracle.com>,
        <ira.weiny@intel.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v8 4/7] generic/413, xfs/260: Improve format operation for PMD fault testing
Date:   Mon, 3 Aug 2020 16:38:35 +0800
Message-ID: <20200803083838.26222-5-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
References: <20200803083838.26222-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6E6FD4CE545F.ADB87
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
index 0c4d02b9..75b20f96 100644
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



