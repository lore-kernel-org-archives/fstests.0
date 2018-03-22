Received: from userp2120.oracle.com ([156.151.31.85]:42804 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeCVCsS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Mar 2018 22:48:18 -0400
Date: Wed, 21 Mar 2018 19:48:09 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] common/xfs: fix various problems with _supports_xfs_scrub
Message-ID: <20180322024809.GD4810@magnolia>
References: <20180321165716.GB4818@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321165716.GB4818@magnolia>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: david@fromorbit.com, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

The _supports_xfs_scrub helper is called with a mountpoint (a working
mountpoint is required for scrub) and a block device (used to detect
norecovery mounts).  If either of these conditions aren't satisfied we
should return failure status to the caller, not unilaterally decide to
bail out of the test.  In particular, the -b test doesn't work if the
fs has already shutdown on us.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/xfs |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/common/xfs b/common/xfs
index 1d98ba1..3b71e02 100644
--- a/common/xfs
+++ b/common/xfs
@@ -305,9 +305,13 @@ _supports_xfs_scrub()
 	local mountpoint="$1"
 	local device="$2"
 
-	if [ ! -b "$device" ] || [ ! -e "$mountpoint" ]; then
+	if [ -z "$device" ] || [ -z "$mountpoint" ]; then
 		echo "Usage: _supports_xfs_scrub mountpoint device"
-		exit 1
+		return 1
+	fi
+
+	if [ ! -b "$device" ] || [ ! -e "$mountpoint" ]; then
+		return 1
 	fi
 
 	test "$FSTYP" = "xfs" || return 1
