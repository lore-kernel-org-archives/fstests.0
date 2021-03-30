Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95715C433C1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 02:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A5D61994
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Mar 2021 02:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhC3CSd (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:18:33 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35226 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231167AbhC3CSF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 29 Mar 2021 22:18:05 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AUWYfUaB6PKHY9HblHejPsceALOonbusQ8zAX?=
 =?us-ascii?q?/mpaICY6TuWzkceykPMHkSLugDEKV3063fyGMq+MQXTTnKQFh7U5F7GkQQXgpS?=
 =?us-ascii?q?+UPJhvhLGSugHINiXi+odmtZtIXLN5DLTLYWRSrcG/2wWgFsZl/d/vytHMuc77?=
 =?us-ascii?q?71NACT5ncLth6QARMHf9LmRTSBNdDZQ0ULqwj/A3xAaIQngcYsSlCnRtZYGqzL?=
 =?us-ascii?q?enqLvcbRELHBIh4gWV5AnYjILSKQSS3RsVTlp0oIsKzG6tqWPEz5Tml/m6zxPG?=
 =?us-ascii?q?vlWjjah+qZ/a09NGQPaQgtUIMFzX+3uVTbUkS7ufpyo0ve3qzF4rlePHqxAmM9?=
 =?us-ascii?q?8b0QKrQkiF5QvqxxL70Csjr1vryVqji3PlpsDjAB0gDc4pv/MiTjLpr1onoMpn?=
 =?us-ascii?q?0L9Gm0aQt59sBxvGmyjno/jkPisa7naJnQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.81,289,1610380800"; 
   d="scan'208";a="106367610"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Mar 2021 10:18:03 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id F312E4CF267A;
        Tue, 30 Mar 2021 10:18:01 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 30 Mar 2021 10:18:01 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 30 Mar 2021 10:18:00 +0800
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <lihao2018.fnst@fujitsu.com>,
        <david@fromorbit.com>, <xifeng@redhat.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v3 2/2] generic/608: Add new regression test
Date:   Tue, 30 Mar 2021 10:06:55 +0800
Message-ID: <20210330020655.7310-2-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210330020655.7310-1-yangx.jy@fujitsu.com>
References: <20210330020655.7310-1-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: F312E4CF267A.A95B5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Write data into a file and then enable DAX on the file immediately,
the written data which is still in the buffer should be synchronized
to disk instead of discarded when the corresponding inode is evicted.

It's a regression test for commit 88149082bb8e.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tests/generic/608 | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tests/generic/608 b/tests/generic/608
index 5ca2442f..c5bdac32 100755
--- a/tests/generic/608
+++ b/tests/generic/608
@@ -7,6 +7,12 @@
 # file change immediately when all applications close the file.
 # It's a regression test for:
 # 'commit 77573fa310d9 ("fs: Kill DCACHE_DONTCACHE dentry even if DCACHE_REFERENCED is set")'
+#
+# Write data into a file and then enable DAX on the file immediately,
+# the written data which is still in the buffer should be synchronized
+# to disk instead of discarded when the corresponding inode is evicted.
+# It's a regression test for:
+# 'commit 88149082bb8e ("fs: Handle I_DONTCACHE in iput_final() instead of generic_drop_inode()"'
 
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
+	# Without commit 77573fa310d9, ensure inode can
+	# be evicted by drop_caches
+	echo 2 > /proc/sys/vm/drop_caches
+
+	# The written data which is still in the buffer should not be lost
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
 
+	# Do test for commit 88149082bb8e
+	test_buffered_data_lost
+
 	_scratch_unmount
 }
 
-- 
2.21.0



