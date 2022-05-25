Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3141DC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 25 May 2022 07:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiEYHer (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 25 May 2022 03:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244236AbiEYHef (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 May 2022 03:34:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1454BDE
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 00:34:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 287C76177A
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 07:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1B5C34117
        for <fstests@vger.kernel.org>; Wed, 25 May 2022 07:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653464072;
        bh=NuUBdA0ZR5iH8JUy9SZF9+B4NE33FdX4kHuU+R0iH5A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QMbkYCbpruvxaa/hzkpBl3NIj/gamktWZ8xexKFQT++4CfmV5MgX/Qe7funAT6BML
         +hsjaSRIbWWd3/PKK/fuuWnPLa+4t/FZmMBYGQ47iYnnqKU1hgwYLORzbaRm8DD9Tb
         EfJN13P+y0Djhe95PCf3Ne2Iz3W/bFCl7JfFkDhECLmSgUwtSlTvT71TUvNFGsyeRv
         lgMxGJV/bllEquvns54w82rBWmuSAEa4RjUPyHvLJ3P8dRI9foYgF0H9Kt1LQa+fBy
         mCNjgNIWwXhssTLYlWP6nd8gJDz/C8ZVIXNJdZDTgBZKuzeh/wpTDVZqmQ9ePRM7pX
         5Cle3I7jtuDsg==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/2] tests: remove redundant common/$FSTYP importing
Date:   Wed, 25 May 2022 15:34:27 +0800
Message-Id: <20220525073427.3355242-3-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220525073427.3355242-1-zlang@kernel.org>
References: <20220525073427.3355242-1-zlang@kernel.org>
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
index 158eaf79..8fc828df 100755
--- a/tests/btrfs/258
+++ b/tests/btrfs/258
@@ -11,7 +11,6 @@
 _begin_fstest auto defrag quick
 
 . ./common/btrfs
-. ./common/filter
 
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

