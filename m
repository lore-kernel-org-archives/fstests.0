Return-Path: <SRS0=QKYl=AL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3195BC433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 14:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4C62073E
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Jun 2020 14:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgF3OID (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:08:03 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:10820 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731037AbgF3OIC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Jun 2020 10:08:02 -0400
X-IronPort-AV: E=Sophos;i="5.75,297,1589212800"; 
   d="scan'208";a="95563333"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jun 2020 22:06:50 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 8F8AE4CE4BD9;
        Tue, 30 Jun 2020 21:56:19 +0800 (CST)
Received: from G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 30 Jun 2020 22:06:49 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 22:06:47 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <darrick.wong@oracle.com>, <ira.weiny@intel.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3 4/6] generic/223: Don't clear all mkfs options for _scratch_mkfs_geom() roughly
Date:   Tue, 30 Jun 2020 21:59:49 +0800
Message-ID: <20200630135951.21202-5-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
References: <20200630135951.21202-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8F8AE4CE4BD9.AFB84
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

ext4 can accept the last one if the same mkfs options are passed but xfs cannot
accept the same mkfs options and reports "xxx option is respecified" error.  I
prefer to override the same mkfs option which is defined in MKFS_OPTION so that
we can have a chance to pass other mkfs options to _scratch_mkfs_geom().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc         | 14 +++++++++++++-
 tests/generic/223 |  1 -
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 929ff6c4..bd21a90c 100644
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



