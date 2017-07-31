Received: from cn.fujitsu.com ([222.73.24.84]:5505 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750807AbdGaIGx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 31 Jul 2017 04:06:53 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 446F046BA941
        for <fstests@vger.kernel.org>; Mon, 31 Jul 2017 16:06:43 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] common/rc: add variable MOUNT_OPTIONS into _test_mount
Date: Mon, 31 Jul 2017 16:06:33 +0800
Message-ID: <1501488393-25924-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On RHEL6.9GA, generic/097 fails for ext4 because _test_cycle_mount()
remount ext4 without the user_xattr option, so extended attributes
are not supported by ext4.

On some old kernels, ext4 filesystem can not be mounted with acl and
user_xattr options by default.  The following patch has enabled these
options by default:
'ea6633369458("ext4: enable acls and user_xattr by default")'

We add variable MOUNT_OPTIONS into _test_mount, and it works normally
on all kernels.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index c752979..c478eeb 100644
--- a/common/rc
+++ b/common/rc
@@ -519,7 +519,7 @@ _test_mount()
         return $?
     fi
     _test_options mount
-    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _mount -t $FSTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS `_common_dev_mount_options $*` $TEST_DEV $TEST_DIR
 }
 
 _test_unmount()
-- 
1.8.3.1



