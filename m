Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E856C4338F
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Jul 2021 04:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1491C60E94
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Jul 2021 04:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhG2EsD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Jul 2021 00:48:03 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59868 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233679AbhG2EsD (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Jul 2021 00:48:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UhJ8X.r_1627534078;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UhJ8X.r_1627534078)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 29 Jul 2021 12:47:59 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     guan@eryu.me
Cc:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: only force nfs4.2 non-default SEEK_HOLE behaviour
Date:   Thu, 29 Jul 2021 12:47:58 +0800
Message-Id: <20210729044758.63219-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Only NFSv4.2 supports non-defautl SEEK_HOLE behaviour. Thus default
SEEK_HOLE behaviour shall be allowed for NFSv4.0/4.1, or it will fail
generic/285, generic/448, generic/490 on NFSv4.0/4.1, complaining they
should support non-default SEEK_HOLE behaviour.

The *.full log is like:
	File system supports the default behavior.
	Default behavior is not allowed. Aborting.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 25a838a3..9be6f89d 100644
--- a/common/rc
+++ b/common/rc
@@ -2495,10 +2495,10 @@ _fstyp_has_non_default_seek_data_hole()
 		return 0
 		;;
 	nfs*)
-		# NFSv2 and NFSv3 only support default behavior of SEEK_HOLE,
-		# while NFSv4 supports non-default behavior
-		local nfsvers=`_df_device $TEST_DEV | $AWK_PROG '{ print $2 }'`
-		[ "$nfsvers" = "nfs4" ]
+		# NFSv2, NFSv3, and NFSv4.0/4.1 only support default behavior of SEEK_HOLE,
+		# while NFSv4.2 supports non-default behavior
+		local nfsvers=`_mount() | grep $TEST_DEV | sed -n 's/^.*vers=\([0-9.]*\).*$/\1/p'`
+		[ "$nfsvers" = "4.2" ]
 		return $?
 		;;
 	overlay)
-- 
2.27.0

