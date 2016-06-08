Received: from bombadil.infradead.org ([198.137.202.9]:51409 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161084AbcFHSRi (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 8 Jun 2016 14:17:38 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] xfstests: fix unreferenced variables in generic/186 and generic/187
Date: Wed,  8 Jun 2016 20:17:31 +0200
Message-Id: <1465409851-27969-2-git-send-email-hch@lst.de>
In-Reply-To: <1465409851-27969-1-git-send-email-hch@lst.de>
References: <1465409851-27969-1-git-send-email-hch@lst.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

There is not i variable in scope, and the comments suggest the operation
is to be done on ${file}.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/186 | 2 +-
 tests/generic/187 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/186 b/tests/generic/186
index 70a0280..5de120a 100755
--- a/tests/generic/186
+++ b/tests/generic/186
@@ -87,7 +87,7 @@ _fragment_freesp()
 
 	# Try again anyway
 	avail=`_get_available_space $SCRATCH_MNT`
-	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}.${i}
+	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}
 
 	# Punch out whatever we need
 	seq 1 $((nr * 4)) | while read f; do
diff --git a/tests/generic/187 b/tests/generic/187
index 25cbcd9..3f534c8 100755
--- a/tests/generic/187
+++ b/tests/generic/187
@@ -88,7 +88,7 @@ _fragment_freesp()
 
 	# Try again anyway
 	avail=`_get_available_space $SCRATCH_MNT`
-	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}.${i}
+	$XFS_IO_PROG -fc "pwrite -S 0x65 0 $avail" ${file}
 
 	# Punch out whatever we need
 	seq 1 $((nr * 4)) | while read f; do
-- 
2.1.4

