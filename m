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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA2AC433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BEB20739
	for <linux-fstests@archiver.kernel.org>; Wed, 17 Jun 2020 09:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VMZt+6YG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFQJrc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:47:32 -0400
Received: from mail-m974.mail.163.com ([123.126.97.4]:58000 "EHLO
        mail-m974.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgFQJrc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 Jun 2020 05:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=PhC2y
        CTPliNdEDvPBPNI++GKrwlmoKuRAO4O9qTwqq8=; b=VMZt+6YGCKsx/GFF6L9Gd
        o0sYNC3wDgMpald3m/XohZ0soULWwetUvJGTy6dbLVi9MH964XeIL67Nt8aaefuw
        tQPrdUBvKM4wk2oVkbHjAzBYibI8sWkRFOo0BK//ntkNb64nygi737nHEfIl1m5y
        DeSJUWnICJJcB60/z27BxU=
Received: from localhost.localdomain (unknown [122.96.44.138])
        by smtp4 (Coremail) with SMTP id HNxpCgDH8VsW4+leg8edAw--.16498S5;
        Wed, 17 Jun 2020 17:32:09 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com,
        ross.zwisler@linux.intel.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 3/6] common/rc: Remove unused _require_scratch_dax()
Date:   Wed, 17 Jun 2020 17:32:01 +0800
Message-Id: <20200617093204.20838-4-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200617093204.20838-1-ice_yangxiao@163.com>
References: <20200617093204.20838-1-ice_yangxiao@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgDH8VsW4+leg8edAw--.16498S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFyDZrW3GFW7AFW7Aw43Jrb_yoW3KFX_Za
        4rZF1xWF4UtFn3XF4fJrW5Zryku397ZFy7Wr4fuFW5twnYya90vFn2yr40vrsxXF9rtrsI
        qws5ur4rtr18tjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe2Q6JUUUUU==
X-Originating-IP: [122.96.44.138]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiqBlGXlc7QAtv7gAAsP
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Xiao Yang <yangx.jy@cn.fujitsu.com>

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/common/rc b/common/rc
index ec7c19e4..dba52002 100644
--- a/common/rc
+++ b/common/rc
@@ -3175,19 +3175,6 @@ _require_scratch_shutdown()
 }
 
 # Does dax mount option work on this dev/fs?
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
 _require_scratch_dax_mountopt()
 {
 	local mountopt=$1
-- 
2.21.0

