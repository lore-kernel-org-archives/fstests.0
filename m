Received: from mail-wm0-f65.google.com ([74.125.82.65]:33515 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932103AbdHWPsv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Aug 2017 11:48:51 -0400
From: Amir Goldstein <amir73il@gmail.com>
Subject: [RFC][PATCH 1/8] common/rc: convert some egrep to grep
Date: Wed, 23 Aug 2017 18:49:10 +0300
Message-Id: <1503503357-26234-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
References: <1503503357-26234-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Josef Bacik <jbacik@fb.com>, Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 9c5f54a..9d7b783 100644
--- a/common/rc
+++ b/common/rc
@@ -2177,7 +2177,7 @@ _require_xfs_io_command()
 		;;
 	"fsmap" )
 		testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
-		echo $testio | egrep -q "Inappropriate ioctl" && \
+		echo $testio | grep -q "Inappropriate ioctl" && \
 			_notrun "xfs_io $command support is missing"
 		;;
 	"open")
@@ -2185,12 +2185,12 @@ _require_xfs_io_command()
 		# a new -C flag was introduced to execute one shot commands.
 		# Check for -C flag support as an indication for the bug fix.
 		testio=`$XFS_IO_PROG -F -f -C "open $testfile" $testfile 2>&1`
-		echo $testio | egrep -q "invalid option" && \
+		echo $testio | grep -q "invalid option" && \
 			_notrun "xfs_io $command support is missing"
 		;;
 	"scrub"|"repair")
 		testio=`$XFS_IO_PROG -x -c "$command dummy 0" $TEST_DIR 2>&1`
-		echo $testio | egrep -q "Inappropriate ioctl" && \
+		echo $testio | grep -q "Inappropriate ioctl" && \
 			_notrun "xfs_io $command support is missing"
 		;;
 	"utimes" )
@@ -2209,7 +2209,7 @@ _require_xfs_io_command()
 		_notrun "xfs_io $command failed (old kernel/wrong fs/bad args?)"
 	echo $testio | grep -q "foreign file active" && \
 		_notrun "xfs_io $command not supported on $FSTYP"
-	echo $testio | egrep -q "Function not implemented" && \
+	echo $testio | grep -q "Function not implemented" && \
 		_notrun "xfs_io $command support is missing (missing syscall?)"
 
 	if [ -n "$param" -a $param_checked -eq 0 ]; then
-- 
2.7.4

