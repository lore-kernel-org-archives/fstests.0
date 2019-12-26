Return-Path: <SRS0=zKMi=2Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0296AC2D0DB
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Dec 2019 06:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D65AE2071E
	for <linux-fstests@archiver.kernel.org>; Thu, 26 Dec 2019 06:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfLZGrz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 26 Dec 2019 01:47:55 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:53697 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbfLZGrz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 26 Dec 2019 01:47:55 -0500
X-IronPort-AV: E=Sophos;i="5.69,357,1571673600"; 
   d="scan'208";a="80802199"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 26 Dec 2019 14:47:52 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id D9C0C4CE1BE8
        for <fstests@vger.kernel.org>; Thu, 26 Dec 2019 14:39:01 +0800 (CST)
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 26 Dec 2019 14:47:49 +0800
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 26 Dec 2019 14:47:50 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH] generic/590: skip test if kernel doesn't support realtime
Date:   Thu, 26 Dec 2019 14:48:36 +0800
Message-ID: <1577342916-14289-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-yoursite-MailScanner-ID: D9C0C4CE1BE8.AFF02
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

IMHO, if kernel doesn't supprt realtime, we should skip test.
So add it. Also, when we use _scratch_mkfs on xfs, we will get
the following error:
mkfs failed with extra mkfs options added to "-bsize=4096" by test 590 **

This failure occurs because we have used "export XFS_MKFS_OPTIONS=
${XFS_MKFS_OPTIONS:=-bsize=4096}" in common/config, we don't need to
set it again in extra_options, so remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/generic/590 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/590 b/tests/generic/590
index 2670fe99..d2673748 100755
--- a/tests/generic/590
+++ b/tests/generic/590
@@ -55,7 +55,6 @@ if [[ $FSTYP = xfs ]]; then
 		USE_EXTERNAL=yes
 		SCRATCH_RTDEV="$loop"
 	fi
-	extra_options="$extra_options -bsize=$bs"
 	extra_options="$extra_options -r extsize=$((bs * rextsize))"
 	extra_options="$extra_options -d agsize=$(((maxextlen + 1) * bs / 2)),rtinherit=1"
 	# disable reflink as reflink not supported with realtime devices
@@ -64,7 +63,8 @@ if [[ $FSTYP = xfs ]]; then
 	fi
 fi
 _scratch_mkfs $extra_options >>$seqres.full 2>&1
-_scratch_mount
+try_scratch_mount >>$seqres.full 2>&1 || \
+	_notrun "mount failed or kernel doesn't support realtime"
 _require_fs_space "$SCRATCH_MNT" $((filesz / 1024))
 
 # Allocate maxextlen + 1 blocks. As long as the allocator does something sane,
-- 
2.18.0



