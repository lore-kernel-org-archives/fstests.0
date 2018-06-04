Received: from mail.cn.fujitsu.com ([183.91.158.132]:37700 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751273AbeFDFCS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Jun 2018 01:02:18 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/rc: Fix _require_xfs_io_command for scrub probe
Date: Mon, 4 Jun 2018 12:50:12 +0800
Message-ID: <1528087812-24372-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20180604045436.GN6581@desktop>
References: <20180604045436.GN6581@desktop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com, darrick.wong@oracle.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Currently, xfs_io scrub command doesn't allow the probe function
to have any parameter, so we remove the invalid parameter.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 9273ff7..dadbed4 100644
--- a/common/rc
+++ b/common/rc
@@ -2148,7 +2148,7 @@ _require_xfs_io_command()
 		param_checked=1
 		;;
 	"scrub"|"repair")
-		testio=`$XFS_IO_PROG -x -c "$command probe 0" $TEST_DIR 2>&1`
+		testio=`$XFS_IO_PROG -x -c "$command probe" $TEST_DIR 2>&1`
 		echo $testio | grep -q "Inappropriate ioctl" && \
 			_notrun "xfs_io $command support is missing"
 		;;
-- 
1.8.3.1



