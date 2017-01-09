Received: from bombadil.infradead.org ([198.137.202.9]:55640 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbdAINiW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 Jan 2017 08:38:22 -0500
Received: from clnet-p099-196.ikbnet.co.at ([83.175.99.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1cQa9V-0005DC-24
        for fstests@vger.kernel.org; Mon, 09 Jan 2017 13:38:21 +0000
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] generic/081: hack around the lvm unmount race
Date: Mon,  9 Jan 2017 14:38:18 +0100
Message-Id: <1483969098-16653-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This is butt ugly, but I see no better way than to wait a bit to
work around the race between the weird umount in LVM, and the mount
ismounted checks.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/081 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/generic/081 b/tests/generic/081
index 11755d4..426766d 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -35,6 +35,8 @@ _cleanup()
 	cd /
 	rm -f $tmp.*
 	# lvm may have umounted it on I/O error, but in case it does not
+	# wait a bit for lvm to settle, sigh..
+	sleep 2
 	$UMOUNT_PROG $mnt >/dev/null 2>&1
 	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
 	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
-- 
2.1.4

