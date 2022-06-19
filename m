Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E3C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Jun 2022 13:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiFSNrQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Jun 2022 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiFSNrM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Jun 2022 09:47:12 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F06378
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s1so11323757wra.9
        for <fstests@vger.kernel.org>; Sun, 19 Jun 2022 06:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y7mIojUzM3TQW2pFtzOR8BoJMf+4DFvFBS0HS4mtQCY=;
        b=ZuUkDQwVtHiahMBxgdVB3URJCgeUoltun3EmhFTQP5WiNnwqHmGSEqvyPo4ksXSD0b
         zRgjcF496OK+ULZQMtWkqJmhdWuwoeqr0nYw4j/zI64QO7IdetCSyi4+9eDDjYJ3WlEG
         nFVCtXyOzCt+dTV1DXXXWbxwiMoKQCb3iNPXC2sFeqRR/4cTcGI9XrN+qhX/Cdv98yum
         H8LodUDKA5OaT4jcxUm4OvirOFQs9HUI8urJdix4Ihq6GO/OB8XADDRRnrw5WNtjE1UA
         QT2BCw75Sn4RDR0YAh7UBOzchmkofPtwkNoTPr7Rw5yVBtutTehOoBUT+YEB3W+qGvul
         qSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y7mIojUzM3TQW2pFtzOR8BoJMf+4DFvFBS0HS4mtQCY=;
        b=BSoVENz+6Nq1sCPRX7o4nRbdLMXAg2dWn+CgjnQLdVYk/q6W+70xLB4xbHIHXrtxt9
         ZZJM0NcNPqEiWfOyyTcrt+8L7wvSiaBWyl2j+/4UlMfXOjEdDWrXUr3b3suM3mw2iXrl
         BrLyKm/EJNlibsgOOC8cdjeEfLLk3IyilU32Cn4GnHgpnuoLsd6AyVuiFcp8zpekvsXu
         41sNn8uUzkYo5OFOKXGAzeiwtijL3rQeQmooahpSyM4vYz1Xjldt4/uLFrsdFxZeuZX0
         1m0ZSNIvLD1vvrXf7rXZYaiZXp5RhIYgz1ghM3L6hCCAXC7mFO5Yggf8W1+2KNI4bsne
         582Q==
X-Gm-Message-State: AJIora/biOrqj1Qz+l5lL5rYn1uHz8At5ckceUd4ICp29oAXwCoTOmHA
        qgqwRuDuIPYdLaV+u95FLe8=
X-Google-Smtp-Source: AGRyM1tYEPC9iE3rSDE7VymVQMDv6IAacF1uwQtLRaFaR8hf3bnlcW84T5dahrUf0pvxYy1BKlm5Rw==
X-Received: by 2002:a05:6000:1541:b0:219:c96a:3d3b with SMTP id 1-20020a056000154100b00219c96a3d3bmr18305001wry.393.1655646430403;
        Sun, 19 Jun 2022 06:47:10 -0700 (PDT)
Received: from localhost.localdomain ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id q18-20020adfcd92000000b00219e77e489fsm5240927wrj.17.2022.06.19.06.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 06:47:10 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Subject: [PATCH 4/4] xfs/{422,517}: fix false positive failure
Date:   Sun, 19 Jun 2022 16:46:57 +0300
Message-Id: <20220619134657.1846292-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220619134657.1846292-1-amir73il@gmail.com>
References: <20220619134657.1846292-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

xfs/517 fails randomally with this error:
 QA output created by 517
 Format and populate
 Concurrent fsmap and freeze
+Terminated
 Test done

These two test run fsstress inside the sub-shell stress_loop(),
which is run as a background job.

The sub-shell has an inner loop that exist after at least 30s.
The outer shell, sleeps for 32s and then kills fsstress using killall.
If the inner sub-shell loop does not exit before fsstress is killed,
bash sub-shell prints "Terminated" to stderr and breaks golden output.

There are two easy solutions to this issue:
1. The sub-shell stderr could be redirected to /dev/null or $seq.full
2. killall can use SIGINT which suppresses the "Terminated" print

The tests generic/270, generic/388, generic/475, generic/648 use
the first method, but that looses any other errors that fsstress may
report during the inner loop.

overlay/058 uses the second method (but with SIGPIPE). Use this method
to preserve other reported errors.

Alas, this is not enough to fix the false positive failure - the main
test thread needs to also wait for the background jobs to exit.
Otherwise, killall -9 in _cleanup() will cause a similar "Killed"
message in stderr.

Adding -w to killall requires to move it to after unfreeze, otherwise,
fsstress process may be left blocked on a frozen fs and wait will not
return.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/xfs/422 | 5 ++++-
 tests/xfs/517 | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/422 b/tests/xfs/422
index 8e9a3576..63d133f8 100755
--- a/tests/xfs/422
+++ b/tests/xfs/422
@@ -95,8 +95,11 @@ while [ "$(date +%s)" -lt $((end + 2)) ]; do
 done
 
 # ...and clean up after the loops in case they didn't do it themselves.
-$KILLALL_PROG -TERM xfs_io fsstress >> $seqres.full 2>&1
+# First thaw fs, so fsstress can exit, then kill and wait for fsstress.
+# Use of SIGINT instead of SIGTERM suppresses the "Terminated" print
+# from the XXX_loop() bash sub-shells
 $XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT >> $seqres.full 2>&1
+$KILLALL_PROG -w -SIGINT $XFS_IO_PROG $FSSTRESS_PROG >> $seqres.full 2>&1
 
 echo "Loop finished at $(date)" >> $seqres.full
 echo "Test done"
diff --git a/tests/xfs/517 b/tests/xfs/517
index 18404248..2f52d634 100755
--- a/tests/xfs/517
+++ b/tests/xfs/517
@@ -92,8 +92,11 @@ while [ "$(date +%s)" -lt $((end + 2)) ]; do
 done
 
 # ...and clean up after the loops in case they didn't do it themselves.
-$KILLALL_PROG -TERM xfs_io fsstress >> $seqres.full 2>&1
+# First thaw fs, so fsstress can exit, then kill and wait for fsstress.
+# Use of SIGINT instead of SIGTERM suppresses the "Terminated" print
+# from the XXX_loop() bash sub-shells
 $XFS_IO_PROG -x -c 'thaw' $SCRATCH_MNT >> $seqres.full 2>&1
+$KILLALL_PROG -w -SIGINT $XFS_IO_PROG $FSSTRESS_PROG >> $seqres.full 2>&1
 
 echo "Loop finished at $(date)" >> $seqres.full
 echo "Test done"
-- 
2.25.1

