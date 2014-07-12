Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56919 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029AbaGLB6s (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 11 Jul 2014 21:58:48 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6C1wmTd006508
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Fri, 11 Jul 2014 21:58:48 -0400
Message-ID: <53C09658.2000905@redhat.com>
Date: Fri, 11 Jul 2014 20:58:48 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] xfs/291: use xfs_repair -f when repairing a fs image
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

test xfs/291 creates an xfs_metadump image and runs repair on it.
Technically, this is supposed to require "-f" to specify that
the target of the repair is a file; this allows buffered IO fallback
in the case where the image sector size is smaller than the device
sector size.  And in fact if we create the image on a hard 4k device,
the test will fail when repair is unable to operate on the image.

So add that -f!

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---


diff --git a/tests/xfs/291 b/tests/xfs/291
index 0f3f051..fbf9c51 100755
--- a/tests/xfs/291
+++ b/tests/xfs/291
@@ -122,7 +122,7 @@ _xfs_check $SCRATCH_DEV >> $seqres.full 2>&1 || _fail "xfs_check failed"
 # Can xfs_metadump cope with this monster?
 _scratch_metadump $tmp.metadump || _fail "xfs_metadump failed"
 xfs_mdrestore $tmp.metadump $tmp.img || _fail "xfs_mdrestore failed"
-xfs_repair $tmp.img >> $seqres.full 2>&1 || _fail "xfs_repair of metadump failed"
+xfs_repair -f $tmp.img >> $seqres.full 2>&1 || _fail "xfs_repair of metadump failed"
 
 # Yes it can; success, all done
 status=0

