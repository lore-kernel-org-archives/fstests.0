Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:41768 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbBZIlt (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 03:41:49 -0500
Received: by wghl18 with SMTP id l18so8567210wgh.8
        for <fstests@vger.kernel.org>; Thu, 26 Feb 2015 00:41:48 -0800 (PST)
Message-ID: <54EEDC4A.8090000@plexistor.com>
Date: Thu, 26 Feb 2015 10:41:46 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: [PATCH] brd: Only request 4K sectors if DAX is enabled
References: <1424818479-10083-1-git-send-email-david@fromorbit.com> <1424818479-10083-2-git-send-email-david@fromorbit.com> <20150225161151.GC28053@bfoster.bfoster> <20150225223248.GH4251@dastard> <54EED5F6.2030804@plexistor.com>
In-Reply-To: <54EED5F6.2030804@plexistor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jens Axboe <axboe@fb.com>, Dave Chinner <david@fromorbit.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


People systems have been using ramdisk with
smaller-than-page-size blocks in their mkfs.

The 4K sectors is only important if we will be
using brd with a DAX filesystem.

So only enable 4K sectors if DAX is configured

Signed-off-by: Boaz Harrosh <boaz@plexistor.com>
---
 drivers/block/brd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 6e0775b..e875f12 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -495,6 +495,7 @@ static struct brd_device *brd_alloc(int i)
 	blk_queue_max_hw_sectors(brd->brd_queue, 1024);
 	blk_queue_bounce_limit(brd->brd_queue, BLK_BOUNCE_ANY);
 
+#ifdef CONFIG_BLK_DEV_RAM_DAX
 	/* This is so fdisk will align partitions on 4k, because of
 	 * direct_access API needing 4k alignment, returning a PFN
 	 * (This is only a problem on very small devices <= 4M,
@@ -502,6 +503,7 @@ static struct brd_device *brd_alloc(int i)
 	 *  is harmless)
 	 */
 	blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);
+#endif
 
 	brd->brd_queue->limits.discard_granularity = PAGE_SIZE;
 	brd->brd_queue->limits.max_discard_sectors = UINT_MAX;
-- 
1.9.3

