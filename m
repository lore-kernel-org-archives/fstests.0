Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15156C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 07:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiEXHeT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 03:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiEXHeR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 03:34:17 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D97FE6AA5C
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 00:34:16 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6FEB410E6999
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 17:34:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-00FkV9-D7
        for fstests@vger.kernel.org; Tue, 24 May 2022 17:34:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ntP3V-008A5n-Bn
        for fstests@vger.kernel.org;
        Tue, 24 May 2022 17:34:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/8] generic/038: kill background threads on interrupt
Date:   Tue, 24 May 2022 17:34:04 +1000
Message-Id: <20220524073411.1943480-2-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220524073411.1943480-1-david@fromorbit.com>
References: <20220524073411.1943480-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=628c8a76
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=MlRuX_47ZaTdqfiRnIwA:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

When I ctrl-c g/038, it either does nothing or it leaves processes
running in the background. It is not cleaning up it's background
processes correctly, so add kill vectors into the cleanup. Make sure
we only kill in the cleanup trap if the background processes are
running.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/038 | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tests/generic/038 b/tests/generic/038
index c6cea94e..0462ea13 100755
--- a/tests/generic/038
+++ b/tests/generic/038
@@ -36,6 +36,10 @@ _begin_fstest auto stress trim
 # Override the default cleanup function.
 _cleanup()
 {
+	[ -n "${create_pids}" ] && kill ${create_pids[@]}
+	[ -n "${fallocate_pids}" ] && kill ${fallocate_pids[@]}
+	[ -n "${trim_pids}" ] && kill ${trim_pids[@]}
+	wait
 	rm -fr $tmp
 }
 
@@ -47,6 +51,8 @@ _supported_fs generic
 _require_scratch
 _require_xfs_io_command "falloc"
 
+echo "Silence is golden"
+
 # Keep allocating and deallocating 1G of data space with the goal of creating
 # and deleting 1 block group constantly. The intention is to race with the
 # fstrim loop below.
@@ -121,6 +127,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT $((10 * 1024 * 1024))
 _require_batched_discard $SCRATCH_MNT
 
+
 for ((i = 0; i < $((4 * $LOAD_FACTOR)); i++)); do
 	trim_loop &
 	trim_pids[$i]=$!
@@ -136,12 +143,9 @@ create_files "foobar"
 kill ${fallocate_pids[@]}
 kill ${trim_pids[@]}
 wait
+unset create_pids
+unset fallocate_pids
+unset trim_pids
 
-# The fstests framework will now check for fs consistency with fsck.
-# The trimming was racy and caused some btree nodes to get full of zeroes on
-# disk, which obviously caused fs metadata corruption. The race often lead
-# to missing free space entries in a block group's free space cache too.
-
-echo "Silence is golden"
 status=0
 exit
-- 
2.35.1

