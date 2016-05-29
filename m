Received: from mx1.redhat.com ([209.132.183.28]:37708 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830AbcE2E2p (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 29 May 2016 00:28:45 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCCBC8E3E6
	for <fstests@vger.kernel.org>; Sun, 29 May 2016 04:28:44 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v3 1/2] common/rc: add functions to check or write objects under /sys/fs/$FSTYP
Date: Sun, 29 May 2016 12:28:40 +0800
Message-Id: <1464496121-6380-1-git-send-email-zlang@redhat.com>
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

V3 revert dname=$(basename $(readlink -f $dev)) line.

I think we don't need to check if /sys/fs/${FSTYP}/${dname}/$target
is exist in _set_fs_sys_fs_param(). Because if no this file,
*echo* will report error, and it will disturb golden file.

Thanks,
Zorro

 common/rc | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/common/rc b/common/rc
index 51092a0..759ec30 100644
--- a/common/rc
+++ b/common/rc
@@ -3556,6 +3556,46 @@ run_fsx()
 	fi
 }
 
+_require_fs_sys_fs()
+{
+	local dev=$1
+	local target=$2
+	local tmp_mnt=`mktemp -d`
+
+	if [ ! -b "$dev" -o -z "$target" ];then
+		_fail "Usage: _require_fs_sys_fs <device> <sysfs_path>"
+        fi
+
+	local dname=$(basename $(readlink -f $dev))
+	_mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
+	if [ $? -ne 0 ];then
+		rm -f $tmp_mnt
+		_fail "could not mount; mkfs first in your test?"
+	elif [ ! -e /sys/fs/${FSTYP}/${dname}/$target ];then
+		umount $tmp_mnt
+		rm -f $tmp_mnt
+		_notrun "/sys/fs/${FSTYP}/${dname}/$target: No such file or directory"
+	fi
+	umount $tmp_mnt
+	rm -rf $tmp_mnt
+}
+
+_set_fs_sys_fs_param()
+{
+	local dev=$1
+	shift
+	local target=$1
+	shift
+	local content="$*"
+
+	if [ ! -b "$dev" -o -z "$target" -o -z "$content" ];then
+		_fail "Usage: _set_sys_fs_param <mounted_device> <target> <content>"
+	fi
+
+	local dname=$(basename $(readlink -f $dev))
+	echo "$content" > /sys/fs/${FSTYP}/${dname}/$target
+}
+
 init_rc
 
 ################################################################################
-- 
2.5.5

