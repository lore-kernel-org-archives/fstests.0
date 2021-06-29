Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398F2C11F64
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Jun 2021 00:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 110DB61CE7
	for <linux-fstests@archiver.kernel.org>; Tue, 29 Jun 2021 00:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhF2A5a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Jun 2021 20:57:30 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:52208 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230090AbhF2A5a (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Jun 2021 20:57:30 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 0C5091044A19
        for <fstests@vger.kernel.org>; Tue, 29 Jun 2021 10:55:02 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ly21k-000ZZf-Dy
        for fstests@vger.kernel.org; Tue, 29 Jun 2021 10:55:00 +1000
Received: from dave by discord.disaster.area with local (Exim 4.94)
        (envelope-from <david@fromorbit.com>)
        id 1ly21k-00755P-6W
        for fstests@vger.kernel.org; Tue, 29 Jun 2021 10:55:00 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH] fstests: fix g/019 cleanup
Date:   Tue, 29 Jun 2021 10:55:00 +1000
Message-Id: <20210629005500.1687804-1-david@fromorbit.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=r6YtysWOX24A:10 a=20KFwNOVAAAA:8 a=hMN_u7TMNltKi7z9Vr4A:9
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

This never worked properly and the failure was exposed by the recent
rework of the fstest setup infrastructure.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/generic/019 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/generic/019 b/tests/generic/019
index 640c96ae..bd234815 100755
--- a/tests/generic/019
+++ b/tests/generic/019
@@ -53,7 +53,6 @@ stop_fail_scratch_dev()
 # Override the default cleanup function.
 _cleanup()
 {
-    poweron_scratch_dev
     disallow_fail_make_request
     rm -f $tmp.*
 }
@@ -156,5 +155,4 @@ _scratch_mount
 allow_fail_make_request
 _workout
 status=$?
-disallow_fail_make_request
 exit
-- 
2.31.1

