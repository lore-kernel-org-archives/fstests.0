From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v3] common/rc: fix fsmap check
Date: Tue, 20 Sep 2016 13:23:12 +0800
Message-ID: <1474348992-27909-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20160920044809.GB3059@birch.djwong.org>
References: <20160920044809.GB3059@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain
To: darrick.wong@oracle.com
Cc: eguan@redhat.com, fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

We don't need -T to detect GETFSMAP and the flag doesn't exist
on really old versions of xfs_io, so just get rid of it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 13afc6a..52a75c5 100644
--- a/common/rc
+++ b/common/rc
@@ -2049,8 +2049,7 @@ _require_xfs_io_command()
 			_notrun "xfs_io $command support is missing"
 		;;
 	"fsmap" )
-		testio=`$XFS_IO_PROG -T -F -c "fsmap" \
-			$TEST_DIR 2>&1`
+		testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
 		echo $testio | egrep -q "Inappropriate ioctl" && \
 			_notrun "xfs_io $command support is missing"
 		;;
-- 
1.8.3.1
