Received: from bombadil.infradead.org ([198.137.202.9]:56672 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964947AbcBQKXX (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 17 Feb 2016 05:23:23 -0500
Received: from hch by bombadil.infradead.org with local (Exim 4.80.1 #2 (Red Hat Linux))
	id 1aVzGV-0004Ts-F8
	for fstests@vger.kernel.org; Wed, 17 Feb 2016 10:23:23 +0000
Date: Wed, 17 Feb 2016 02:23:23 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] fix _require_fs_space on remote file systems
Message-ID: <20160217102323.GA14703@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Remove the -l flag to df so that it works properly on NFS and co.

This fixes various failures in new COW tests on NFS.

Signed-off-by: Christoph Hellwig <hch@lst.de>

diff --git a/common/rc b/common/rc
index 6abd52d..c91a2f0 100644
--- a/common/rc
+++ b/common/rc
@@ -1906,7 +1906,7 @@ _require_fs_space()
 	BLOCKS=$2	# in units of 1024
 	let GB=$BLOCKS/1024/1024
 
-	FREE_BLOCKS=`df -klP $MNT | grep -v Filesystem | awk '{print $4}'`
+	FREE_BLOCKS=`df -kP $MNT | grep -v Filesystem | awk '{print $4}'`
 	[ $FREE_BLOCKS -lt $BLOCKS ] && \
 		_notrun "This test requires at least ${GB}GB free on $MNT to run"
 }
