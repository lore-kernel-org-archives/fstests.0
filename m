Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726552AbeILPTq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 12 Sep 2018 11:19:46 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5A3E804BCF4
        for <fstests@vger.kernel.org>; Wed, 12 Sep 2018 10:15:54 +0000 (UTC)
Received: from dhcp-12-136.nay.redhat.com (unknown [10.66.12.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC10010EE6D7
        for <fstests@vger.kernel.org>; Wed, 12 Sep 2018 10:15:53 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] shared/010: avoid dedupe testing blocked on large fs
Date: Wed, 12 Sep 2018 18:15:47 +0800
Message-Id: <20180912101547.28835-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When test on large fs (--large-fs), xfstests preallocates a large
file in SCRATCH_MNT/ at first. Duperemove will take too long time
to deal with that large file (many days on 500T XFS). So move
working directory to a sub-dir underlying $SCRATCH_MNT/.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

Besides fix this issue, this patch fix another issue passingly. I left
a bad variable named "testdir" in this case. This patch can fix it.

If maintainer feels I should fix it in another patch, please tell me:-P

Thanks,
Zorro

 tests/shared/010 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/shared/010 b/tests/shared/010
index 1817081b..04f55890 100755
--- a/tests/shared/010
+++ b/tests/shared/010
@@ -65,15 +65,17 @@ function end_test()
 sleep_time=$((50 * TIME_FACTOR))
 
 # Start fsstress
+testdir="$SCRATCH_MNT/dir"
+mkdir $testdir
 fsstress_opts="-r -n 1000 -p $((5 * LOAD_FACTOR))"
-$FSSTRESS_PROG $fsstress_opts -d $SCRATCH_MNT -l 0 >> $seqres.full 2>&1 &
+$FSSTRESS_PROG $fsstress_opts -d $testdir -l 0 >> $seqres.full 2>&1 &
 dedup_pids=""
 dupe_run=$TEST_DIR/${seq}-running
 # Start several dedupe processes on same directory
 touch $dupe_run
 for ((i = 0; i < $((2 * LOAD_FACTOR)); i++)); do
 	while [ -e $dupe_run ]; do
-		$DUPEREMOVE_PROG -dr --dedupe-options=same $SCRATCH_MNT/ \
+		$DUPEREMOVE_PROG -dr --dedupe-options=same $testdir \
 			>>$seqres.full 2>&1
 	done &
 	dedup_pids="$! $dedup_pids"
-- 
2.14.4
