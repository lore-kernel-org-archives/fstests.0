Received: from bombadil.infradead.org ([198.137.202.9]:57275 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcHAJDA (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 1 Aug 2016 05:03:00 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] generic/095: update warning whitelist
Date: Mon,  1 Aug 2016 11:02:56 +0200
Message-Id: <1470042176-31447-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

The recent direct I/O path refactor changed the function name in the
racing read case.  Update the test case to handle the new name in
addition to the old one.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/095 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/095 b/tests/generic/095
index c656ef1..4754992 100755
--- a/tests/generic/095
+++ b/tests/generic/095
@@ -125,9 +125,11 @@ $FIO_PROG $fio_config >>$seqres.full 2>&1
 filter_xfs_dmesg()
 {
 	local warn1="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_write.*"
-	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
+	local warn2="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_dio_aio_read.*"
+	local warn3="WARNING:.*fs/xfs/xfs_file\.c:.*xfs_file_read_iter.*"
 	sed -e "s#$warn1#Intentional warnings in xfs_file_dio_aio_write#" \
-	    -e "s#$warn2#Intentional warnings in xfs_file_read_iter#"
+	    -e "s#$warn2#Intentional warnings in xfs_file_dio_aio_read#" \
+	    -e "s#$warn3#Intentional warnings in xfs_file_read_iter#"
 }
 
 # umount before checking dmesg in case umount triggers any WARNING or Oops
-- 
2.1.4

