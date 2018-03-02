Received: from szxga04-in.huawei.com ([45.249.212.190]:5696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1426154AbeCBKIZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 2 Mar 2018 05:08:25 -0500
From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH] test-appliance: fix lack of "-o" in F2FS_MOUNT_OPTIONS
Date: Fri, 2 Mar 2018 18:08:05 +0800
Message-ID: <20180302100805.22863-1-shengyong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com, ebiggers@google.com, tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

If F2FS_MOUNT_OPTIONS is set, while MNTOPTS is not set, "-o" is
missing in F2FS_MOUNT_OPTIONS. As a result, mount filesystem
will fail.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 kvm-xfstests/test-appliance/files/root/fs/f2fs/config | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
index 45fb2dd..14d5d6e 100644
--- a/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
+++ b/kvm-xfstests/test-appliance/files/root/fs/f2fs/config
@@ -30,9 +30,12 @@ function setup_mount_opts()
 	if test -n "$F2FS_MOUNT_OPTIONS" ; then
 	    export F2FS_MOUNT_OPTIONS="$F2FS_MOUNT_OPTIONS,$MNTOPTS"
 	else
-	    export F2FS_MOUNT_OPTIONS="-o $MNTOPTS"
+	    export F2FS_MOUNT_OPTIONS="$MNTOPTS"
 	fi
     fi
+    if test -n "$F2FS_MOUNT_OPTIONS" ; then
+        export F2FS_MOUNT_OPTIONS="-o $F2FS_MOUNT_OPTIONS"
+    fi
 }
 
 function get_mkfs_opts()
-- 
2.14.1

