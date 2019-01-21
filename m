Received: from mx2.suse.de ([195.135.220.15]:46338 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730116AbfAUQdo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 21 Jan 2019 11:33:44 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8266AAFB2
        for <fstests@vger.kernel.org>; Mon, 21 Jan 2019 16:33:43 +0000 (UTC)
From: jeffm@suse.com
Subject: [PATCH 1/7] btrfs/010: don't run without /sys/fs/btrfs
Date: Mon, 21 Jan 2019 11:33:10 -0500
Message-Id: <20190121163316.20616-1-jeffm@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jeff Mahoney <jeffm@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Jeff Mahoney <jeffm@suse.com>

Older kernels don't have /sys/fs/btrfs.  btrfs/010 will happily run
until it goes to check its work against sysfs and finds those
files don't exist.  This patch introduces a require check to
ensure that the sysfs files are present before running.

Signed-off-by: Jeff Mahoney <jeffm@suse.com>
---
 common/btrfs    | 8 ++++++++
 tests/btrfs/010 | 1 +
 2 files changed, 9 insertions(+)

diff --git a/common/btrfs b/common/btrfs
index 26dc0bb9..f6513c06 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -89,6 +89,14 @@ _require_btrfs_fs_feature()
 		_notrun "Feature $feat not supported by the available btrfs version"
 }
 
+_require_btrfs_fs_sysfs()
+{
+	modprobe btrfs > /dev/null 2>&1
+	[ -e /sys/fs/btrfs/features ] || \
+		_notrun "Sysfs not supported by the available btrfs version"
+
+}
+
 _check_btrfs_filesystem()
 {
 	device=$1
diff --git a/tests/btrfs/010 b/tests/btrfs/010
index 1a5f0146..72b2c727 100755
--- a/tests/btrfs/010
+++ b/tests/btrfs/010
@@ -33,6 +33,7 @@ rm -f $seqres.full
 _supported_fs btrfs
 _supported_os Linux
 _require_test
+_require_btrfs_fs_sysfs
 
 # Create 32k extents. All of these extents will be accounted as outstanding and
 # reserved.
-- 
2.16.4
