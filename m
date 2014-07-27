Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:18312 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068AbaG0QjF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sun, 27 Jul 2014 12:39:05 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6RGd4pT023475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Sun, 27 Jul 2014 12:39:04 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common: get fs type again using device canonical name in _fs_type
Date: Mon, 28 Jul 2014 00:37:30 +0800
Message-Id: <1406479050-10601-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

When testing with lvm, a previous btrfsck run could change df output
from something like

/dev/mapper/rhel_hp--dl388eg8--01-testlv1 btrfs 15728640 900 13602172 1% /mnt/btrfs

to

/dev/dm-3 btrfs 15728640 900 13602172 1% /mnt/btrfs

So "_fs_type $device" couldn't find the mounted btrfs in
_check_btrfs_filesystem and the fs couldn't get unmounted, then a latter
btrfsck reports the btrfs is currently mounted, which could fail the test.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 2c83340..a4fb21d 100644
--- a/common/rc
+++ b/common/rc
@@ -802,7 +802,13 @@ _fs_type()
     # Fix the filesystem type up here so that the callers don't
     # have to bother with this quirk.
     #
-    _df_device $1 | $AWK_PROG '{ print $2 }' | sed -e 's/nfs4/nfs/'
+    local fstype=`_df_device $1 | $AWK_PROG '{ print $2 }' | sed -e 's/nfs4/nfs/'`
+    # in case $device is a symlink(lvm) and df gives out the canonical name
+    if [ "$fstype" == "" ]; then
+        _df_device `_real_dev $1` | $AWK_PROG '{ print $2 }' | sed -e 's/nfs4/nfs/'`
+    else
+        echo $fstype
+    fi
 }
 
 # return the FS mount options of a mounted device
-- 
1.9.3

