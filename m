Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F12CCA47A
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jun 2022 13:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiFSNr0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiFSNrJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jun 2022 09:47:09 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB9E637B
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:08 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g27so4681687wrb.10
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lspYXotJXIgD9rJo2AqmUY24qO9c5voykkTiI+kyxYw=;
        b=K0tjo59tsCY6kphCsc4nBNJjkxGkqo15n6jtyI8Daniwku3hbZnwnz9OyCQv75+jsg
         9KfBN9fYpNKEXqsRE6LZlpZWWxIZnW9vUlR5v/QeE95FS1WTQXS4RL1ELRdQjz0clijI
         TuxrjquDiv89PUw4HU+5wpIV1mJl/Aoo2esxAVx7iJPBiPoBO2fo+gj44g5nlM00UXsa
         uZu0m3wY4BN7AcjonGSC/ItbjL/RmZulPWUnNq85x42rlFJGhxARM5abuCJekvL3jYbH
         3+J+1dft8KjYl8GUXMIbKf2h0u3LYk9nJ3IwG4hby2mr8/eJGDdcIaKQaUIurWFu8dz9
         wTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lspYXotJXIgD9rJo2AqmUY24qO9c5voykkTiI+kyxYw=;
        b=fR/QOjldu4dEusOJ7QtTHa5bCtZF+bAGGCsKpZvGukY7H7JdYQC8DWwz7lWvACQBVP
         6tayInGwPutDbK9+LRfTV8bHj4gLWAdiJxK/7hvVcfFTBqWMz7x83Wgo4X2y1YUatwOS
         L1F207EBjrNriIUrMd/1+zGj1WuJYt/3iGDm0CvZ62Xup1OmpXGCK3bK4qQNRVkPoixd
         7/j1Gvp3E3t7BCd8V//ATACmdpPnzT45Img689ZkZje90SM0LRMyED5QMaWPW/XQRLMd
         gw8gyB2cYbL+EgP3W9y9RbkYps7VPuumicnqYsIluKPz+BTc+bRrSCd8nsGjCEcGA1NK
         etSQ==
X-Gm-Message-State: AJIora/rOrexkY8Y0pV0ixhWke8wDeme7/vaqk3WCs8o0/GIefuW7mLL
        ysZLYRqlc+CTwCF6P6BntWY=
X-Google-Smtp-Source: AGRyM1tjuh5AuiBgFI1Ede0lFVxlF8XCcG9mBOo1Daqnfe/rUb5H+9K3LuOKROBjmG5DP42W3taRgg==
X-Received: by 2002:a05:6000:3cd:b0:21b:8e8d:470f with SMTP id b13-20020a05600003cd00b0021b8e8d470fmr1124883wrg.387.1655646426774;
        Sun, 19 Jun 2022 06:47:06 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b00219e77e489fsm5240927wrj.17.2022.06.19.06.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:47:06 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH 1/4] fstests: add missing _require_freeze() to tests
Date:   Sun, 19 Jun 2022 16:46:54 +0300
Message-Id: <20220619134657.1846292-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220619134657.1846292-1-amir73il@gmail.com>
References: <20220619134657.1846292-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

And add a few tests that use freeze to the freeze group

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/xfs/119 | 1 +
 tests/xfs/318 | 3 ++-
 tests/xfs/325 | 3 ++-
 tests/xfs/422 | 3 ++-
 tests/xfs/438 | 2 +-
 tests/xfs/517 | 1 +
 6 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/119 b/tests/xfs/119
index a1180371..b6f96601 100755
--- a/tests/xfs/119
+++ b/tests/xfs/119
@@ -20,6 +20,7 @@ _begin_fstest log v2log auto freeze
 _supported_fs xfs
 
 _require_scratch
+_require_freeze
 
 # this may hang
 sync
diff --git a/tests/xfs/318 b/tests/xfs/318
index 38c7aa60..be93f9ab 100755
--- a/tests/xfs/318
+++ b/tests/xfs/318
@@ -7,7 +7,7 @@
 # Simulate free extent errors with a file write and a file remove.
 #
 . ./common/preamble
-_begin_fstest auto quick rw
+_begin_fstest auto quick rw freeze
 
 # Override the default cleanup function.
 _cleanup()
@@ -26,6 +26,7 @@ _supported_fs xfs
 _require_scratch
 _require_error_injection
 _require_xfs_io_error_injection "rmap_finish_one"
+_require_freeze
 
 blksz=65536
 blks=64
diff --git a/tests/xfs/325 b/tests/xfs/325
index 5b26b2b3..c6861fbc 100755
--- a/tests/xfs/325
+++ b/tests/xfs/325
@@ -8,7 +8,7 @@
 # Inject an error during extent freeing to test log recovery.
 #
 . ./common/preamble
-_begin_fstest auto quick clone
+_begin_fstest auto quick clone freeze
 
 # Override the default cleanup function.
 _cleanup()
@@ -29,6 +29,7 @@ _require_cp_reflink
 _require_scratch_reflink
 _require_error_injection
 _require_xfs_io_error_injection "free_extent"
+_require_freeze
 
 blksz=65536
 blks=30
diff --git a/tests/xfs/422 b/tests/xfs/422
index 175253aa..a83a66df 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -9,7 +9,7 @@
 # activity, so we can't have userspace wandering in and thawing it.
 #
 . ./common/preamble
-_begin_fstest dangerous_scrub dangerous_online_repair
+_begin_fstest dangerous_scrub dangerous_online_repair freeze
 
 _register_cleanup "_cleanup" BUS
 
@@ -24,6 +24,7 @@ _require_xfs_scratch_rmapbt
 _require_xfs_io_command "scrub"
 _require_xfs_io_error_injection "force_repair"
 _require_command "$KILLALL_PROG" killall
+_require_freeze
 
 echo "Format and populate"
 _scratch_mkfs > "$seqres.full" 2>&1
diff --git a/tests/xfs/438 b/tests/xfs/438
index c3008b1c..cfe75bd8 100755
--- a/tests/xfs/438
+++ b/tests/xfs/438
@@ -21,7 +21,7 @@
 # Fixed by upstream commit 373b058 ("xfs: Properly retry failed dquot
 # items in case of error during buffer writeback")
 . ./common/preamble
-_begin_fstest auto quick quota
+_begin_fstest auto quick quota freeze
 
 # Override the default cleanup function.
 _cleanup()
diff --git a/tests/xfs/517 b/tests/xfs/517
index 88c4f43b..f7f9a8a2 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -29,6 +29,7 @@ _supported_fs xfs
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "fsmap"
 _require_command "$KILLALL_PROG" killall
+_require_freeze
 
 echo "Format and populate"
 _scratch_mkfs > "$seqres.full" 2>&1
-- 
2.25.1

