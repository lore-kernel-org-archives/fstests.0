Received: from mail.kernel.org ([198.145.29.136]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966396AbcKXVDS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 24 Nov 2016 16:03:18 -0500
From: fdmanana@kernel.org
Subject: [PATCH] fstests: btrfs, add missing umount for raid5 tests 124 and 125
Date: Thu, 24 Nov 2016 06:25:19 +0000
Message-Id: <1479968719-10713-1-git-send-email-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

The tests mount the second device in the device pool but never unmount
it, causing the next test to fail.

Example:

$ cat local.config
export TEST_DEV=/dev/sdb
export TEST_DIR=/home/fdmanana/btrfs-tests/dev
export SCRATCH_MNT="/home/fdmanana/btrfs-tests/scratch_1"
export SCRATCH_DEV_POOL="/dev/sdc /dev/sdd /dev/sde /dev/sdf /dev/sdg"
export FSTYP=btrfs

$ ./check btrfs/125 btrfs/126
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian3 4.8.0-rc8-btrfs-next-35+
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/125 23s ... 22s
btrfs/126 1s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/126.out.bad)
    --- tests/btrfs/126.out	2016-11-24 06:11:42.048372385 +0000
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/126.out.bad	2016-11-24 06:16:35.987988895 +0000
    @@ -1,2 +1,5 @@
     QA output created by 126
    -pwrite: Disk quota exceeded
    +ERROR: /dev/sdc is mounted
    +mount: /dev/sdc is already mounted or /home/fdmanana/btrfs-tests/scratch_1 busy
    +       /dev/sdc is already mounted on /home/fdmanana/btrfs-tests/scratch_1
    +/home/fdmanana/btrfs-tests/scratch_1/test_file: Disk quota exceeded
    ...
    (Run 'diff -u tests/btrfs/126.out /home/fdmanana/git/hub/xfstests/results//btrfs/126.out.bad'  to see the entire diff)
Ran: btrfs/125 btrfs/126
Failures: btrfs/126
Failed 1 of 2 tests

So just make sure those test unmount the device before they finish.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 tests/btrfs/124 | 1 +
 tests/btrfs/125 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/btrfs/124 b/tests/btrfs/124
index 2618a26..7206094 100755
--- a/tests/btrfs/124
+++ b/tests/btrfs/124
@@ -159,6 +159,7 @@ if [ "$checkpoint1" != "$checkpoint3" ]; then
 	echo "Inital sum does not match with data on dev2 written by balance"
 fi
 
+$UMOUNT_PROG $dev2
 _scratch_dev_pool_put
 _test_mount
 
diff --git a/tests/btrfs/125 b/tests/btrfs/125
index 1062b87..91aa8d8 100755
--- a/tests/btrfs/125
+++ b/tests/btrfs/125
@@ -175,6 +175,7 @@ if [ "$checkpoint1" != "$checkpoint3" ]; then
 	echo "Inital sum does not match with data on dev2 written by balance"
 fi
 
+$UMOUNT_PROG $dev2
 _scratch_dev_pool_put
 _test_mount
 
-- 
2.7.0.rc3

