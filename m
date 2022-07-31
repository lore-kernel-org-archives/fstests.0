Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FACAC00140
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jul 2022 04:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiGaErA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jul 2022 00:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGaEq7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jul 2022 00:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2228F120AD
        for <fstests@vger.kernel.org>; Sat, 30 Jul 2022 21:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78E2561013
        for <fstests@vger.kernel.org>; Sun, 31 Jul 2022 04:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4056FC433D6
        for <fstests@vger.kernel.org>; Sun, 31 Jul 2022 04:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659242813;
        bh=bwy1rC/U+Kkkrrt3k9Octop1UC/CM+G+0w3lxi6fejI=;
        h=From:To:Subject:Date:From;
        b=dYwXuyaj2sg01p5GZmvzZtqJQ9asF9++W4M+Dw1SXNcTx/x9UtRdNxsfXlnu84PXL
         jJZMZMiEgorXDBJKqubtW5403RRMdQ36YC/Zb/cZnCyBlaThhzIU0xl5Pd26XjJ3tD
         uxIAATwHXNH8HPoyW6nvGlgwComR1YAr9hPdLIXevWgO/MxICKITO0ZaqKPXCqof+a
         UcGWbRAOEHrBjW+zYtoRCxPtSVJV9u3c9ToYGVdBfYLfJb5XBqhJP1kgZUV3lIOV6O
         1yL4CsOjsw2UZ7ryVetNa0qyQyVM/CV/kPB9MdJvTBUQNLJ14o5hB51Vczl04sv3eP
         jZW4+xkpgtajg==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] fstests: add more dmerror related test cases into eio group
Date:   Sun, 31 Jul 2022 12:46:50 +0800
Message-Id: <20220731044650.3775-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The g/484, g/628 and g/629 calls _dmerror_init and load error table
for testing, better to count them in eio test group, then we won't
miss them when we want to run all eio related cases.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 tests/generic/484 | 2 +-
 tests/generic/628 | 2 +-
 tests/generic/629 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/generic/484 b/tests/generic/484
index 40e83cbd..4f413352 100755
--- a/tests/generic/484
+++ b/tests/generic/484
@@ -15,7 +15,7 @@
 #    buffer: record blockdev write errors in super_block that it backs
 
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick eio
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/628 b/tests/generic/628
index 7dc6dfcd..380a7f0b 100755
--- a/tests/generic/628
+++ b/tests/generic/628
@@ -11,7 +11,7 @@
 # 5ffce3cc22a0 ("xfs: force the log after remapping a synchronous-writes file")
 
 . ./common/preamble
-_begin_fstest auto quick rw clone
+_begin_fstest auto quick rw clone eio
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/629 b/tests/generic/629
index f501555e..dbd7ada8 100755
--- a/tests/generic/629
+++ b/tests/generic/629
@@ -11,7 +11,7 @@
 # 5ffce3cc22a0 ("xfs: force the log after remapping a synchronous-writes file")
 
 . ./common/preamble
-_begin_fstest auto quick rw copy_range
+_begin_fstest auto quick rw copy_range eio
 
 # Override the default cleanup function.
 _cleanup()
-- 
2.31.1

