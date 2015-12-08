Received: from mail.kernel.org ([198.145.29.136]:58475 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbbLHARA (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 7 Dec 2015 19:17:00 -0500
Date: Mon, 7 Dec 2015 16:16:58 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3 v2] common/rc: support f2fs for _scratch_mkfs_sized
Message-ID: <20151208001658.GA93139@jaegeuk.local>
References: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1449267345-79400-1-git-send-email-jaegeuk@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-ID: <fstests@vger.kernel.org>

Change log from v1:
 o adjust different sector sizes

-- >8 --
>From 5b2c77d3acaf11bac5489ec697c2ec53f261afeb Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Fri, 20 Mar 2015 15:37:10 -0700
Subject: [PATCH] common/rc: support f2fs for _scratch_mkfs_sized

The mkfs.f2fs has an option to build a certain sized filesystem by giving
the number of sectors.

So, this patch adds to use that.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 common/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/rc b/common/rc
index 4c2f42c..b25d173 100644
--- a/common/rc
+++ b/common/rc
@@ -739,6 +739,11 @@ _scratch_mkfs_sized()
 	$MKFS_REISER4_PROG $MKFS_OPTIONS -y -b $blocksize $SCRATCH_DEV \
 			   `expr $fssize / 1024`
 	;;
+    f2fs)
+	# mkfs.f2fs requires # of sectors as an input for the size
+	sector_size=`blockdev --getss $SCRATCH_DEV`
+	$MKFS_F2FS_PROG $MKFS_OPTIONS $SCRATCH_DEV `expr $fssize / $sector_size`
+	;;
     *)
 	_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
 	;;
-- 
2.4.9 (Apple Git-60)

