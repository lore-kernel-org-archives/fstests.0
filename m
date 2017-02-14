Received: from imap.thunk.org ([74.207.234.97]:36762 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751477AbdBNAzx (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 13 Feb 2017 19:55:53 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/4] common/rc: new functions for multi-level mount/umount operations
Date: Mon, 13 Feb 2017 19:55:42 -0500
Message-Id: <20170214005545.29373-2-tytso@mit.edu>
In-Reply-To: <20170214005545.29373-1-tytso@mit.edu>
References: <20170214005545.29373-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

From: Zorro Lang <zlang@redhat.com>

When I try to write cases about mount shared subtrees test, I find
I always need to do many mount operations, then then umount those
mount point one by one.

For make the code clear, I use a stack to save mounted points
sequentially, then I write 3 common functions to operate this
stack.

1. The global stack named MOUNTED_POINT_STACK
2. _get_mount() accept mount parameters likes _mount(), but the
   mountpoint parameter must be the last one. It will run the
   mount operation and push the mountpoint name into stack.
3. _put_mount() don't need any parameters. It will pull the newest
   mountpoint name from the stack, and umount it.
4. _clear_mount_stack() don't need any parameters either. It will
   umount all mountpoints in the stack sequentially, and set
   MOUNTED_POINT_STACK=""

Generally, the _clear_mount_stack() function also can be used as
_init_mount_stack() at the beginning of a case. Because it will
prepare an empty stack.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/rc b/common/rc
index 2f4778f4..0771a06a 100644
--- a/common/rc
+++ b/common/rc
@@ -160,6 +160,37 @@ _mount()
     $MOUNT_PROG `_mount_ops_filter $*`
 }
 
+# the mount point must be the last parameter
+_get_mount()
+{
+    local mnt_point=${!#}
+
+    _mount $*
+    if [ $? -eq 0 ];then
+	MOUNTED_POINT_STACK=`echo "$mnt_point $MOUNTED_POINT_STACK"`
+    else
+	return 1
+    fi
+}
+
+_put_mount()
+{
+    local last_mnt=`echo $MOUNTED_POINT_STACK | awk '{print $1}'`
+
+    if [ -n "$last_mnt" ];then
+	umount $last_mnt
+    fi
+    MOUNTED_POINT_STACK=`echo $MOUNTED_POINT_STACK | cut -d\  -f2-`
+}
+
+_clear_mount_stack()
+{
+    if [ -n "$MOUNTED_POINT_STACK" ];then
+	umount $MOUNTED_POINT_STACK
+    fi
+    MOUNTED_POINT_STACK=""
+}
+
 _scratch_options()
 {
     type=$1
-- 
2.11.0.rc0.7.gbe5a750

