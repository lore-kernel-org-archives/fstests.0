Return-Path: <SRS0=LCFT=BQ=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D71BC433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA9120823
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Aug 2020 02:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgHFCVl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:21:41 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34557 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbgHFCVl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 5 Aug 2020 22:21:41 -0400
X-IronPort-AV: E=Sophos;i="5.75,440,1589212800"; 
   d="scan'208";a="97677617"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 06 Aug 2020 10:21:20 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B32664CE34E0;
        Thu,  6 Aug 2020 10:21:15 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 6 Aug 2020 10:21:16 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 6 Aug 2020 10:21:16 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        <guaneryu@gmail.com>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v9 3/8] generic/223: Don't clear MKFS_OPTION before calling _scratch_mkfs_geom()
Date:   Thu, 6 Aug 2020 10:13:37 +0800
Message-ID: <20200806021342.10596-4-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
References: <20200806021342.10596-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B32664CE34E0.AB5BE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Current _scratch_mkfs_geom() adds geometry parameters to the end of the
MKFS_OPTIONS blindly.  ext4 can accept the last one if geometry parameters
and original MKFS_OPTION have the same mkfs options but xfs cannot accept
them and reports "xxx option is respecified" error.  Make _scratch_mkfs_geom()
override the same mkfs options in original MKFS_OPTION by geometry parameters.

With this change, generic/223 doesn't need to clear original MKFS_OPTION
before calling _scratch_mkfs_geom() and can use other mkfs options in original
MKFS_OPTION.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/rc         | 14 +++++++++++++-
 tests/generic/223 |  1 -
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 359d03ad..ad4d080d 100644
--- a/common/rc
+++ b/common/rc
@@ -1051,7 +1051,19 @@ _scratch_mkfs_geom()
 
     case $FSTYP in
     xfs)
-	MKFS_OPTIONS+=" -b size=$blocksize, -d su=$sunit_bytes,sw=$swidth_mult"
+	if echo "$MKFS_OPTIONS" | egrep -q "b?size="; then
+		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r "s/(b?size=)[0-9]+/\1$blocksize/")
+	else
+		MKFS_OPTIONS+=" -b size=$blocksize"
+	fi
+
+	if echo "$MKFS_OPTIONS" | egrep -q "(su|sunit|sw|swidth)="; then
+		MKFS_OPTIONS=$(echo "$MKFS_OPTIONS" | sed -r \
+			-e "s/(su|sunit)=[0-9kmg]+/su=$sunit_bytes/" \
+			-e "s/(sw|swidth)=[0-9kmg]+/sw=$swidth_mult/")
+	else
+		MKFS_OPTIONS+=" -d su=$sunit_bytes,sw=$swidth_mult"
+	fi
 	;;
     ext4|ext4dev)
 	MKFS_OPTIONS+=" -b $blocksize -E stride=$sunit_blocks,stripe_width=$swidth_blocks"
diff --git a/tests/generic/223 b/tests/generic/223
index 6cfd00dd..ba7c9a44 100755
--- a/tests/generic/223
+++ b/tests/generic/223
@@ -41,7 +41,6 @@ for SUNIT_K in 8 16 32 64 128; do
 	let SUNIT_BLOCKS=$SUNIT_BYTES/$BLOCKSIZE
 
 	echo "=== mkfs with su $SUNIT_BLOCKS blocks x 4 ==="
-	export MKFS_OPTIONS=""
 	_scratch_mkfs_geom $SUNIT_BYTES 4 $BLOCKSIZE >> $seqres.full 2>&1
 	_scratch_mount
 
-- 
2.21.0



