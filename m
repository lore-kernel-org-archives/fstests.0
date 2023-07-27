Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF54EC001DC
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Jul 2023 19:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjG0TFX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Jul 2023 15:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjG0TFW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jul 2023 15:05:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B9210B
        for <fstests@vger.kernel.org>; Thu, 27 Jul 2023 12:05:21 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-115-64.bstnma.fios.verizon.net [173.48.115.64])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36RJ5FmO025614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jul 2023 15:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690484716; bh=mruGto2vDHJwO6Lbjyr/hifi8K27c2Ql7WDzjCNaj2c=;
        h=From:Subject:Date:Message-Id:MIME-Version;
        b=jxK/idPt0Os76SHN/ynkTu2No81VBbpvMIr/72XpWyBr4+E7d27Zw5foLi3npC1A6
         bxP+yPTpuChiBoD9Vp///ulsoY7ZIzL0UNgrp9GT+vCD6+aHbdWQxBz9PrXQ75qQD7
         fdYYjVy12IJcDKtbLDXvvuHuCfJJYdJGmrakiKs325ADpozABxFOhDh3LkCzhmotrC
         vp1HbAT13CCA60CQa0S+70EuluWfZAe/QxIze3xPI4UmPL3hKlstMD6acGjzXyrxbZ
         P3ezuMni/fPgvXZXfR1Afz+wS5aIwB8EA0Ra0ea0/qV3RNw39H1bq4tulG9VFHj+Cq
         Ikot5zYKrZeTA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2D94515C04EF; Thu, 27 Jul 2023 15:05:15 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] fstests: install soak_duration.awk
Date:   Thu, 27 Jul 2023 15:05:12 -0400
Message-Id: <20230727190512.357064-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Commit 3e85dd4fe423 ("misc: add duration for long soak tests") added a
helper executable, soak_duration.awk, is which used by the check
script if SOAK_DURATION is set.  This script translates a
"human-firendly" time duration specifier, such as 4m or 2d into an
integer number of seconds.  We need to make sure that this script is
installed or the checks script will bomb out of SOAK_DURATION is set
(and the fstests installation doesn't include a full set of fstests
source, but just those files installed by "make install").

Fixes: 3e85dd4fe423 ("misc: add duration for long soak tests")
Cc: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 src/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index 24cd47479..aff871d04 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -36,7 +36,8 @@ LINUX_TARGETS = xfsctl bstat t_mtab getdevicesize preallo_rw_pattern_reader \
 	uuid_ioctl
 
 EXTRA_EXECS = dmerror fill2attr fill2fs fill2fs_check scaleread.sh \
-	      btrfs_crc32c_forged_name.py popdir.pl popattr.py
+	      btrfs_crc32c_forged_name.py popdir.pl popattr.py \
+	      soak_duration.awk
 
 SUBDIRS = log-writes perf
 
-- 
2.31.0

