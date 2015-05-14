Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49207 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933362AbbENPcd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 May 2015 11:32:33 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4EFWXaP029691
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 14 May 2015 11:32:33 -0400
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4EFWWuB010176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Thu, 14 May 2015 11:32:32 -0400
Message-ID: <5554C010.7020300@redhat.com>
Date: Thu, 14 May 2015 10:32:32 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] xfs/032: properly test for corruption from xfs_copy
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

>From the xfs_repair manpage:

    xfs_repair run without the -n option will always return
    a status code of 0.

So we must use "-n" to detect corruption in this test.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
	

diff --git a/tests/xfs/032 b/tests/xfs/032
index 60c4662..a3fb89f 100755
--- a/tests/xfs/032
+++ b/tests/xfs/032
@@ -68,7 +68,8 @@ while [ $SECTORSIZE -le $PAGESIZE ]; do
 
 		$XFS_COPY_PROG -d $SCRATCH_DEV $IMGFILE >> $seqres.full 2>&1 || \
 			_fail "Copy failed for Sector size $SECTORSIZE Block size $BLOCKSIZE"
-		$XFS_REPAIR_PROG $IMGFILE >> $seqres.full 2>&1 || \
+		# Must use "-n" to get exit code; without it xfs_repair always returns 0
+		$XFS_REPAIR_PROG -n $IMGFILE >> $seqres.full 2>&1 || \
 			_fail "Copy corrupted for Sector size $SECTORSIZE Block size $BLOCKSIZE"
 
 		BLOCKSIZE=$(($BLOCKSIZE * 2));

