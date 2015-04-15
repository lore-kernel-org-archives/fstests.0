Return-Path: <fstests-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:33165 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbbDONb1 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 15 Apr 2015 09:31:27 -0400
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
	Wed, 15 Apr 2015 19:01:24 +0530
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [RFC PATCH] fiemap-tester.c: Do not error out when FIEMAP_EXTENT_NOT_ALIGNED is set and extent is aligned.
Date: Wed, 15 Apr 2015 18:59:53 +0530
Message-Id: <1429104593-24136-1-git-send-email-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-fsdevel@vger.kernel.org, chandan@mykolab.com
List-ID: <fstests@vger.kernel.org>

>From Linux kernel's Documentation/filesystems/fiemap.txt,

* FIEMAP_EXTENT_NOT_ALIGNED
Extent offsets and length are not guaranteed to be block aligned.

So this means that FIEMAP_EXTENT_NOT_ALIGNED is just a hint that indicates
that the extent range could possibly be out of alignment w.r.t to the
filesystem's blocksize. It should still be possible for fiemap ioctl to return
extents with FIEMAP_EXTENT_NOT_ALIGNED flag set (e.g. Inline extents) but
which have blocksize aligned ranges.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 src/fiemap-tester.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/src/fiemap-tester.c b/src/fiemap-tester.c
index 8e633ab..74dea17 100644
--- a/src/fiemap-tester.c
+++ b/src/fiemap-tester.c
@@ -195,17 +195,6 @@ check_flags(struct fiemap *fiemap, int blocksize)
 			return -1;
 		}
 
-		if (extent->fe_flags & FIEMAP_EXTENT_NOT_ALIGNED &&
-		    aligned_offset == extent->fe_physical &&
-		    aligned_length == extent->fe_length) {
-			printf("ERROR: FIEMAP_EXTENT_NOT_ALIGNED is set but "
-			       "offset and length is blocksize aligned: "
-			       "%llu\n",
-			       (unsigned long long)
-			       (extent->fe_logical / blocksize));
-			return -1;
-		}
-
 		if (extent->fe_flags & FIEMAP_EXTENT_LAST &&
 		    c + 1 < fiemap->fm_mapped_extents) {
 			printf("ERROR: FIEMAP_EXTENT_LAST is set but there are"
-- 
2.1.0

