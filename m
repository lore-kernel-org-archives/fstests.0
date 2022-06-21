Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC8CCA480
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 17:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiFURhl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiFURhl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 13:37:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD68D2CC9E
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:39 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id i10so16191588wrc.0
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dhtQxMZduKD7jyt1y7myf8aCdKHX+d2vjbXcShdqJqA=;
        b=NDYExTb8wS/ybdeqJ6veFC1M3e3aW/V0zEqekSKqZFQmRU1t1gG2o6djFoVmrDDcm1
         CYG1Tgm1cWs9IU34ZSqx6rCWzhX1QUrIL8WC8FUDWSOCqe1w050mFueXHbEBxJQL56fw
         aGyb4HTSdqfaUN8cEFjcQzHM8B1rfWJUPtbJ26VtoB3xfwsOjAVCPF/WXTT+aTxMQaam
         buWpA2x1QnlCNsbwrgDqaQCw2mRtlsPalhTMJROYo0ZoB845VhTESnQtXpN3aa4pvHBR
         Tp8UvvaolWjbiyOkWZnm1gPBio0dlL05zvzBKsUvGJ3zGQkQBC6eAGoBjXht5ynUfKes
         P68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dhtQxMZduKD7jyt1y7myf8aCdKHX+d2vjbXcShdqJqA=;
        b=O5Gryl1lqG4UQJdW07MjVdRnbwCE7Y5ZKfixm0QLvr9BlS8jvIa9Fohu3Cqiip1Qyx
         Hg5YkbKTcCofEkD4Xj+tyhAyxLu8hr0bNe2Jg6dTKUr+oyj8rBjaBO2cWbSRqfZy1sFU
         GwJNAz4WsTimetkv2DRpbWtJb6XzzAhnxN4zYg0oGTKi/+BGh2pvXXSs7sFKpDktuXOc
         jPO1NkmqEjcIXqPecdsiw3zo2YqXnFxLYYMtqi410m6HjULfWs1qfAtAJx61T9YMHMmq
         V0b5AcH9emq4lijB2QUzY7DfIYImK2CJ947/OvxksEbXVELsm8N9MUiE2ILFh1i8K/PD
         2Zag==
X-Gm-Message-State: AJIora98FrG0rTcPf3e7qw9ieQ1dLROK3J6h2VJ3m6XDPIkoMQy1PKgt
        0EYiXsAbuyn6rln2mV4oMZg=
X-Google-Smtp-Source: AGRyM1uyS1HogO8aBdOiY9Bty8wJ3zWe7PavQ3GnNCeY1gvKCCh7MuXJ+bf1/Riui++gC0YVHa/2dA==
X-Received: by 2002:adf:fbd0:0:b0:21b:90cd:69f2 with SMTP id d16-20020adffbd0000000b0021b90cd69f2mr10251606wrs.525.1655833058073;
        Tue, 21 Jun 2022 10:37:38 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6e91000000b0021a39f5ba3bsm16105120wrz.7.2022.06.21.10.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:37:37 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH v2 2/3] fstests: unfreeze fs on cleanup routines
Date:   Tue, 21 Jun 2022 20:37:28 +0300
Message-Id: <20220621173729.2135249-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621173729.2135249-1-amir73il@gmail.com>
References: <20220621173729.2135249-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Many of tests that freeze fs do not make sure that fs is unfrozen on
test termination.

Some tests also need to kill and wait for writer processes after
unfreezing the fs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/068 | 14 ++++++++++----
 tests/generic/085 |  3 +++
 tests/generic/280 | 13 ++++++++++++-
 tests/generic/390 |  8 +++++++-
 tests/generic/459 |  2 ++
 tests/generic/491 |  9 +++++++++
 tests/xfs/011     |  3 ++-
 tests/xfs/119     |  9 +++++++++
 tests/xfs/297     | 11 +++++++++++
 tests/xfs/318     |  3 ++-
 tests/xfs/325     |  3 ++-
 tests/xfs/438     |  2 ++
 12 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/tests/generic/068 b/tests/generic/068
index 56262cd7..eeddf6d1 100755
--- a/tests/generic/068
+++ b/tests/generic/068
@@ -17,9 +17,12 @@ ITERATIONS=10
 # Override the default cleanup function.
 _cleanup()
 {
-    cd /
-
-    trap 0 1 2 3 15
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
+	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
+	wait $pid
+	cd /
+	rm -f $tmp.*
 }
 
 # Import common functions.
@@ -60,6 +63,7 @@ touch $tmp.running
     rm -r $STRESS_DIR/*
     rmdir $STRESS_DIR
 } &
+pid=$!
 
 # start fstest -m loop in a background block; this gets us mmap coverage
 {
@@ -75,6 +79,7 @@ touch $tmp.running
     rm -rf $FSTEST_DIR/*
     rmdir $FSTEST_DIR
 } &
+pid="$pid $!"
 
 i=0
 let ITERATIONS=$ITERATIONS-1
@@ -103,6 +108,7 @@ done
 rm $tmp.running
 
 # wait for fsstresses to finish
-wait
+wait $pid
+unset pid
 
 exit 1
diff --git a/tests/generic/085 b/tests/generic/085
index 20cf875a..786d8e6f 100755
--- a/tests/generic/085
+++ b/tests/generic/085
@@ -25,6 +25,8 @@ cleanup_dmdev()
 {
 	# in case it's still suspended and/or mounted
 	$DMSETUP_PROG resume $lvdev >/dev/null 2>&1
+	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
+	wait $pid
 	$UMOUNT_PROG $lvdev >/dev/null 2>&1
 	_dmsetup_remove $node
 }
@@ -75,6 +77,7 @@ done &
 pid="$pid $!"
 
 wait $pid
+unset pid
 
 status=0
 exit
diff --git a/tests/generic/280 b/tests/generic/280
index 07144555..8e1ae4d2 100755
--- a/tests/generic/280
+++ b/tests/generic/280
@@ -10,6 +10,17 @@
 . ./common/preamble
 _begin_fstest auto quota freeze
 
+# Override the default cleanup function.
+_cleanup()
+{
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
+	[ -n "$pid" ] && kill -9 $pid 2>/dev/null
+	wait $pid
+	cd /
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/quota
@@ -34,7 +45,7 @@ pid=$!
 sleep 1
 xfs_freeze -u $SCRATCH_MNT
 wait $pid
-_scratch_unmount
+unset pid
 
 # Failure comes in the form of a deadlock.
 
diff --git a/tests/generic/390 b/tests/generic/390
index 20c66e22..e8f6a5dc 100755
--- a/tests/generic/390
+++ b/tests/generic/390
@@ -14,8 +14,12 @@ _begin_fstest auto freeze stress
 _cleanup()
 {
 	cd /
-	# Make sure $SCRATCH_MNT is unfreezed
+	# Kill freeze loops and make sure $SCRATCH_MNT is unfreezed
+	[ -n "$freeze_pids" ] && kill -9 $freeze_pids 2>/dev/null
+	wait $freeze_pids
 	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
+	[ -n "$fsstress_pid" ] && kill -9 $fsstress_pid 2>/dev/null
+	wait $fsstress_pid
 	rm -f $tmp.*
 }
 
@@ -62,7 +66,9 @@ done
 
 wait $fsstress_pid
 result=$?
+unset fsstress_pid
 wait $freeze_pids
+unset freeze_pids
 
 # Exit with fsstress return value
 status=$result
diff --git a/tests/generic/459 b/tests/generic/459
index 57d58e55..7be39089 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -24,6 +24,8 @@ _begin_fstest auto freeze thin
 # Override the default cleanup function.
 _cleanup()
 {
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
 	cd /
 	rm -f $tmp.*
 	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
diff --git a/tests/generic/491 b/tests/generic/491
index e6e57dcd..797b08d5 100755
--- a/tests/generic/491
+++ b/tests/generic/491
@@ -12,6 +12,15 @@
 . ./common/preamble
 _begin_fstest auto quick freeze mount
 
+# Override the default cleanup function.
+_cleanup()
+{
+	cd /
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/011 b/tests/xfs/011
index d6e9099e..ed44d074 100755
--- a/tests/xfs/011
+++ b/tests/xfs/011
@@ -16,10 +16,11 @@ _begin_fstest auto freeze log metadata quick
 # Override the default cleanup function.
 _cleanup()
 {
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
 	$KILLALL_PROG -9 fsstress 2>/dev/null
 	wait
 	cd /
-	_scratch_unmount 2>/dev/null
 	rm -f $tmp.*
 }
 
diff --git a/tests/xfs/119 b/tests/xfs/119
index b6f96601..5ffbce25 100755
--- a/tests/xfs/119
+++ b/tests/xfs/119
@@ -11,6 +11,15 @@
 . ./common/preamble
 _begin_fstest log v2log auto freeze
 
+# Override the default cleanup function.
+_cleanup()
+{
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
+	cd /
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/297 b/tests/xfs/297
index ca482e06..07f84c25 100755
--- a/tests/xfs/297
+++ b/tests/xfs/297
@@ -11,6 +11,17 @@
 . ./common/preamble
 _begin_fstest auto freeze
 
+# Override the default cleanup function.
+_cleanup()
+{
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
+	$KILLALL_PROG -q -9 $FSSTRESS_PROG
+	wait
+	cd /
+	rm -f $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 
diff --git a/tests/xfs/318 b/tests/xfs/318
index be93f9ab..5798f9a3 100755
--- a/tests/xfs/318
+++ b/tests/xfs/318
@@ -12,8 +12,9 @@ _begin_fstest auto quick rw freeze
 # Override the default cleanup function.
 _cleanup()
 {
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
 	cd /
-	_scratch_unmount > /dev/null 2>&1
 	rm -rf $tmp.*
 }
 
diff --git a/tests/xfs/325 b/tests/xfs/325
index c6861fbc..43fb09a6 100755
--- a/tests/xfs/325
+++ b/tests/xfs/325
@@ -13,8 +13,9 @@ _begin_fstest auto quick clone freeze
 # Override the default cleanup function.
 _cleanup()
 {
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
 	cd /
-	_scratch_unmount > /dev/null 2>&1
 	rm -rf $tmp.*
 }
 
diff --git a/tests/xfs/438 b/tests/xfs/438
index cfe75bd8..0425c5b1 100755
--- a/tests/xfs/438
+++ b/tests/xfs/438
@@ -26,6 +26,8 @@ _begin_fstest auto quick quota freeze
 # Override the default cleanup function.
 _cleanup()
 {
+	# Make sure $SCRATCH_MNT is unfreezed
+	xfs_freeze -u $SCRATCH_MNT 2>/dev/null
 	[ -z "${interval}" ] || \
 		sysctl -w fs.xfs.xfssyncd_centisecs=${interval} >/dev/null 2>&1
 	cd /
-- 
2.25.1

