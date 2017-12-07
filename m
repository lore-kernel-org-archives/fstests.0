Received: from mx2.suse.de ([195.135.220.15]:51139 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932988AbdLGQAw (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Dec 2017 11:00:52 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Subject: [PATCH v4 1/3] Check pwrite parameters
Date: Thu,  7 Dec 2017 10:00:42 -0600
Message-Id: <20171207160044.8913-1-rgoldwyn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, darrick.wong@oracle.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

There are some parameters added with xfs_io. Check if the pwrite
parameters are available. For some cases, xfs_io now returns "command
-%c not supported", so added "not supported" to count as error.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Changes since v3:
 - pwrite -N check to add -V parameters to check on pwritev2()

---
 common/rc | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 4c053a53..4f4b9e10 100644
--- a/common/rc
+++ b/common/rc
@@ -2035,6 +2035,7 @@ _require_xfs_io_command()
 	shift
 	local param="$*"
 	local param_checked=0
+	local opts=""
 
 	testfile=$TEST_DIR/$$.xfs_io
 	case $command in
@@ -2079,6 +2080,17 @@ _require_xfs_io_command()
 		echo $testio | grep -q "invalid option" && \
 			_notrun "xfs_io $command support is missing"
 		;;
+	"pwrite")
+		# -N (RWF_NOWAIT) only works with direct I/O writes
+		local pwrite_opts=" "
+		if [ "$param" == "-N" ]; then
+			opts+=" -d"
+			pwrite_opts+="-V 1 -b 4k"
+		fi
+		testio=`$XFS_IO_PROG -f $opts -c \
+		        "pwrite $pwrite_opts $param 0 4k" $testfile 2>&1`
+		param_checked=1
+		;;
 	"scrub"|"repair")
 		testio=`$XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR 2>&1`
 		echo $testio | grep -q "Inappropriate ioctl" && \
@@ -2109,7 +2121,9 @@ _require_xfs_io_command()
 		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
 			_notrun "xfs_io $command doesn't support $param"
 	else
-		echo $testio | grep -q "invalid option" && \
+		# xfs_io could result in "command %c not supported" if it was
+		# built on kernels not supporting pwritev2() calls
+		echo $testio | grep -q "\(invalid option\|not supported\)" && \
 			_notrun "xfs_io $command doesn't support $param"
 	fi
 }
-- 
2.14.2

