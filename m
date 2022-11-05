Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F308C433FE
	for <linux-fstests@archiver.kernel.org>; Sat,  5 Nov 2022 18:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiKES3g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 5 Nov 2022 14:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiKES3f (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 Nov 2022 14:29:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E07E09A
        for <fstests@vger.kernel.org>; Sat,  5 Nov 2022 11:29:34 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A5ITK07010479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 5 Nov 2022 14:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667672961; bh=2aQXzQ3fut4I75nBOpvbJknOI5dazmvaejXvNV5oKGE=;
        h=From:To:Cc:Subject:Date;
        b=TRp4LiqXsBLkvnHH+NldFrK2HI2JUKHMjt+fyqlejSwYYBx80Fp/UB8wNLDvci97K
         7PUEmaf8SvF3JYwPGGY5k2z1DWzzd+4HN5uclYqgC2iiVRqhvFvkhfxxFXDaU260Mf
         cYduqE9mTo/oDCoABpZHagmYdd8vK1lxtrG53hEQULDTQtAG6Qwg9CvQ+TZ4Te5AX0
         p4tLQlpIYkPfOwB2UtkxBZTDV+Sr7maLoUY8ZCw1iOh8LSClsIBTRbbypCdBffvDdN
         JYEJF1R0gla6MlUrOBDnlwdGyz6ccpnRj6wkWxEb0Xwl79ZSmAY7mmdqVRLHcsWNTe
         R8W5MPqKKH4QQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5208115C45B9; Sat,  5 Nov 2022 14:29:20 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     Eric Whitney <enwlinux@gmail.com>, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] generic: add missing $FSX_AVOID to fsx invocations
Date:   Sat,  5 Nov 2022 14:29:18 -0400
Message-Id: <20221105182918.24099-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Whitney <enwlinux@gmail.com>

generic/455 fails when run on an ext4 bigalloc file system.  Its
fsx invocations can make insert range and collapse range calls whose
arguments are not cluster aligned, and ext4 will fail those calls for
bigalloc.  They can be suppressed by adding the FSX_AVOID environment
variable to the fsx invocation and setting its value appropriately in
the test environment, as is done for other fsx-based tests.  This
avoids the need to exclude the test to avoid failures and makes it
possible to take advantage of the remainder of its coverage.

[ Also fix generic/457, as requested by Dave Chinner -- TYT]

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---

This is a respin of "generic/455: add $FSX_AVOID" which Eric posted here:
https://lore.kernel.org/r/20221021211950.510006-1-enwlinux@gmail.com
it adds a similar fix for generic/457, as requested by Dave and Zorro.

 tests/generic/455 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/455 b/tests/generic/455
index 649b54108..c13d872c6 100755
--- a/tests/generic/455
+++ b/tests/generic/455
@@ -77,7 +77,7 @@ FSX_OPTS="-N $NUM_OPS -d -P $SANITY_DIR -i $LOGWRITES_DMDEV"
 seeds=(0 0 0 0)
 # Run fsx for a while
 for j in `seq 0 $((NUM_FILES-1))`; do
-	run_check $here/ltp/fsx $FSX_OPTS -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
+	run_check $here/ltp/fsx $FSX_OPTS $FSX_AVOID -S ${seeds[$j]} -j $j $SCRATCH_MNT/testfile$j &
 done
 wait
 
-- 
2.31.0

