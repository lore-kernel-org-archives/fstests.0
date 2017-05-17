Received: from cn.fujitsu.com ([59.151.112.132]:45290 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750759AbdEQBmr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 May 2017 21:42:47 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2 2/2] common: cleanup _require_xfs_io_command
Date: Wed, 17 May 2017 09:42:33 +0800
Message-ID: <1494985353-13746-2-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <1494985353-13746-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170516080455.GX7250@eguan.usersys.redhat.com>
 <1494985353-13746-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: amir73il@gmail.com, fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

We don't need to check specific flags at the end of this function
if we have checked them before. e.g, generic/071 and generic/422
are marked as notrun unexpectedly because xfs_io doesn't support
long-format help for falloc before xfsprogs v4.9.  Actually, xfs_io
has supported falloc, so these case should not be marked as notrun.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 539f153..6c27dea 100644
--- a/common/rc
+++ b/common/rc
@@ -2041,6 +2041,7 @@ _require_xfs_io_command()
 	command=$1
 	shift
 	param="$*"
+	param_check=0
 
 	testfile=$TEST_DIR/$$.xfs_io
 	case $command in
@@ -2055,6 +2056,7 @@ _require_xfs_io_command()
 		;;
 	"falloc" )
 		testio=`$XFS_IO_PROG -F -f -c "falloc $param 0 1m" $testfile 2>&1`
+		param_check=1
 		;;
 	"fpunch" | "fcollapse" | "zero" | "fzero" | "finsert" | "funshare")
 		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
@@ -2063,6 +2065,7 @@ _require_xfs_io_command()
 	"fiemap")
 		testio=`$XFS_IO_PROG -F -f -c "pwrite 0 20k" -c "fsync" \
 			-c "fiemap -v $param" $testfile 2>&1`
+		param_check=1
 		;;
 	"flink" )
 		testio=`$XFS_IO_PROG -T -F -c "flink $testfile" \
@@ -2087,7 +2090,7 @@ _require_xfs_io_command()
 		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
 		;;
 	*)
-		testio=`$XFS_IO_PROG -c "$command help" 2>&1`
+		testio=`$XFS_IO_PROG -c "help $command" 2>&1`
 	esac
 
 	rm -f $testfile 2>&1 > /dev/null
@@ -2100,9 +2103,10 @@ _require_xfs_io_command()
 	echo $testio | grep -q "foreign file active" && \
 		_notrun "xfs_io $command not supported on $FSTYP"
 
-	test -z "$param" && return
-	$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
-		_notrun "xfs_io $command doesn't support $param"
+	if [ -n "$param" -a $param_check -eq 0 ]; then
+		$XFS_IO_PROG -c "help $command" | grep -q "^ $param --" || \
+			_notrun "xfs_io $command doesn't support $param"
+	fi
 }
 
 # check that kernel and filesystem support direct I/O
-- 
1.8.3.1



