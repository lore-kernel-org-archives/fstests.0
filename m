Received: from cn.fujitsu.com ([59.151.112.132]:5984 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752487AbcITDUf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Sep 2016 23:20:35 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/rc: fix fsmap check
Date: Tue, 20 Sep 2016 11:15:39 +0800
Message-ID: <1474341339-22956-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160920030332.GD10172@birch.djwong.org>
References: <20160920030332.GD10172@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, darrick.wong@oracle.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

I got an error about $TEST_DIR being a directory when running xfs/273,
because xfs_io tried to open the directory first before it parsed the -T
options.  I get rid of -T to fix it because getfsmap doesn't care if it's
run against a file or a directory.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 13afc6a..ec5d73e 100644
--- a/common/rc
+++ b/common/rc
@@ -2049,7 +2049,7 @@ _require_xfs_io_command()
 			_notrun "xfs_io $command support is missing"
 		;;
 	"fsmap" )
-		testio=`$XFS_IO_PROG -T -F -c "fsmap" \
+		testio=`$XFS_IO_PROG -F -c "fsmap" \
 			$TEST_DIR 2>&1`
 		echo $testio | egrep -q "Inappropriate ioctl" && \
 			_notrun "xfs_io $command support is missing"
-- 
1.8.3.1



