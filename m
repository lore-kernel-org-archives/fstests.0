Received: from mail.kernel.org ([198.145.29.136]:39962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1041316AbdDUP4Q (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Apr 2017 11:56:16 -0400
From: fdmanana@kernel.org
Subject: [PATCH] btrfs: fix local array declarations
Date: Fri, 21 Apr 2017 16:00:52 +0100
Message-Id: <20170421150052.22302-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

From: Filipe Manana <fdmanana@suse.com>

We were declaring local arrays using a notation that does not seem to be
standard resulting in failures on some systems, like for example in a
Debian Stretch installation with bash version 4.4.11(1)-release:

$ ./check btrfs/003 btrfs/027
FSTYP         -- btrfs
PLATFORM      -- Linux/x86_64 debian3 4.10.0-rc8-btrfs-next-37+
MKFS_OPTIONS  -- /dev/sdc
MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1

btrfs/003 45s ... [failed, exit status 1] - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/003.out.bad)
    --- tests/btrfs/003.out	2016-08-23 10:17:35.027012095 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/003.out.bad	2017-04-21 15:53:58.807366940 +0100
    @@ -1,2 +1,4 @@
     QA output created by 003
    -Silence is golden
    +./tests/btrfs/003: line 102: devs[]: bad array subscript
    +dev balance failed
    +(see /home/fdmanana/git/hub/xfstests/results//btrfs/003.full for details)
    ...
    (Run 'diff -u tests/btrfs/003.out /home/fdmanana/git/hub/xfstests/results//btrfs/003.out.bad'  to see the entire diff)
btrfs/027 7s ... [failed, exit status 1] - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/027.out.bad)
    --- tests/btrfs/027.out	2016-08-23 10:17:35.035012077 +0100
    +++ /home/fdmanana/git/hub/xfstests/results//btrfs/027.out.bad	2017-04-21 15:53:59.835367271 +0100
    @@ -1,2 +1,7 @@
     QA output created by 027
     Silence is golden
    +./common/rc: line 935: devs[]: bad array subscript
    +./common/rc: line 893: devs[]: bad array subscript
    +mkfs -m raid1 -d raid1 failed
    +Bug: str empty, must call _spare_dev_get before its put
    +(see /home/fdmanana/git/hub/xfstests/results//btrfs/027.full for details)
    ...
    (Run 'diff -u tests/btrfs/027.out /home/fdmanana/git/hub/xfstests/results//btrfs/027.out.bad'  to see the entire diff)
Ran: btrfs/003 btrfs/027
Failures: btrfs/003 btrfs/027
Failed 2 of 2 tests

So fix this by changing the declaration pattern "local dev[]=..." to the
standard way of "local -a dev=...".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 common/rc       | 4 ++--
 tests/btrfs/003 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 685b8591..e8943008 100644
--- a/common/rc
+++ b/common/rc
@@ -890,7 +890,7 @@ _spare_dev_get()
 		_notrun "All devs used no spare"
 	fi
 	# Get a dev that is not used
-	local devs[]="( $SCRATCH_DEV_POOL_SAVED )"
+	local -a devs="( $SCRATCH_DEV_POOL_SAVED )"
 	SPARE_DEV=${devs[@]:$ndevs:1}
 	export SPARE_DEV
 }
@@ -932,7 +932,7 @@ _scratch_dev_pool_get()
 
 	local test_ndevs=$1
 	local config_ndevs=`echo $SCRATCH_DEV_POOL| wc -w`
-	local devs[]="( $SCRATCH_DEV_POOL )"
+	local -a devs="( $SCRATCH_DEV_POOL )"
 
 	typeset -p config_ndevs >/dev/null 2>&1
 	if [ $? -ne 0 ]; then
diff --git a/tests/btrfs/003 b/tests/btrfs/003
index 3ec3a2d9..3e6cc28c 100755
--- a/tests/btrfs/003
+++ b/tests/btrfs/003
@@ -99,7 +99,7 @@ _test_single()
 _test_add()
 {
 	local i
-	local devs[]="( $SCRATCH_DEV_POOL )"
+	local -a devs="( $SCRATCH_DEV_POOL )"
 	local n=${#devs[@]}
 
 	n=$(($n-1))
-- 
2.11.0

