Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52135C43334
	for <linux-fstests@archiver.kernel.org>; Tue, 21 Jun 2022 17:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiFURhm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 21 Jun 2022 13:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiFURhl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 21 Jun 2022 13:37:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15DA2CC8A
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso9688771wms.3
        for <fstests@vger.kernel.org>; Tue, 21 Jun 2022 10:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRkonhqIqKPjwKgYdn753QW8oSwPce1FWrd5SGWX04c=;
        b=IBjA+woPMcS93VB3rTtjs2IT8Ua3FmMZ1vnmrix5L1HpMrlrJbL8WsF6kSGFp+wzaC
         pAdHknRb8yI9C3B6bsKRum5fEncnmRX/Ya0rVJBhIDe+ucqhI9gUrm12nXJRywypt2BB
         5XNteTvaKGf8dNebZjtIiO4P9zf1iYTKXtWcWZ9SHhgnn3n3ewKoBlCxR1DSSraapoR8
         gf1rIBR59CuUG3DLmSU5dg5Zt7U3SH1r0D4rmnn7A0E5CE+eMd0bDyHI63Q1nJzOPGUs
         TmY+Eqg+5FBmr1cKXY5AFYDnBQnUMJmjdZyaCeNxoMhJ4weUf17xqqrJiiM80Jo1pF6u
         GyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRkonhqIqKPjwKgYdn753QW8oSwPce1FWrd5SGWX04c=;
        b=5M5OJgI8PntuZTyqOF64mZWR96jtLyzQJt3bl+JlgIYIqahQIWPOruFZZrHtQMVuyC
         bJ2Xr+8qA1SkEh40GjfWDDomj5vOEEHxn0SvDSi1o9FGyg0KhIeCPFOjeA7LZyRSwbhI
         CJrTdmD4M6fI8kRP8S1YTXH3mn8CQA+OQoicrLuXXY7Cue1KYUf51jewPZw3UPlWkffr
         HJ7vojHjuzHSI+2sRkeUMLlkYVV4AmWsPnf/6/q0M6wpaY1XcWUdYQpM4N2ve8KozzgJ
         TfOD9i3SvAz6nljM3CQImXTvlFfl3kF9gDT94jU9hjMgyPE+jjWS0E9LJ60dDtADXPyB
         j7YQ==
X-Gm-Message-State: AOAM533Lf90Hv0NNWv5aDLrbB4fVBdxkN9Lapl4lTmSrbRDQGbNrFTEX
        5AKnK1ziTiTas6UQYTFGSck=
X-Google-Smtp-Source: ABdhPJy05xz2ZgN+flNPbmqB2A/Kya/yEYi0JTOzdTH25FAwAHV+981BBtC+UkWPsXfWwPT3SBUP2Q==
X-Received: by 2002:a05:600c:4e54:b0:39c:6e5e:c667 with SMTP id e20-20020a05600c4e5400b0039c6e5ec667mr40924897wmq.151.1655833059475;
        Tue, 21 Jun 2022 10:37:39 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id k17-20020a5d6e91000000b0021a39f5ba3bsm16105120wrz.7.2022.06.21.10.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 10:37:38 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH v2 3/3] xfs/{422,517}: kill background jobs on test termination
Date:   Tue, 21 Jun 2022 20:37:29 +0300
Message-Id: <20220621173729.2135249-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220621173729.2135249-1-amir73il@gmail.com>
References: <20220621173729.2135249-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Those tests failed to cleanup background jobs properly after test
is interrupted and even sometimes when it completed succefully.

xfs/517 would sometime fails randomally with this false positive error:
     QA output created by 517
     Format and populate
     Concurrent fsmap and freeze
    +Terminated
     Test done

The tests have several background sub-shells that spawn short lived
programs in a loop.  By killing the spawned programs using killall,
killall could find no process to kill and the sub-shell loop could still
spawn another process that is not going to be killed and in the worst
case, the freeze_loop() could spawn the xfs_io "freeze" command after
test has thawn the fs before exit, which leaves the fs frozen after the
test.

The "Terminated" output is emitted by the sub-shell when killing the
programs that it has spawned when the loop did not finish before test
timeout.  By killing the sub-shell and not the spawned programs, we
avoid the false positive "Terminated" error.

Use a helper to perform this cleanup dance:
First kill and wait the freeze_loop so it won't try to freeze fs again
Then make sure fs is not frozen.
Then kill and wait for the rest of the sub-shells, because
if fs is frozen a killed writer process will never exit.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/xfs/422 | 32 ++++++++++++++++++++++++++++++--
 tests/xfs/517 | 26 +++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/tests/xfs/422 b/tests/xfs/422
index a83a66df..fdbb8bf1 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -13,6 +13,32 @@ _begin_fstest dangerous_scrub dangerous_online_repair freeze
 
 _register_cleanup "_cleanup" BUS
 
+# First kill and wait the freeze loop so it won't try to freeze fs again
+# Then make sure fs is not frozen
+# Then kill and wait for the rest of the workers
+# Because if fs is frozen a killed writer will never exit
+kill_loops() {
+	local sig=$1
+
+	[ -n "$freeze_pid" ] && kill $sig $freeze_pid
+	wait $freeze_pid
+	unset freeze_pid
+	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT
+	[ -n "$stress_pid" ] && kill $sig $stress_pid
+	[ -n "$repair_pid" ] && kill $sig $repair_pid
+	wait
+	unset stress_pid
+	unset repair_pid
+}
+
+# Override the default cleanup function.
+_cleanup()
+{
+	kill_loops -9 > /dev/null 2>&1
+	cd /
+	rm -rf $tmp.*
+}
+
 # Import common functions.
 . ./common/filter
 . ./common/fuzzy
@@ -78,8 +104,11 @@ end=$((start + (30 * TIME_FACTOR) ))
 
 echo "Loop started at $(date --date="@${start}"), ending at $(date --date="@${end}")" >> $seqres.full
 stress_loop $end &
+stress_pid=$!
 freeze_loop $end &
+freeze_pid=$!
 repair_loop $end &
+repair_pid=$!
 
 # Wait until 2 seconds after the loops should have finished...
 while [ "$(date +%s)" -lt $((end + 2)) ]; do
@@ -87,8 +116,7 @@ while [ "$(date +%s)" -lt $((end + 2)) ]; do
 done
 
 # ...and clean up after the loops in case they didn't do it themselves.
-$KILLALL_PROG -TERM xfs_io fsstress >> $seqres.full 2>&1
-$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT >> $seqres.full 2>&1
+kill_loops >> $seqres.full 2>&1
 
 echo "Loop finished at $(date)" >> $seqres.full
 echo "Test done"
diff --git a/tests/xfs/517 b/tests/xfs/517
index f7f9a8a2..6877af13 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -11,11 +11,29 @@ _begin_fstest auto quick fsmap freeze
 
 _register_cleanup "_cleanup" BUS
 
+# First kill and wait the freeze loop so it won't try to freeze fs again
+# Then make sure fs is not frozen
+# Then kill and wait for the rest of the workers
+# Because if fs is frozen a killed writer will never exit
+kill_loops() {
+	local sig=$1
+
+	[ -n "$freeze_pid" ] && kill $sig $freeze_pid
+	wait $freeze_pid
+	unset freeze_pid
+	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT
+	[ -n "$stress_pid" ] && kill $sig $stress_pid
+	[ -n "$fsmap_pid" ] && kill $sig $fsmap_pid
+	wait
+	unset stress_pid
+	unset fsmap_pid
+}
+
 # Override the default cleanup function.
 _cleanup()
 {
+	kill_loops -9 > /dev/null 2>&1
 	cd /
-	$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT > /dev/null 2>&1
 	rm -rf $tmp.*
 }
 
@@ -83,8 +101,11 @@ end=$((start + (30 * TIME_FACTOR) ))
 
 echo "Loop started at $(date --date="@${start}"), ending at $(date --date="@${end}")" >> $seqres.full
 stress_loop $end &
+stress_pid=$!
 freeze_loop $end &
+freeze_pid=$!
 fsmap_loop $end &
+fsmap_pid=$!
 
 # Wait until 2 seconds after the loops should have finished...
 while [ "$(date +%s)" -lt $((end + 2)) ]; do
@@ -92,8 +113,7 @@ while [ "$(date +%s)" -lt $((end + 2)) ]; do
 done
 
 # ...and clean up after the loops in case they didn't do it themselves.
-$KILLALL_PROG -TERM xfs_io fsstress >> $seqres.full 2>&1
-$XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT >> $seqres.full 2>&1
+kill_loops >> $seqres.full 2>&1
 
 echo "Loop finished at $(date)" >> $seqres.full
 echo "Test done"
-- 
2.25.1

