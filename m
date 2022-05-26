Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15142C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 26 May 2022 01:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiEZBXZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 May 2022 21:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241151AbiEZBXY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 May 2022 21:23:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C26192D14
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 18:23:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5931B81E9F
        for <fstests@vger.kernel.org>; Thu, 26 May 2022 01:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE563C385B8;
        Thu, 26 May 2022 01:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653528200;
        bh=QLPxVyLyF04cVK0WhFL2R8Ts62tr8xZiMBZPdlPT8oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VFPa8ohyenIk/aE6gDkTJr20Jk5mVPN0N3DQAZ/6EUbIi7WHtKMtq5bUZ9g+QhljS
         ELpIXan/P4qFGcMBYm7UGzcSiCeqPiMoCK/8KJHo6FocpuUgzKgd1MmFh/wrcRaE7x
         Mh4vVBRFm9aQobfmI/7G2FwKprd9yn+B7mLfo6Xnq0jvSQyxjEcaRtKQc1xbvhIBMY
         v4RH5k5ay0bDP8T+O39Xl2LKh0Tq32kYMPMokkE3tNGMni6oSlrdygIVVy3uYoRnR6
         JzsC2sFLaPPsWb53UbKowphn1w5sTqXT9oKdfsyXVgQkrCwymmN14ps1IfvRBuvtGL
         wMZtzrrh/6agA==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com
Subject: [PATCH v2 2/2] tests: remove redundant common/$FSTYP importing
Date:   Thu, 26 May 2022 09:23:17 +0800
Message-Id: <20220526012317.3624914-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220525073427.3355242-3-zlang@kernel.org>
References: <20220525073427.3355242-3-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

As fstests intensively source specific common/$FSTYP files in
common/rc, at the beginning of ./check running. Each single case
doesn't need to import that again.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

I removed "./common/filter" in btrfs/258 uncarefully, fix that in this V2.

Thanks,
Zorro

 tests/btrfs/177 | 1 -
 tests/btrfs/258 | 1 -
 tests/btrfs/259 | 1 -
 tests/xfs/422   | 1 -
 tests/xfs/423   | 1 -
 tests/xfs/517   | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tests/btrfs/177 b/tests/btrfs/177
index 2fd11e89..7b004b83 100755
--- a/tests/btrfs/177
+++ b/tests/btrfs/177
@@ -10,7 +10,6 @@
 _begin_fstest auto quick swap balance
 
 . ./common/filter
-. ./common/btrfs
 
 # Modify as appropriate.
 _supported_fs btrfs
diff --git a/tests/btrfs/258 b/tests/btrfs/258
index 158eaf79..da073333 100755
--- a/tests/btrfs/258
+++ b/tests/btrfs/258
@@ -10,7 +10,6 @@
 . ./common/preamble
 _begin_fstest auto defrag quick
 
-. ./common/btrfs
 . ./common/filter
 
 # real QA test starts here
diff --git a/tests/btrfs/259 b/tests/btrfs/259
index e7bd8ddd..92d0b9a6 100755
--- a/tests/btrfs/259
+++ b/tests/btrfs/259
@@ -12,7 +12,6 @@ _begin_fstest auto quick defrag
 
 # Import common functions.
 . ./common/filter
-. ./common/btrfs
 
 # real QA test starts here
 
diff --git a/tests/xfs/422 b/tests/xfs/422
index 77db492e..175253aa 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -17,7 +17,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/fuzzy
 . ./common/inject
-. ./common/xfs
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/423 b/tests/xfs/423
index be56f311..c9dfaece 100755
--- a/tests/xfs/423
+++ b/tests/xfs/423
@@ -18,7 +18,6 @@ _register_cleanup "_cleanup" BUS
 . ./common/filter
 . ./common/fuzzy
 . ./common/inject
-. ./common/xfs
 
 # real QA test starts here
 _supported_fs xfs
diff --git a/tests/xfs/517 b/tests/xfs/517
index 512f795f..88c4f43b 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -23,7 +23,6 @@ _cleanup()
 . ./common/filter
 . ./common/fuzzy
 . ./common/inject
-. ./common/xfs
 
 # real QA test starts here
 _supported_fs xfs
-- 
2.31.1

