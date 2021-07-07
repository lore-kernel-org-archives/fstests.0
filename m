Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C49C07E95
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 10:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D2360FF0
	for <linux-fstests@archiver.kernel.org>; Wed,  7 Jul 2021 10:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhGGKu3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:50:29 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:45189 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhGGKu1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 7 Jul 2021 06:50:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Uf0fj9O_1625654865;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Uf0fj9O_1625654865)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 07 Jul 2021 18:47:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     darrick.wong@oracle.com, guan@eryu.me
Cc:     fstests@vger.kernel.org
Subject: [RFC PATCH] misc: skip fsx tests when op length not congruent with file allocation unit
Date:   Wed,  7 Jul 2021 18:47:45 +0800
Message-Id: <20210707104745.98822-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210706181452.GB11571@locust>
References: <20210706181452.GB11571@locust>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


Yes it works. For example in this RFC patch, generic/075 could be
skipped once 'bigalloc' is detected for ext4.

I could fix all related test cases in this way, if it is acceptable to
the community.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 common/rc         | 20 ++++++++++++++++++++
 tests/generic/075 |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index f58a542..92245e0 100644
--- a/common/rc
+++ b/common/rc
@@ -4041,6 +4041,23 @@ _sysfs_dev()
 	min=$(echo "ibase=16; $min" | bc)
 	echo /sys/dev/block/$maj:$min
 }
+		
+_ext4_get_file_block_size()
+{
+	local path="$1"
+	path="$(readlink -m "$path")"
+	local dev=`$DF_PROG $dir | tail -1 | $AWK_PROG '{print $1}'`
+	
+	# The alloc unit size equals block size for ext4 without 'bigalloc'.
+	if ! (tune2fs -l $dev | grep -q 'Cluster size'); then
+		_get_block_size "$path"
+		return
+	fi
+
+	# Otherwise, call tune2fs acquiring cluster size.
+	tune2fs -l $dev | sed -n -e 's/^.*Cluster size:\s*\([0-9]*\).*$/\1/p'
+
+}
 
 # Get the minimum block size of a file.  Usually this is the
 # minimum fs block size, but some filesystems (ocfs2) do block
@@ -4059,6 +4076,9 @@ _get_file_block_size()
 	"xfs")
 		_xfs_get_file_block_size $1
 		;;
+	"ext4")
+		_ext4_get_file_block_size $1
+		;;
 	*)
 		_get_block_size $1
 		;;
diff --git a/tests/generic/075 b/tests/generic/075
index 7467bb7..d269a7c 100755
--- a/tests/generic/075
+++ b/tests/generic/075
@@ -109,6 +109,9 @@ _process_args()
 _supported_fs generic
 _require_test
 
+blksz=$(_get_block_size $TEST_DIR)
+_require_congruent_file_oplen $TEST_DIR $blksz
+
 size10=`expr 10 \* 1024 \* 1024`	# 10 megabytes
 filelen=$size10
 numops1=1000
-- 
1.8.3.1

