Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C473C77B73
	for <linux-fstests@archiver.kernel.org>; Wed, 24 May 2023 13:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjEXNmp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 24 May 2023 09:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjEXNmp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 May 2023 09:42:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C36393
        for <fstests@vger.kernel.org>; Wed, 24 May 2023 06:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A1662F40
        for <fstests@vger.kernel.org>; Wed, 24 May 2023 13:42:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BEAC4339B
        for <fstests@vger.kernel.org>; Wed, 24 May 2023 13:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684935737;
        bh=EW60A1j8P/nIxIiXrTbblh9kFKrPGQJCrBM/nvvKyqc=;
        h=From:To:Subject:Date:From;
        b=vRxBaoC42UUm4m69NlO6ELExYOGPwKdlCQa7P/9F9O3Rv2cYS0GmgP4Lf9p4pG581
         TSKqN2Ccd3F9rmPdhCLrMQI4NBktsYR4UhNa3fZqFzhtrLiIE3ZBNCRSNDm1zQ3nHT
         RBSTWykbCRsCSNVL9JaJcsDR5VeGa3BuCGJ3d8ZEpAnSSfqx/g56B2MTypfqoNl8Zq
         MbSJohn49qQEdGhJ+AAo4az1djenKvvmeGsJ7WLyfbEgwZ1CXzsqz3/Ppbc6ZCsEaQ
         Q2RUgS6ntHVDDUxusdMS9p/hhgq86vh9vHs0i7EuoiNuqpWx2JVxqiRSKhZjdq0/AQ
         e15XWb6B07KuA==
From:   cem@kernel.org
To:     fstests@vger.kernel.org
Subject: [PATCH] xfstests: Enable _test_mkfs to force a mkfs on a xfs filesystem
Date:   Wed, 24 May 2023 15:42:07 +0200
Message-Id: <20230524134207.38224-1-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Carlos Maiolino <cmaiolino@redhat.com>

Calling _test_mkfs on an already initialized xfs FS will fail as the
initialization is not enforced by '-f' argument, unless it's included in
MKFS_OPTIONS.
So, adding 'RECREATE_TEST_DEV=true' to the config file end up being useless
for xfs filesystems.

So, adding the a specific xfs optiong in _test_mkfs using -f argument
makes RECREATE_TEST_DEV actually useful.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 common/rc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/rc b/common/rc
index 37074371..dd5d7bc1 100644
--- a/common/rc
+++ b/common/rc
@@ -605,6 +605,9 @@ _test_mkfs()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
+    xfs)
+	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
-- 
2.30.2

