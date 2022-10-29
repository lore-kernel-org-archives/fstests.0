Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65635C38A02
	for <linux-fstests@archiver.kernel.org>; Sat, 29 Oct 2022 02:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJ2CFt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 28 Oct 2022 22:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ2CFs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 28 Oct 2022 22:05:48 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDC06D856
        for <fstests@vger.kernel.org>; Fri, 28 Oct 2022 19:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1667009144; i=@fujitsu.com;
        bh=jMRusdQofE7pnsNPpcEkRaTlsyK+Ss6aM+8YAHT+Z6Q=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=J0WHi0erpTbnFsuCyMgtxC8pgZapPupV/VbBuyPBZtMavyeqWQnhSoJRUFROjHcRz
         46RA5LZPnWZdmbqRB4tzCR/EZoCewSHs9uQbwj/G2Kk5+c9F7VNqsIgou6iBvJUhct
         bE2RGCxBE9EXqrY1zwUaREj5P/E86dzVEZN/8ycz4jLfhrNWo0RPuodxy4u93M098N
         EAiLeDO4GbciXGrVfmI5SPYDPP6sViTV6lnCQT20vZpvCF40KBNqD7go4MNy0/kjVP
         5E0qjl1srSZeQk3u4VBIf68ASMu5Vvet3gBxznyTPFYTdGxmh2PXmU26Byw/6Lhc/+
         WPyI149MGfg3Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRWlGSWpSXmKPExsViZ8OxWbe8Kyb
  ZoO8kv8Xplr3sDowenzfJBTBGsWbmJeVXJLBmLNpzmb1gYWjFrtd5DYyPPboYuTiEBM4zSvza
  toUNwjnEJLHt4DooZw+jxO5TK5m7GDk52AQ0JZ51LgCzRQRkJf7PWM0EYjMLqEssn/QLzBYWs
  JS4vmIdI4jNIqAq8aPlJCuIzSvgITHh+Gx2EFtCQEFiysP3zBBxQYmTM5+wQMyRkDj44gUzRI
  2ixKWOb4wQdoXErFltTBC2msTVc5uYJzDyz0LSPgtJ+wJGplWMZsWpRWWpRbqGhnpJRZnpGSW
  5iZk5eolVuol6qaW65anFJbpGeonlxXqpxcV6xZW5yTkpenmpJZsYgaGYUqwWsIPx47I/eocY
  JTmYlER5e81ikoX4kvJTKjMSizPii0pzUosPMcpwcChJ8Kp0AOUEi1LTUyvSMnOAcQGTluDgU
  RLhjagFSvMWFyTmFmemQ6ROMepyTJ39bz+zEEtefl6qlDjvT5AZAiBFGaV5cCNgMXqJUVZKmJ
  eRgYFBiKcgtSg3swRV/hWjOAejkjDv9TagKTyZeSVwm14BHcEEdET6pCiQI0oSEVJSDUxMf1W
  r2g4ovU9jWjE9QdbSZGXGdMtfkbkOfu08Ije4u2wXWMUq7q5e1sJXovj/Z9fNuMQTk/fxfX3J
  k95oKOdZpFH97omOLE8aczRvunJPzad/V9bcylt6ST9Cz21+l++7a50JLjIaFvfmndKKCfxq/
  +Pc8Zk3/pedic17ucL84I2aCXt/r2F8fH1/v9y0nbtOHn0tPH1uc9fxlm1Xr5te13OLUt0xd8
  7yw7fvr1KcuHlT5FLHIJm3m/Q26prrdtZ4PHogaZL/PdkxKNR68pGz3YmSQv22TiYrY5j393Z
  bCwirW+xLvLtTwv/iXPWHV0TNBa40LOjTsr0Qo32b+cSryqdPvWt+hF2af6xpV5sSS3FGoqEW
  c1FxIgDsRW/GTAMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-548.messagelabs.com!1667009143!19850!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.100.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28308 invoked from network); 29 Oct 2022 02:05:43 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-13.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Oct 2022 02:05:43 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id EF148158
        for <fstests@vger.kernel.org>; Sat, 29 Oct 2022 03:05:42 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id E15D3156
        for <fstests@vger.kernel.org>; Sat, 29 Oct 2022 03:05:42 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 29 Oct 2022 03:05:41 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2] Add more related cases to perms group
Date:   Sat, 29 Oct 2022 11:05:53 +0800
Message-ID: <1667012753-2078-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 tests/generic/099 | 2 +-
 tests/generic/105 | 2 +-
 tests/generic/193 | 2 +-
 tests/generic/237 | 2 +-
 tests/generic/314 | 2 +-
 tests/generic/318 | 2 +-
 tests/generic/319 | 2 +-
 tests/generic/355 | 2 +-
 tests/generic/362 | 2 +-
 tests/generic/363 | 2 +-
 tests/generic/364 | 2 +-
 tests/generic/365 | 2 +-
 tests/generic/366 | 2 +-
 tests/generic/367 | 2 +-
 tests/generic/368 | 2 +-
 tests/generic/369 | 2 +-
 tests/generic/370 | 2 +-
 tests/generic/375 | 2 +-
 tests/generic/444 | 2 +-
 tests/generic/673 | 2 +-
 tests/generic/674 | 2 +-
 tests/generic/683 | 2 +-
 tests/generic/684 | 2 +-
 tests/generic/685 | 2 +-
 tests/generic/686 | 2 +-
 tests/generic/687 | 2 +-
 tests/overlay/004 | 2 +-
 tests/overlay/008 | 2 +-
 tests/overlay/015 | 2 +-
 tests/overlay/023 | 2 +-
 30 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/tests/generic/099 b/tests/generic/099
index 5cdac9ab..eab6f472 100755
--- a/tests/generic/099
+++ b/tests/generic/099
@@ -8,7 +8,7 @@
 #
 #!/bin/bash
 . ./common/preamble
-_begin_fstest acl auto quick
+_begin_fstest acl auto quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/105 b/tests/generic/105
index b422ea34..a05219df 100755
--- a/tests/generic/105
+++ b/tests/generic/105
@@ -10,7 +10,7 @@
 #   which pulls out an earlier mod
 #
 . ./common/preamble
-_begin_fstest acl auto quick
+_begin_fstest acl auto quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/193 b/tests/generic/193
index ddaff69b..e2710b07 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -7,7 +7,7 @@
 # Test permission checks in ->setattr
 #
 . ./common/preamble
-_begin_fstest metadata auto quick
+_begin_fstest metadata auto quick perms
 
 _register_cleanup "_cleanup_files"
 tag="added by qa $seq"
diff --git a/tests/generic/237 b/tests/generic/237
index f17e32e4..a12a4259 100755
--- a/tests/generic/237
+++ b/tests/generic/237
@@ -8,7 +8,7 @@
 # See also http://marc.info/?l=linux-btrfs&m=127434445620298&w=2
 #
 . ./common/preamble
-_begin_fstest auto quick acl
+_begin_fstest auto quick acl perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/314 b/tests/generic/314
index 68a2f716..9449d30f 100755
--- a/tests/generic/314
+++ b/tests/generic/314
@@ -7,7 +7,7 @@
 # Test SGID inheritance on subdirectories
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/318 b/tests/generic/318
index ed50818a..71ee7666 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -13,7 +13,7 @@
 # the ACL was flushed and brought back from disk.
 #
 . ./common/preamble
-_begin_fstest acl attr auto quick
+_begin_fstest acl attr auto quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/319 b/tests/generic/319
index 082d93bc..0efb46be 100755
--- a/tests/generic/319
+++ b/tests/generic/319
@@ -12,7 +12,7 @@
 #     https://patchwork.kernel.org/patch/3046931/
 #
 . ./common/preamble
-_begin_fstest acl auto quick
+_begin_fstest acl auto quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/355 b/tests/generic/355
index 4bc69eeb..7c108d1b 100755
--- a/tests/generic/355
+++ b/tests/generic/355
@@ -7,7 +7,7 @@
 # Test clear of suid/sgid on direct write.
 #
 . ./common/preamble
-_begin_fstest auto quick
+_begin_fstest auto quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/362 b/tests/generic/362
index dcd0a27b..6e0e81ed 100755
--- a/tests/generic/362
+++ b/tests/generic/362
@@ -7,7 +7,7 @@
 # RichACL apply-masks test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/363 b/tests/generic/363
index 8a441869..d3d888db 100755
--- a/tests/generic/363
+++ b/tests/generic/363
@@ -7,7 +7,7 @@
 # RichACL auto-inheritance test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/364 b/tests/generic/364
index 538c0eb1..2c721fea 100755
--- a/tests/generic/364
+++ b/tests/generic/364
@@ -7,7 +7,7 @@
 # RichACL basic test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 . ./common/attr
diff --git a/tests/generic/365 b/tests/generic/365
index 21f31b86..d22f233a 100755
--- a/tests/generic/365
+++ b/tests/generic/365
@@ -7,7 +7,7 @@
 # RichACL chmod test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/366 b/tests/generic/366
index e5969114..c005f809 100755
--- a/tests/generic/366
+++ b/tests/generic/366
@@ -7,7 +7,7 @@
 # RichACL chown test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/367 b/tests/generic/367
index bed45215..db7b2956 100755
--- a/tests/generic/367
+++ b/tests/generic/367
@@ -7,7 +7,7 @@
 # RichACL create test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/368 b/tests/generic/368
index 4b18e9f0..d2259b34 100755
--- a/tests/generic/368
+++ b/tests/generic/368
@@ -7,7 +7,7 @@
 # RichACL ctime test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/369 b/tests/generic/369
index dbd20105..526de244 100755
--- a/tests/generic/369
+++ b/tests/generic/369
@@ -7,7 +7,7 @@
 # RichACL delete test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/370 b/tests/generic/370
index acb0f424..8c17af0c 100755
--- a/tests/generic/370
+++ b/tests/generic/370
@@ -7,7 +7,7 @@
 # RichACL write-vs-append test
 #
 . ./common/preamble
-_begin_fstest auto quick richacl
+_begin_fstest auto quick richacl perms
 
 # Import common functions.
 
diff --git a/tests/generic/375 b/tests/generic/375
index 746cdd55..438184b3 100755
--- a/tests/generic/375
+++ b/tests/generic/375
@@ -8,7 +8,7 @@
 # owning group.
 #
 . ./common/preamble
-_begin_fstest auto quick acl
+_begin_fstest auto quick acl perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/444 b/tests/generic/444
index 8f6b7c2c..71d2f6af 100755
--- a/tests/generic/444
+++ b/tests/generic/444
@@ -8,7 +8,7 @@
 # in the owning group and directory has default ACLs.
 #
 . ./common/preamble
-_begin_fstest auto quick acl
+_begin_fstest auto quick acl perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/673 b/tests/generic/673
index 4d8dc07e..6d1f49ea 100755
--- a/tests/generic/673
+++ b/tests/generic/673
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a reflink.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/674 b/tests/generic/674
index a3130249..c3ff1b7b 100755
--- a/tests/generic/674
+++ b/tests/generic/674
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a deduplication.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/generic/683 b/tests/generic/683
index 4c93346d..302f8bb2 100755
--- a/tests/generic/683
+++ b/tests/generic/683
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fallocate.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/684 b/tests/generic/684
index 03481e69..19ccb228 100755
--- a/tests/generic/684
+++ b/tests/generic/684
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fpunch.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/685 b/tests/generic/685
index 6a108842..a58eccda 100755
--- a/tests/generic/685
+++ b/tests/generic/685
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fzero.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/686 b/tests/generic/686
index 4279f76b..ef9ea47a 100755
--- a/tests/generic/686
+++ b/tests/generic/686
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a finsert.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/generic/687 b/tests/generic/687
index 78cb6202..f4a1c1bb 100755
--- a/tests/generic/687
+++ b/tests/generic/687
@@ -7,7 +7,7 @@
 # Functional test for dropping suid and sgid bits as part of a fcollapse.
 #
 . ./common/preamble
-_begin_fstest auto clone quick
+_begin_fstest auto clone quick perms
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/overlay/004 b/tests/overlay/004
index 54ce8a8f..f03f628a 100755
--- a/tests/overlay/004
+++ b/tests/overlay/004
@@ -7,7 +7,7 @@
 # Test file copy up on overlayfs by changing mode bits.
 #
 . ./common/preamble
-_begin_fstest attr auto copyup quick
+_begin_fstest attr auto copyup quick perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/overlay/008 b/tests/overlay/008
index d14f22f2..7bab4fbe 100755
--- a/tests/overlay/008
+++ b/tests/overlay/008
@@ -11,7 +11,7 @@
 # d0e13f5 ovl: fix uid/gid when creating over whiteout
 #
 . ./common/preamble
-_begin_fstest auto quick whiteout
+_begin_fstest auto quick whiteout perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/overlay/015 b/tests/overlay/015
index fd23e373..f0c05579 100755
--- a/tests/overlay/015
+++ b/tests/overlay/015
@@ -7,7 +7,7 @@
 # SGID bit inheritance over whiteout.
 #
 . ./common/preamble
-_begin_fstest auto quick whiteout
+_begin_fstest auto quick whiteout perms
 
 # Import common functions.
 . ./common/filter
diff --git a/tests/overlay/023 b/tests/overlay/023
index 95d5aa22..740c47c1 100755
--- a/tests/overlay/023
+++ b/tests/overlay/023
@@ -14,7 +14,7 @@
 #     Miklos Szeredi <mszeredi@redhat.com>
 #
 . ./common/preamble
-_begin_fstest auto quick attr
+_begin_fstest auto quick attr perms
 
 # Import common functions.
 . ./common/filter
-- 
2.23.0

