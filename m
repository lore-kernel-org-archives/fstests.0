Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2957C432BE
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 21:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5813610D1
	for <linux-fstests@archiver.kernel.org>; Wed, 25 Aug 2021 21:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhHYVQP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhHYVQO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Aug 2021 17:16:14 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F79AC061757
        for <fstests@vger.kernel.org>; Wed, 25 Aug 2021 14:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kIsUnw34ElnAY3BRejKg+pC/Ga9wKQEexnyca5pZQrc=; b=HWzbBcO5MPFjw6pmTq0wpkelGh
        7XxMizQYgOnysTVwt+Xn2Ji8FNluYNevo4m18jjoFEZp4cDRlaAJeio9knq3VqYSXOIFfh3Hk7M0h
        gzWRamV+/mjdb5XoLqM31hzfblm1ifpUhsWUv05PAqTTW7L40SuNPNbeFulJeHo1ygyk9bndB4bKF
        fW8j2XGyFYC36OLxvA/PLmhSYA3tlePehtKX9F7gZUOH3q62syOU+L6WBK/KYsED0VbBdzpWhjpxR
        fGSEwis/RARs6SrnrraoZWhE2IDeys05A/spfiJzzZm0Y8fMlyQb56cBm42QFJ1rjprtj9pvSYi0R
        D5iLYR6g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJ0Ez-008Vux-HB; Wed, 25 Aug 2021 21:15:27 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Pavel Reichl <preichl@redhat.com>
Subject: [PATCH] common/rc: fix ignoring of errors on
Date:   Wed, 25 Aug 2021 14:15:20 -0700
Message-Id: <20210825211520.2029257-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Commit 0c95c8acb ("common: hide permision warning from mkswap for
exfat") and commit 08e93fa7c ("generic/554: hide permision warning on
exfat") removed a warning by grepping an error out. It however broke
use on older versions of bash such as 4.4.23:

./common/rc: line 2554: syntax error near unexpected token `>'
./common/rc: line 2554: `       MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full'

Fix both instances by using a $(foo) to run the executable.

Cc: Pavel Reichl <preichl@redhat.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index e0b6d508..46b6b220 100644
--- a/common/rc
+++ b/common/rc
@@ -2550,14 +2550,14 @@ _format_swapfile() {
 	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
 	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
 	# Ignore permission complaints on filesystems that don't support perms
-	$MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2) >> $seqres.full
+	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
 }
 
 _swapon_file() {
 	local fname="$1"
 
 	# Ignore permission complaints on filesystems that don't support perms
-	swapon "$fname" 2> >(grep -v "insecure permissions" >&2)
+	$(swapon "$fname" 2> >(grep -v "insecure permissions" >&2))
 }
 
 # Check that the filesystem supports swapfiles
-- 
2.30.2

