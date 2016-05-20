Received: from mx1.redhat.com ([209.132.183.28]:57117 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126AbcETOAU (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 20 May 2016 10:00:20 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5D7B03C88EE
	for <fstests@vger.kernel.org>; Fri, 20 May 2016 14:00:19 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/4] common/rc: new functions for multi-level mount/umount operations
Date: Fri, 20 May 2016 22:00:11 +0800
Message-Id: <1463752814-3049-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

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
---

Hi,

I just wrote 4 patches for cover mount shared subtree test:

0001-common-rc-new-functions-for-multi-level-mount-umount.patch
0002-generic-353-new-case-for-test-mount-bind-operation.patch
0003-generic-354-new-case-for-test-mount-shared-subtrees-.patch
0004-generic-355-new-case-test-two-vfsmount-no-peers.patch

Due to I have sent two patches which taken generic/352(not reviewed),
so above new cases named from generic/353 to 355.

I will write more cases about mount shared subtrees feature, after
above 4 patches can be review and merged.

Thanks,
Zorro

 common/rc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/rc b/common/rc
index 9c532cc..c0fec02 100644
--- a/common/rc
+++ b/common/rc
@@ -162,6 +162,37 @@ _mount()
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
2.5.5

