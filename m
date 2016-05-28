Received: from mx1.redhat.com ([209.132.183.28]:47835 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738AbcE1R2h (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 28 May 2016 13:28:37 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6A8C37F095
	for <fstests@vger.kernel.org>; Sat, 28 May 2016 17:28:36 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2 1/2] common/rc: add functions to check or write objects under /sys/fs/$FSTYP
Date: Sun, 29 May 2016 01:28:32 +0800
Message-Id: <1464456513-11179-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

XFS add more configurations in /sys/fs/xfs recently. For use
them, this patch add some common functions for:
  1. "require" a file/dir in /sys/fs/${FSTYP}.
  2. write a file in /sys/fs/${FSTYP}.

For common use, these functions can be used by other filesystems.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

This V2 patch follow Eric's suggestions:
1. remove useless functions: _require_scratch_sys_fs(),
   _enable_xfs_fail_at_unmount() and _disable_xfs_fail_at_unmount().
2. change _require_sys_fs() to _require_fs_sys_fs().
3. change _set_sys_fs_param() to _set_fs_sys_fs_param().
4. Don't mkfs in _require_fs_sys_fs().
5. use a tmp mnt dir to instead of SCRATCH_MNT in _require_fs_sys_fs().

Thanks,
Zorro

 common/rc | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/common/rc b/common/rc
index 51092a0..04bd140 100644
--- a/common/rc
+++ b/common/rc
@@ -3556,6 +3556,50 @@ run_fsx()
 	fi
 }
 
+_require_fs_sys_fs()
+{
+        local dev=$1
+        local target=$2
+        local dname=""
+	local tmp_mnt=`mktemp -d`
+
+        if [ ! -b "$dev" -o -z "$target" ];then
+	        echo "Usage: _require_fs_sys_fs <device> <sysfs_path>"
+                exit 1
+        fi
+
+	dname=`readlink -f $dev`
+	dname=`basename $dname`
+        _mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
+	if [ $? -ne 0 ];then
+		rm -f $tmp_mnt
+		echo "could not mount; mkfs first in your test?"
+		exit 1
+        elif [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
+                umount $tmp_mnt
+		rm -f $tmp_mnt
+                _notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
+        fi
+        umount $tmp_mnt
+	rm -rf $tmp_mnt
+}
+
+_set_fs_sys_fs_param()
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
 init_rc
 
 ################################################################################
-- 
2.5.5

