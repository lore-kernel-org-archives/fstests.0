Received: from mx1.redhat.com ([209.132.183.28]:42728 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309AbbLDPlt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 10:41:49 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id D277EC04FF81
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 15:41:49 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB4FfmdZ007578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 4 Dec 2015 10:41:49 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] xfs/259 - inherit $_fs_has_crcs
Date: Fri, 04 Dec 2015 10:41:48 -0500
Message-ID: <x494mfy5igz.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

When running xfs/259 against a file system that has crcs disabled, the
test will fail.  The problem is that mkfs.xfs now defaults to enabling
crcs.  So, when the test checks the underlying file system and finds
crcs are disabled, it tries to create a file system with a block size
that is too small to support them.  The solution is to explicitly
specify the crc feature.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/tests/xfs/259 b/tests/xfs/259
index 16c1935..e0022ce 100755
--- a/tests/xfs/259
+++ b/tests/xfs/259
@@ -72,7 +72,7 @@ for del in $sizes_to_check; do
 	lofile=$(losetup -f)
 	losetup $lofile "$testfile"
 	"$MKFS_XFS_PROG" -l size=32m -b size=$blocksize $lofile \
-					>/dev/null || echo "mkfs failed!"
+			 -m crc=$_fs_has_crcs>/dev/null || echo "mkfs failed!"
 	sync
 	losetup -d $lofile
 done
