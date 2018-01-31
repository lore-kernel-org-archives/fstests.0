Received: from szxga04-in.huawei.com ([45.249.212.190]:5150 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750904AbeAaKTq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 31 Jan 2018 05:19:46 -0500
From: "zhangyi (F)" <yi.zhang@huawei.com>
Subject: [xfstests PATCH v2 1/5] common/rc: improve mounted check helper
Date: Wed, 31 Jan 2018 18:27:55 +0800
Message-ID: <20180131102759.40997-2-yi.zhang@huawei.com>
In-Reply-To: <20180131102759.40997-1-yi.zhang@huawei.com>
References: <20180131102759.40997-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com, fstests@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org, miklos@szeredi.hu, amir73il@gmail.com, yi.zhang@huawei.com, miaoxie@huawei.com, yangerkun@huawei.com
List-ID: <fstests@vger.kernel.org>

Modify _is_mounted() to accept a dir and fstype as input, and check
whether this dir is a specified type of mount point.

This patch also fix the problem of missing fstype check:

For example:
  Base mounted filesystem:
    /dev/sda2 on /boot type ext4 (rw,relatime,data=ordered)

  FSTYPE=xfs
  mountpoint=`_is_mounted /dev/sda1`
  echo "$mountpoint"

  Output: /boot

This patch remove the useless error message, return empty if no
valid mount point.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 common/rc | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/common/rc b/common/rc
index 2e3a83a..3351f00 100644
--- a/common/rc
+++ b/common/rc
@@ -2372,27 +2372,22 @@ _scratch_mkfs_richacl()
 	esac
 }
 
-# check that a FS on a device is mounted
+# check that a FS on a device is mounted or a dir is a mount point
 # if so, return mount point
 #
 _is_mounted()
 {
-    if [ $# -ne 1 ]
-    then
-	echo "Usage: _is_mounted device" 1>&2
-	exit 1
-    fi
+	if [ $# -lt 1 ]; then
+		echo "Usage: _is_mounted <device|mountpoint> [fstype]" 1>&2
+		exit 1
+	fi
 
-    device=$1
+	local name=$1
+	local fstype=${2-$FSTYP}
 
-    if _mount | grep "$device " | $AWK_PROG -v pattern="type $FSTYP" '
-        pattern        { print $3 ; exit 0 }
-        END            { exit 1 }
-    '
-    then
-        echo "_is_mounted: $device is not a mounted $FSTYP FS"
-        exit 1
-    fi
+	_mount | grep "$name " | $AWK_PROG -v pattern="type $fstype" '
+		$0 ~ pattern	{ print $3 }
+	'
 }
 
 # remount a FS to a new mode (ro or rw)
-- 
2.5.0

