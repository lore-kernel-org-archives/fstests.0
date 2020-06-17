Return-Path: <SRS0=zehT=76=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C27C433E1
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5CB20739
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AnZsnAan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgFQJrc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:47:32 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:58004 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgFQJrc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2020 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=7GZzB
        rzoc4ACSrBMSPUDCRCnDzK9nrcSF3KN+xiCSKo=; b=AnZsnAanigUkpr69t+MIy
        FYOpsdI3E5/ujGUaw9CufHoIk6UEFs37c4gDw5wZP5g0ORhac8X13w6tcppsLR4R
        wy5Xk4t2RKpeH4+OMAlPXYaA5x8jkn6Y8DhWyOFZivzIQad3Rmodjbzk7ZMNwfwK
        1OZ8A7x3bLKmYkqaMhp8vs=
Received: from localhost.localdomain (unknown [122.96.44.138])
        by smtp4 (Coremail) with SMTP id HNxpCgDH8VsW4+leg8edAw--.16498S6;
        Wed, 17 Jun 2020 17:32:10 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 4/6] generic/223: Don't clear all mkfs options for _scratch_mkfs_geom() roughly
Date:   Wed, 17 Jun 2020 17:32:02 +0800
Message-Id: <20200617093204.20838-5-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617093204.20838-1-ice_yangxiao@163.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH8VsW4+leg8edAw--.16498S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw4Uur4DtrWDGF45ur17Jrb_yoW8Aw45pF
        s8KFyrCr40qryfZrWkJrsxZ3s3K3Z3Gr1UGFyxXrWIqw4xX3WfJwnFgF109FyftrZ3Xr4Y
        939YyrykWa18ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-hL8UUUUU=
X-Originating-IP: [122.96.44.138]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/xtbB0htGXlUMW8jYFwAAsU
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

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
index dba52002..bde26010 100644
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

