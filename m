Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6F4C77B76
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Apr 2023 03:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjDSDaM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Apr 2023 23:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDSDaK (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Apr 2023 23:30:10 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9F1984
        for <fstests@vger.kernel.org>; Tue, 18 Apr 2023 20:30:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VgTAlwv_1681874995;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgTAlwv_1681874995)
          by smtp.aliyun-inc.com;
          Wed, 19 Apr 2023 11:30:05 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH] src: fix detached_mounts_propagation compile errors
Date:   Wed, 19 Apr 2023 11:29:55 +0800
Message-Id: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Newer glibc such as glibc 2.36 also defines 'struct mount_attr'
in addition to <linux/mount.h>.  It will report as below when
compiling with old linux kernel headers (without idmapped mounts,
such as kernel-headers 5.10.134) but with newer glibc (here checked
with glibc 2.36.6):

    [CC]    detached_mounts_propagation
In file included from detached_mounts_propagation.c:29:
vfs/missing.h:115:8: error: redefinition of 'struct mount_attr'
  115 | struct mount_attr {
      |        ^~~~~~~~~~
In file included from detached_mounts_propagation.c:23:
/usr/include/sys/mount.h:210:8: note: originally defined here
  210 | struct mount_attr
      |        ^~~~~~~~~~
gmake[3]: *** [Makefile:102: detached_mounts_propagation] Error 1
gmake[2]: *** [include/buildrules:31: src] Error 2
make[1]: *** [Makefile:51: default] Error 2
make: *** [Makefile:49: default] Error 2

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---

Not quite look into that, but at a quick glance of tester reports
it seems the cases.

 configure.ac                      | 5 ++++-
 src/detached_mounts_propagation.c | 1 -
 src/vfs/missing.h                 | 1 +
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4687d8a3..517b4c18 100644
--- a/configure.ac
+++ b/configure.ac
@@ -74,7 +74,10 @@ AC_HAVE_FIEXCHANGE
 
 AC_CHECK_FUNCS([renameat2])
 AC_CHECK_FUNCS([reallocarray])
-AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
+AC_CHECK_TYPES([struct mount_attr], [], [], [[
+#include <linux/mount.h>
+#include <sys/mount.h>
+]])
 AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
 #include <stddef.h>
 #include <linux/btrfs.h>
diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
index 17db2c02..4041c75f 100644
--- a/src/detached_mounts_propagation.c
+++ b/src/detached_mounts_propagation.c
@@ -20,7 +20,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
diff --git a/src/vfs/missing.h b/src/vfs/missing.h
index 059e742d..04ab33d1 100644
--- a/src/vfs/missing.h
+++ b/src/vfs/missing.h
@@ -18,6 +18,7 @@
 #include <sys/types.h>
 #include <syscall.h>
 #include <unistd.h>
+#include <sys/mount.h>
 
 #ifndef __NR_mount_setattr
 	#if defined __alpha__
-- 
2.24.4

