Received: from mx2.suse.de ([195.135.220.15]:49670 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753034AbdK0St0 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 27 Nov 2017 13:49:26 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH 1/3] Check pwrite parameters
Date: Mon, 27 Nov 2017 12:49:18 -0600
Message-Id: <20171127184920.13864-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

There are some parameters added with xfs_io. Check if the pwrite
parameters are available. For some cases, xfs_io now returns "command
-%c not supported", so added "not supported" to count as error.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 common/rc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 4c053a53..b6778f07 100644
--- a/common/rc
+++ b/common/rc
@@ -2079,6 +2079,14 @@ _require_xfs_io_command()
 		echo $testio | grep -q "invalid option" && \
 			_notrun "xfs_io $command support is missing"
 		;;
+	"pwrite")
+		if [ "$param" == "-N" ]; then
+			opts="-d"
+		fi
+		testio=`$XFS_IO_PROG -f $opts -c "pwrite $param 0 1M" \
+			$testfile 2>&1`
+		param_checked=1
+		;;
 	"scrub"|"repair")
 		testio=`$XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR 2>&1`
 		echo $testio | grep -q "Inappropriate ioctl" && \
@@ -2109,7 +2117,7 @@ _require_xfs_io_command()
 		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
 			_notrun "xfs_io $command doesn't support $param"
 	else
-		echo $testio | grep -q "invalid option" && \
+		echo $testio | grep -q "\(invalid option\|not supported\)" && \
 			_notrun "xfs_io $command doesn't support $param"
 	fi
 }
-- 
2.14.2

