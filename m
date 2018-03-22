Received: from userp2130.oracle.com ([156.151.31.86]:35940 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeCVCrC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Mar 2018 22:47:02 -0400
Date: Wed, 21 Mar 2018 19:46:56 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] common/xfs: don't call xfs_scrub on a block device
Message-ID: <20180322024656.GC4810@magnolia>
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

xfs_scrub takes an xfs mountpoint as its argument, not a block device.
Therefore, fix _check_xfs_filesystem to call it correctly.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/xfs |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/xfs b/common/xfs
index 5dbd81e..1d98ba1 100644
--- a/common/xfs
+++ b/common/xfs
@@ -358,7 +358,7 @@ _check_xfs_filesystem()
 	# Run online scrub if we can.
 	mntpt="$(_is_dev_mounted $device)"
 	if [ -n "$mntpt" ] && _supports_xfs_scrub "$mntpt" "$device"; then
-		"$XFS_SCRUB_PROG" $scrubflag -v -d -n $device > $tmp.scrub 2>&1
+		"$XFS_SCRUB_PROG" $scrubflag -v -d -n $mntpt > $tmp.scrub 2>&1
 		if [ $? -ne 0 ]; then
 			_log_err "_check_xfs_filesystem: filesystem on $device failed scrub"
 			echo "*** xfs_scrub $scrubflag -v -d -n output ***" >> $seqres.full
