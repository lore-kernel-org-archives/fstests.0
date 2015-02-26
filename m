Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:43481 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbbBZIOt (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 03:14:49 -0500
Received: by wggy19 with SMTP id y19so8424004wgg.10
        for <fstests@vger.kernel.org>; Thu, 26 Feb 2015 00:14:48 -0800 (PST)
Message-ID: <54EED5F6.2030804@plexistor.com>
Date: Thu, 26 Feb 2015 10:14:46 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: [PATCH] brd: Re-instate ram disk visibility option (part_show)
References: <1424818479-10083-1-git-send-email-david@fromorbit.com> <1424818479-10083-2-git-send-email-david@fromorbit.com> <20150225161151.GC28053@bfoster.bfoster> <20150225223248.GH4251@dastard>
In-Reply-To: <20150225223248.GH4251@dastard>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Jens Axboe <axboe@fb.com>, Dave Chinner <david@fromorbit.com>
Cc: Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>


This re-enables part_show option, so we can keep it false by
default.

Here is what Dmitry said in the original patch:
  [aeac318] brd: add ram disk visibility option
	Currently ram disk is not visible inside /proc/partitions.
	This was done for compatibility reasons here: 53978d0a7a27.
	But some utilities expect disk presents in /proc/partitions.
	Let's add module's option and let's administrator chose
	visibility behavior. By default, old behavior preserved.

Dave Chinner and other have reported problems with current system
when udev events start firing for ramdisk:
	http://marc.info/?l=linux-fsdevel&m=142490357918672&w=2

It was me who enabled these notifications through this patch:
   [937af5e] brd: Fix all partitions BUGs
Sorry for the mess.

CC: Dave Chinner <david@fromorbit.com>
CC: Dmitry Monakhov <dmonakhov@openvz.org>
Signed-off-by: Boaz Harrosh <boaz@plexistor.com>
---
 drivers/block/brd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 64ab495..6e0775b 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -450,6 +450,10 @@ static int max_part = 1;
 module_param(max_part, int, S_IRUGO);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
+static int part_show = 0;
+module_param(part_show, int, S_IRUGO);
+MODULE_PARM_DESC(part_show, "Control RAM disk visibility in /proc/partitions");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(RAMDISK_MAJOR);
 MODULE_ALIAS("rd");
@@ -513,6 +517,8 @@ static struct brd_device *brd_alloc(int i)
 	disk->private_data	= brd;
 	disk->queue		= brd->brd_queue;
 	disk->flags		= GENHD_FL_EXT_DEVT;
+	if (!part_show)
+		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 	sprintf(disk->disk_name, "ram%d", i);
 	set_capacity(disk, rd_size * 2);
 
-- 
1.9.3

