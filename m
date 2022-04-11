Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23079C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 05:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241054AbiDKFuu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 01:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiDKFut (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 01:50:49 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 277682CE18
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 22:48:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 5A85F10CF560
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2022 15:48:35 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ndmuf-00GJpi-Ib
        for fstests@vger.kernel.org; Mon, 11 Apr 2022 15:48:33 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1ndmuf-0093L6-F4
        for fstests@vger.kernel.org;
        Mon, 11 Apr 2022 15:48:33 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] generic/019: kill background processes on interrupt
Date:   Mon, 11 Apr 2022 15:48:33 +1000
Message-Id: <20220411054833.2157779-1-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6253c133
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=z0gMJWrwH1QA:10 a=20KFwNOVAAAA:8 a=8RvmjFLgqzaQPqdsMh0A:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

If you ctrl-c generic/019, it leaves fsstress processes running.
Kill them in the cleanup function so that they don't have to be
manually killed after interrupting the test.

While touching the _cleanup() function, make it do everything that
the generic _cleanup function it overrides does and fix the
indenting.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/019 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/019 b/tests/generic/019
index db56dac1..cda107f4 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -53,8 +53,10 @@ stop_fail_scratch_dev()
 # Override the default cleanup function.
 _cleanup()
 {
-    disallow_fail_make_request
-    rm -f $tmp.*
+	kill $fs_pid $fio_pid &> /dev/null
+	disallow_fail_make_request
+	cd /
+	rm -r -f $tmp.*
 }
 
 RUN_TIME=$((20+10*$TIME_FACTOR))
-- 
2.35.1

