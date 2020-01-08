Return-Path: <SRS0=wN5T=25=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB7BC00523
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jan 2020 10:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B95F206F0
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Jan 2020 10:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgAHKpR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:45:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:57696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbgAHKpQ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 8 Jan 2020 05:45:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BE216AD54;
        Wed,  8 Jan 2020 10:45:15 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     guaneryu@gmail.com
Cc:     fstests@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Correct golden output of btrfs/202
Date:   Wed,  8 Jan 2020 12:45:14 +0200
Message-Id: <20200108104514.11378-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test is merged under index 202 but the golden output contains 201.
This makes the test always fail. Correct the number.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 tests/btrfs/202.out | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/btrfs/202.out b/tests/btrfs/202.out
index 938870cf10bd..7f33d49f889c 100644
--- a/tests/btrfs/202.out
+++ b/tests/btrfs/202.out
@@ -1,4 +1,4 @@
-QA output created by 201
+QA output created by 202
 Create subvolume 'SCRATCH_MNT/a'
 Create subvolume 'SCRATCH_MNT/a/b'
 Create a snapshot of 'SCRATCH_MNT/a' in 'SCRATCH_MNT/c'
-- 
2.7.4

