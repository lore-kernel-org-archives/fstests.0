Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0636C77B73
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Apr 2023 02:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjDTCLR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Apr 2023 22:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDTCLQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 19 Apr 2023 22:11:16 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28E21BF0
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2023 19:11:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VgWwQtc_1681956667;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VgWwQtc_1681956667)
          by smtp.aliyun-inc.com;
          Thu, 20 Apr 2023 10:11:12 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Christian Brauner <brauner@kernel.org>,
        "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2] src: fix detached_mounts_propagation compile errors
Date:   Thu, 20 Apr 2023 10:11:06 +0800
Message-Id: <20230420021106.41970-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
References: <20230419032955.114278-1-hsiangkao@linux.alibaba.com>
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

Let's get rid of <linux/mount.h> as Christian suggested to avoid
potential incompatibility between these two headers.

Cc: Christian Brauner <brauner@kernel.org>
Cc: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 configure.ac                      | 2 +-
 src/detached_mounts_propagation.c | 1 -
 src/vfs/missing.h                 | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4687d8a3..bb29f37e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -74,7 +74,7 @@ AC_HAVE_FIEXCHANGE
 
 AC_CHECK_FUNCS([renameat2])
 AC_CHECK_FUNCS([reallocarray])
-AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
+AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <sys/mount.h>]])
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

