Received: from mx1.redhat.com ([209.132.183.28]:55152 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833AbcE0PV0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 27 May 2016 11:21:26 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B62818111B
	for <fstests@vger.kernel.org>; Fri, 27 May 2016 15:21:25 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/2] common/rc: add functions to check or write objects under /sys/fs
Date: Fri, 27 May 2016 23:21:21 +0800
Message-Id: <1464362482-7704-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: cem@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

XFS add more configurations in /sys/fs/xfs recently. For use
them, this patch add some common functions for:
  1. "require" a file/dir in /sys/fs.
  2. write a file in /sys/fs.

For common use, these functions can be used by other filesystems.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/common/rc b/common/rc
index 51092a0..9935f08 100644
--- a/common/rc
+++ b/common/rc
@@ -3556,6 +3556,87 @@ run_fsx()
 	fi
 }
 
+_require_sys_fs()
+{
+        local dev=$1
+        local target=$2
+        local dname=""
+
+        if [ ! -b "$dev" -o -z "$target" ];then
+	        echo "Usage: _require_sys_fs <device> <target_need_exist>"
+                exit 1
+        fi
+
+        dname=$(basename $(readlink -f $dev))
+        _mkfs_dev $dev > /dev/null 2>&1
+        _mount -t $FSTYP `_common_dev_mount_options` $dev $SCRATCH_MNT
+        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
+                umount $SCRATCH_MNT
+                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
+        fi
+        umount $SCRATCH_MNT
+}
+
+_require_scratch_sys_fs()
+{
+        local target=$1
+        local dname=""
+
+        if [ ! -b "$SCRATCH_DEV" -o -z "$target" ];then
+	        echo "Usage: _require_scratch_sys_fs <target_need_exist>"
+		exit 1
+	fi
+
+        dname=$(basename $(readlink -f $SCRATCH_DEV))
+	_scratch_mkfs > /dev/null 2>&1
+        _scratch_mount
+        if [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
+                _scratch_unmount
+                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
+        fi
+        _scratch_unmount
+}
+
+_set_sys_fs_param()
+{
+        local dev=$1
+        shift
+        local target=$1
+        shift
+        local content="$*"
+
+        if [ ! -b "$dev" -o -z "$target" -o -z "$content" ];then
+                echo "Usage: _set_sys_fs_param <mounted_device> <target> <content>"
+                exit 1
+        fi
+        local dname=$(basename $(readlink -f $dev))
+        echo "$content" > /sys/fs/${FSTYP}/${dname}/$target
+}
+
+_enable_xfs_fail_at_unmount()
+{
+        local dev=$1
+
+        if [ ! -b "$dev" -o "$FSTYP" != "xfs" ];then
+                echo "Usage: _enable_xfs_fail_at_unmount <mounted_XFS_device>"
+                exit 1
+        fi
+
+        _set_sys_fs_param $dev error/fail_at_unmount 1
+}
+
+_disable_xfs_fail_at_unmount()
+{
+        local dev=$1
+
+        if [ ! -b "$dev" -o "$FSTYP" != "xfs" ];then
+                echo "Usage: _enable_xfs_fail_at_unmount <mounted_XFS_device>"
+                exit 1
+        fi
+
+        _set_sys_fs_param $dev error/fail_at_unmount 0
+}
+
 init_rc
 
 ################################################################################
-- 
2.5.5

