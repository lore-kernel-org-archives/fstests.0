Received: from userp2120.oracle.com ([156.151.31.85]:50986 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753040AbeDKQIN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Apr 2018 12:08:13 -0400
Date: Wed, 11 Apr 2018 09:08:09 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] xfs/187: fix ftype brokenness
Message-ID: <20180411160809.GA13697@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

This test requires XFS_SB_VERSION_MOREBITSBIT to be zero.  ftype (which
is now enabled by default) causes this to be set, so detect it in mkfs
and disable it.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/187 |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/xfs/187 b/tests/xfs/187
index 07ef3ae..e1a8ce9 100755
--- a/tests/xfs/187
+++ b/tests/xfs/187
@@ -70,8 +70,14 @@ export MOUNT_OPTIONS=""
 # lazysb, attr2 and other feature bits are held in features2 and will require
 # morebitsbit on So test with lazysb and without it to see if the morebitsbit is
 # okay etc. If the mkfs defaults change, these need to change as well.
-export MKFS_NO_LAZY="-m crc=0 -l lazy-count=0 -i projid32bit=0"
-export MKFS_LAZY="-m crc=0 -l lazy-count=1 -i projid32bit=0"
+MKFS_NO_LAZY="-m crc=0 -l lazy-count=0 -i projid32bit=0"
+MKFS_LAZY="-m crc=0 -l lazy-count=1 -i projid32bit=0"
+
+# Detect ftype
+if _scratch_mkfs --help 2>&1 | grep -q "ftype="; then
+	MKFS_NO_LAZY="$MKFS_NO_LAZY -n ftype=0"
+	MKFS_LAZY="$MKFS_LAZY -n ftype=0"
+fi
 
 # Make sure that when we think we are testing with morebits off
 # that we really are.
