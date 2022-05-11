Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22753C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 00:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiEKAZ2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 20:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiEKAZ1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 20:25:27 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5622609F4
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 17:25:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id DEE4C1F44A16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652228725;
        bh=PVe3SKizVtysv+7YxuAd6fmXiTfBHivoL+8Zrv4nHv8=;
        h=From:To:Cc:Subject:Date:From;
        b=VrbMDfZu4RA/7lrr+NFF7wsYIRCjr1WQWOPRM7075OG38q7pNIUwOCPno1g1WxOc3
         AWD1VDwFonmB8sfOJtWRH5l5XBIaYejT6s0nQioweJnIFDbREUtZap0WUjGaYjvC0r
         OfmDuWdt6IcTPxe0m1OrZZzvvFEXi9vBv3WLohdrwdUvPq0x6hsmGrV3cx1XiooF44
         oAs9ziMrxW9YAcxnCq4YZYXk6lq+xDSLPX9lY1tjcVSn7iGEdYnwF7/haRnbdIeJi6
         lCI9duWC9Ph3RL0eD1Qm1AeGIVxo3qDKI5MR14G2ZqDpk/EIchiKW+UAGVoqosUUQA
         G17FcPxLn7thw==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     zlang@kernel.org
Cc:     fstests@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH] casefold: Fix expansion of seqres variable
Date:   Tue, 10 May 2022 20:25:20 -0400
Message-Id: <20220511002520.352812-1-krisman@collabora.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

seqres is not properly expanded on these error paths, causing a file
called seqres.full to be created instead.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 common/casefold | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/casefold b/common/casefold
index 9172d818125a..7e8f941211db 100644
--- a/common/casefold
+++ b/common/casefold
@@ -25,7 +25,7 @@ _require_scratch_casefold()
 		_notrun "$FSTYP does not support casefold feature"
 	fi
 
-	if ! _scratch_mkfs_casefold &>>seqres.full; then
+	if ! _scratch_mkfs_casefold &>>$seqres.full; then
 		_notrun "$FSTYP userspace tools do not support casefold"
 	fi
 
@@ -33,7 +33,7 @@ _require_scratch_casefold()
 	# defined by the userspace tools.  This will fail if
 	# the userspace tool used a more recent encoding than the one
 	# supported in kernel space.
-	if ! _try_scratch_mount &>>seqres.full; then
+	if ! _try_scratch_mount &>>$seqres.full; then
 		_notrun "kernel can't mount filesystem with the encoding set by userspace"
 	fi
 	_scratch_unmount
-- 
2.35.3

