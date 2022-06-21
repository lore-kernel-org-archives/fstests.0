Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B98C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiFURhk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 13:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiFURhj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 13:37:39 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36322CC8A
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c21so19954768wrb.1
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lspYXotJXIgD9rJo2AqmUY24qO9c5voykkTiI+kyxYw=;
        b=K6hFRUntBh+CmCcIqqtFywNaZrXx3wLf3/Gdr1aNxwpiSW+hrPmzAhLDPl/sZQA6kv
         ZlwY7gwFeIIj47B8p/TwXjqedysJxO2Yr5ty8Vvq9Pgf93WjqKvX1XBSIEo7VM9wuFHR
         TljM6qEYa6SQzRhSy7ioxC/ypMER4BlwyzwyqfIHKo08w5kWkGkyUuzRgo6krTDZ+7Gb
         0TGLnfjgPT75ePTKJSoeFraHOzC/083HGIy/h0JH46OHl++klh/rfl0JAyVdDH9YcIF3
         d7cxkGpQ2SCG8UgoXqatNlAYzgCh8JLreeUxWT8SD00ZZxwqxk2BtuXHMXjZFiJTR5hT
         oYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lspYXotJXIgD9rJo2AqmUY24qO9c5voykkTiI+kyxYw=;
        b=748LRYkyWRdjDfrfzsq3w9lomoxzpIgg+4KCE1SdyjQvAi/6Q30pFRAReGoM/KavYU
         CIXRnCiI/TBiLYeIMuqw7Wtj1SzwOegouFuxdVKJZrGM7+gkjPf3vTli093kj4UlxlIJ
         ToAGwdpbiF/UiVyXyR3G8xjCt2NC6ME4uB1KjGrX+9Zu0MEDJQ4QIZc/QJhZ6A3nPIOG
         fFfu2mmOSDPd/y9h3bt/3l625ZcOur45GD1AqYp3td04lqzJNJWKq8lLXyp5LRrZXn51
         197pOg5OJNtk6LusS69H2UC1T7WhFj33GUJfDsL7aZrqdcK1K4c31QkhycBs57fcETuz
         ZQkg==
X-Gm-Message-State: AJIora/lv0X+hCpo6kOksgvUaYHdgBmkl+w5I4rccBAYxCi7bdBgkvYz
        CzB2rw9KIkO8JK7vxB1ITAE=
X-Google-Smtp-Source: AGRyM1uDu2WvegPq55U4YQWKetkQpH7NQ8TgIgnBzZVojuueYAM35hL5nesgggLrsTbqR/ERl+SKRg==
X-Received: by 2002:a5d:452d:0:b0:21b:81f6:d91 with SMTP id j13-20020a5d452d000000b0021b81f60d91mr21737076wra.521.1655833056322;
        Tue, 21 Jun 2022 10:37:36 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6e91000000b0021a39f5ba3bsm16105120wrz.7.2022.06.21.10.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:37:35 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH v2 1/3] fstests: add missing _require_freeze() to tests
Date:   Tue, 21 Jun 2022 20:37:27 +0300
Message-Id: <20220621173729.2135249-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621173729.2135249-1-amir73il@gmail.com>
References: <20220621173729.2135249-1-amir73il@gmail.com>
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

