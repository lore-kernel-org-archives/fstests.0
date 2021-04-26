Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574D7C433B4
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39055613AB
	for <linux-fstests@archiver.kernel.org>; Mon, 26 Apr 2021 20:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhDZUvB (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 26 Apr 2021 16:51:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233483AbhDZUu7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 26 Apr 2021 16:50:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 18F32AEBB
        for <fstests@vger.kernel.org>; Mon, 26 Apr 2021 20:50:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D86C11E1497; Mon, 26 Apr 2021 22:50:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     fstests@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] common: Fix recovery tests for tmpfs
Date:   Mon, 26 Apr 2021 22:50:11 +0200
Message-Id: <20210426205012.13241-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210426205012.13241-1-jack@suse.cz>
References: <20210426205012.13241-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Tmpfs doesn't support metadata journalling. Recognize it as such.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 11ff7635700b..2dd1b8ad9e35 100644
--- a/common/rc
+++ b/common/rc
@@ -3441,7 +3441,7 @@ _has_metadata_journaling()
 	fi
 
 	case "$FSTYP" in
-	ext2|vfat|msdos|udf|exfat)
+	ext2|vfat|msdos|udf|exfat|tmpfs)
 		echo "$FSTYP does not support metadata journaling"
 		return 1
 		;;
-- 
2.26.2

