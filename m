Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA28C433C1
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 09:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842356195B
	for <linux-fstests@archiver.kernel.org>; Mon, 29 Mar 2021 09:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhC2JcU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:32:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:25030 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232354AbhC2JcT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Mar 2021 05:32:19 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A2zGQtqMeZHlCFcBcT6L155DYdL4zR+YMi2QD?=
 =?us-ascii?q?/WoZc3JoW+afkN2jm+le6AT9jywfVGpltdeLPqSBRn20z+8S3aA6O7C+UA76/F?=
 =?us-ascii?q?a5NY0K1/qa/xTMEzDzn9Q86Y5OaK57YeedMXFbioLA7BC8A5IcxrC8gcWVrMP/?=
 =?us-ascii?q?61socg1wcaFn6G5Ce2GmO2l7XhNPC5Z8NLf03LslmxOadX4abtu2CxA+NoCpzb?=
 =?us-ascii?q?D2vanrbhIcCxks5BPmt0LN1JfBDxOa0h0COgkv/Z4e9wH+/DDR1+GGu/G/xgS0?=
 =?us-ascii?q?7R6w071m3OH5wt8GPtGFl9QOQw+c9zqAVcBwXaGYpjAprKWK4FYuqtPFpBAtJK?=
 =?us-ascii?q?1ImgjsV1DwsR3wwBPhzTprz3fjzGWTiXzlrde8ayk9D6N69PhkWyqc+0w9p8t9?=
 =?us-ascii?q?za4O+2qYsqBcBRTGkD+4x/WgbWATqnaJ?=
X-IronPort-AV: E=Sophos;i="5.81,287,1610380800"; 
   d="scan'208";a="106318796"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Mar 2021 17:32:12 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id CE8444CF267A;
        Mon, 29 Mar 2021 17:32:09 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 29 Mar 2021 17:32:11 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Mon, 29 Mar 2021 17:32:10 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <lihao2018.fnst@fujitsu.com>,
        <david@fromorbit.com>, <xifeng@redhat.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2 2/2] generic/608: Add new regression test
Date:   Mon, 29 Mar 2021 17:20:54 +0800
Message-ID: <20210329092054.5278-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210329092054.5278-1-yangx.jy@fujitsu.com>
References: <20210329092054.5278-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: CE8444CF267A.A74CF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Write data into a file and then enable DAX on the file immediately,
the written data which is still in the buffer will be lost when
the corresponding inode is evicted.

It's a regression test for commit 26b15a042b8a.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/generic/608 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tests/generic/608 b/tests/generic/608
index d81a2488..674bd2cf 100755
--- a/tests/generic/608
+++ b/tests/generic/608
@@ -7,6 +7,12 @@
 # file change immediately when all applications close the file.
 # It's a regression test for:
 # 'commit e7bed0b5bc4b ("fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set")'
+#
+# Write data into a file and then enable DAX on the file immediately,
+# the written data which is still in the buffer will be lost when the
+# corresponding inode is evicted.
+# It's a regression test for:
+# 'commit 26b15a042b8a ("fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()"'
 
 seq=`basename $0`
 seqres=$RESULT_DIR/$seq
@@ -87,6 +93,26 @@ test_disable_dax()
 	_check_s_dax $t_file 0
 }
 
+test_buffered_data_lost()
+{
+	local t_file=$SCRATCH_MNT/datafile
+
+	# Write data into a file
+	echo "Buffered data" > $t_file
+
+	# Then enable DAX on the file immediately
+	$XFS_IO_PROG -c 'chattr +x' $t_file
+
+	# Without commit e7bed0b5bc4b, ensure inode can
+	# be evicted by drop_caches
+	echo 2 > /proc/sys/vm/drop_caches
+
+	# The written data which is still in the buffer will be lost
+	grep -q "Buffered data" $t_file || echo "Buffered data is lost"
+
+	rm -f $t_file
+}
+
 do_tests()
 {
 	local mount_option=$1
@@ -100,6 +126,9 @@ do_tests()
 	test_enable_dax
 	test_disable_dax
 
+	# Do test for commit 26b15a042b8a
+	test_buffered_data_lost
+
 	_scratch_unmount
 }
 
-- 
2.21.0



