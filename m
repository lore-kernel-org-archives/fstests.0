Received: from mx1.redhat.com ([209.132.183.28]:46754 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbcFTNdy (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 20 Jun 2016 09:33:54 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3011AC05B1C5
	for <fstests@vger.kernel.org>; Mon, 20 Jun 2016 13:24:36 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v4 1/2] common/rc: add functions to check or write objects under /sys/fs/$FSTYP
Date: Mon, 20 Jun 2016 21:24:32 +0800
Message-Id: <1466429073-10124-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@redhat.com, eguan@redhat.com, cem@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

XFS add more configurations in /sys/fs/xfs recently. For use
them, this patch add some common functions for:
  1. "require" a file/dir in /sys/fs/${FSTYP}.
  2. write a file in /sys/fs/${FSTYP}.

For common use, these functions can be used by other filesystems.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V4 did below changes:
1) function name from *_fs_sys_fs to *_fs_sysfs
2) use $UMOUNT_PROG to instead of umount
3) use _short_dev
4) add comments for new functions
5) other little changes

Thanks,
Zorro

 common/rc | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/common/rc b/common/rc
index 51092a0..88c3777 100644
--- a/common/rc
+++ b/common/rc
@@ -3556,6 +3556,48 @@ run_fsx()
 	fi
 }
 
+# Test for the existence of a sysfs entry at /sys/fs/$FSTYP/$DEV/$ENTRY
+_require_fs_sysfs()
+{
+	local dev=$1
+	local entry=$2
+	local tmp_mnt=`mktemp -d`
+
+	if [ ! -b "$dev" -o -z "$entry" ];then
+		_fail "Usage: _require_fs_sysfs <device> <sysfs_path>"
+        fi
+
+	local dname=$(_short_dev $dev)
+	_mount -t $FSTYP `_common_dev_mount_options` $dev $tmp_mnt
+	if [ $? -ne 0 ];then
+		rm -f $tmp_mnt
+		_fail "_require_fs_sysfs: could not mount, mkfs first in your test?"
+	elif [ ! -e /sys/fs/${FSTYP}/${dname}/${entry} ];then
+		$UMOUNT_PROG $tmp_mnt
+		rm -f $tmp_mnt
+		_notrun "/sys/fs/${FSTYP}/${dname}/${entry}: No such file or directory"
+	fi
+	$UMOUNT_PROG $tmp_mnt
+	rm -rf $tmp_mnt
+}
+
+# Write "content" into /sys/fs/$FSTYP/$DEV/$ENTRY
+_set_fs_sysfs_param()
+{
+	local dev=$1
+	shift
+	local entry=$1
+	shift
+	local content="$*"
+
+	if [ ! -b "$dev" -o -z "$entry" -o -z "$content" ];then
+		_fail "Usage: _set_fs_sysfs_param <mounted_device> <entry> <content>"
+	fi
+
+	local dname=$(_short_dev $dev)
+	echo "$content" > /sys/fs/${FSTYP}/${dname}/${entry}
+}
+
 init_rc
 
 ################################################################################
-- 
2.5.5

