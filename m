Return-Path: <SRS0=6DS6=EL=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6DC4741F
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Nov 2020 15:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F97C22203
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Nov 2020 15:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604588979;
	bh=NInS1xaqKtMaJb3hU4Rio5IcTGnMowPvHCGsMv1nOMc=;
	h=From:To:Subject:Date:List-ID:From;
	b=OyetNFfmJ+TwUg8IhSYjBmm7v/WKjfrfakTGeRPAdKHmFatiqu/zt34FLYcNVaazt
	 qv1sLngGAWuXNiv2nvrHWcnAPOoafmpB4i5BWvs3fKohdEPnNJPrGB0KcSwmmXi6Y4
	 vP+J0fG2b9oEYXNFnJ1n0brOWNtodSJNlJ9BOsRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731013AbgKEPJi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 Nov 2020 10:09:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:56610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgKEPJi (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 5 Nov 2020 10:09:38 -0500
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63FC20715
        for <fstests@vger.kernel.org>; Thu,  5 Nov 2020 15:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604588978;
        bh=NInS1xaqKtMaJb3hU4Rio5IcTGnMowPvHCGsMv1nOMc=;
        h=From:To:Subject:Date:From;
        b=HvSOnU2I07GEBHmDpjvBzwljPYrxcXMhIDUBQckEam857BiauYiCug4ylTIDhw/uD
         om4Uggl7/DQfclW69Z430s0Ab0Xk/cNwndoTeoyKqw/Jc9IGpRkFRUImg/SqDTa1WS
         jbjcKhgDGVuODiIA7L5N5jqeT9vKuld2j7KipeZc=
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: allow setting $SCRATCH_FS_MOUNT_OPTS
Date:   Thu,  5 Nov 2020 10:09:36 -0500
Message-Id: <20201105150936.410407-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We already have a $TEST_FS_MOUNT_OPTS which gets applied only to the
test mount, but we don't have a corresponding variable for the scratch
mount. Add one.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 65ebfe201139..23874d1e5b8e 100644
--- a/common/rc
+++ b/common/rc
@@ -308,7 +308,7 @@ _scratch_mount_options()
 {
 	_scratch_options mount
 
-	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS \
+	echo `_common_dev_mount_options $*` $SCRATCH_OPTIONS $SCRATCH_FS_MOUNT_OPTS \
 					$SCRATCH_DEV $SCRATCH_MNT
 }
 
-- 
2.28.0

