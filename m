Received: from mx2.suse.de ([195.135.220.15]:56112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933187AbdC3PNE (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 30 Mar 2017 11:13:04 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16046AD0D
        for <fstests@vger.kernel.org>; Thu, 30 Mar 2017 15:13:02 +0000 (UTC)
From: David Sterba <dsterba@suse.com>
Subject: [PATCH] btrfs: use full subcommand names
Date: Thu, 30 Mar 2017 17:06:33 +0200
Message-Id: <20170330150633.14962-1-dsterba@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
List-ID: <fstests@vger.kernel.org>

Update the remaining calls to 'btrfs' that use shortened command names.
Use of full names is recommended to avoid any ambiguities.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 tests/btrfs/027 | 2 +-
 tests/btrfs/085 | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/btrfs/027 b/tests/btrfs/027
index 46970a2918a7..2c8b458e5ff4 100755
--- a/tests/btrfs/027
+++ b/tests/btrfs/027
@@ -78,7 +78,7 @@ run_test()
 	_scratch_mount >>$seqres.full 2>&1
 
 	local missing_dev=`echo $SCRATCH_DEV_POOL | awk '{print $2}'`
-	local missing_dev_id=`$BTRFS_UTIL_PROG fi show $SCRATCH_MNT | grep $missing_dev | awk '{print $2}'`
+	local missing_dev_id=`$BTRFS_UTIL_PROG filesystem show $SCRATCH_MNT | grep $missing_dev | awk '{print $2}'`
 
 	# get some data on the filesystem so there's something to replace
 	_ddt of="$SCRATCH_MNT"/file1 bs=1M count=1 >> $seqres.full 2>&1
diff --git a/tests/btrfs/085 b/tests/btrfs/085
index 3dbc67f5d40b..804899724cba 100755
--- a/tests/btrfs/085
+++ b/tests/btrfs/085
@@ -134,14 +134,14 @@ test_orphan()
 
 new_subvolume()
 {
-	_run_btrfs_util_prog subvol create $SCRATCH_MNT/testdir
+	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/testdir
 }
 
 new_default()
 {
 	new_subvolume
-	SUB=$($BTRFS_UTIL_PROG subvol list $SCRATCH_MNT |awk '{print $2}')
-	_run_btrfs_util_prog subvol set-default $SUB $SCRATCH_MNT
+	SUB=$($BTRFS_UTIL_PROG subvolume list $SCRATCH_MNT |awk '{print $2}')
+	_run_btrfs_util_prog subvolume set-default $SUB $SCRATCH_MNT
 
 	_unmount_flakey
 	_mount_flakey
-- 
2.12.0

