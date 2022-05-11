Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508E3C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 11 May 2022 16:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344811AbiEKQd4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 May 2022 12:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344804AbiEKQdt (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 May 2022 12:33:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1412380CF
        for <fstests@vger.kernel.org>; Wed, 11 May 2022 09:33:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 64FD31F4321E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652286827;
        bh=dEbPtTq5tRdPhCh62UVOU7rsjNhPTZ6ImnqNgKl/N1M=;
        h=From:To:Cc:Subject:Date:From;
        b=G+sHHdbahrAbXi4HuhY4/26GIOO2MdIDvqkwgvh5ecPH4T9lUfb8sPUnvxOzPKffN
         +vnWJ3pNDlrGG1XfysCnuqMJTouvWH9pdhXs0J1psswEC9f0JFyAK8zEG/P3JuNVaK
         do2nJ3DkjFI6cM3gey1gfcBKGjXXPonoa/F6zwc3z2v3t02iicU1524Jn+wEh5inYB
         7mFl6RiazOEJ7s/EsUldiYoXVl1KCV62E6WV0M1BjPTQj+wlxl7ILLivYhtlJ1bgzc
         aICPziPKaDi2/jJ+RoIv31SQjd4QOEtW/WHNZPlMKh1D1yBmeZGQ/RdZkluI/QM8K/
         tdgFGNmaBHegA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     zlang@kernel.org
Cc:     fstests@vger.kernel.org, david@fromorbit.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH v2] casefold: Fix expansion of seqres variable
Date:   Wed, 11 May 2022 12:33:40 -0400
Message-Id: <20220511163340.19969-1-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

seqres is not properly expanded on these error paths, causing a file
called seqres.full to be created instead.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
changes since v1:
  - Add whitespace between variable and std redirection (chinner)
---
 common/casefold | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/casefold b/common/casefold
index 9172d818125a..d9126f4c59e6 100644
--- a/common/casefold
+++ b/common/casefold
@@ -25,7 +25,7 @@ _require_scratch_casefold()
 		_notrun "$FSTYP does not support casefold feature"
 	fi
 
-	if ! _scratch_mkfs_casefold &>>seqres.full; then
+	if ! _scratch_mkfs_casefold &>> $seqres.full ; then
 		_notrun "$FSTYP userspace tools do not support casefold"
 	fi
 
@@ -33,7 +33,7 @@ _require_scratch_casefold()
 	# defined by the userspace tools.  This will fail if
 	# the userspace tool used a more recent encoding than the one
 	# supported in kernel space.
-	if ! _try_scratch_mount &>>seqres.full; then
+	if ! _try_scratch_mount &>> $seqres.full ; then
 		_notrun "kernel can't mount filesystem with the encoding set by userspace"
 	fi
 	_scratch_unmount
-- 
2.36.1

