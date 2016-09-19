From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/rc: fix fsmap check
Date: Mon, 19 Sep 2016 16:26:15 +0800
Message-ID: <1474273575-9321-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, sandeen@redhat.com, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

I got an error about $TEST_DIR being a directory when xfs/273 ran, because
xfs_io tried to open the directory first before it parsed the -T options.
So fix it by checking this error.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 13afc6a..1be803b 100644
--- a/common/rc
+++ b/common/rc
@@ -2051,7 +2051,7 @@ _require_xfs_io_command()
 	"fsmap" )
 		testio=`$XFS_IO_PROG -T -F -c "fsmap" \
 			$TEST_DIR 2>&1`
-		echo $testio | egrep -q "Inappropriate ioctl" && \
+		echo $testio | egrep -q "Inappropriate ioctl|Is a directory" && \
 			_notrun "xfs_io $command support is missing"
 		;;
 	*)
-- 
1.8.3.1
