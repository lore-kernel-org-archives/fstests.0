Received: from mx2.suse.de ([195.135.220.15]:39105 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936976AbeE2Q4G (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 29 May 2018 12:56:06 -0400
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 48D28AD45
        for <fstests@vger.kernel.org>; Tue, 29 May 2018 16:56:05 +0000 (UTC)
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/6] xfs/310: Cleanup
Date: Tue, 29 May 2018 18:55:58 +0200
Message-Id: <20180529165601.32133-4-jack@suse.cz>
In-Reply-To: <20180529165601.32133-1-jack@suse.cz>
References: <20180529165601.32133-1-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Cleanup couple of things that were objected to when creating test
ext4/033 out of this one.

Use _require_scratch_nocheck instead of recreating scratch fs before
exiting. Avoid needless cleanup of dmhugedev on exit - _cleanup
takes care of that. Use _scratch_unmount where possible.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 tests/xfs/310 | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/xfs/310 b/tests/xfs/310
index f33a15ad028c..5c1f20ce453c 100755
--- a/tests/xfs/310
+++ b/tests/xfs/310
@@ -35,7 +35,6 @@ _cleanup()
 	umount $SCRATCH_MNT > /dev/null 2>&1
 	_dmhugedisk_cleanup
 	rm -rf $tmp.*
-	_scratch_mkfs >/dev/null 2>&1
 }
 
 # get standard environment, filters and checks
@@ -46,7 +45,7 @@ _cleanup()
 # real QA test starts here
 _supported_os Linux
 _supported_fs xfs
-_require_scratch
+_require_scratch_nocheck
 _require_xfs_scratch_rmapbt
 _require_xfs_io_command "falloc"
 
@@ -60,7 +59,7 @@ _scratch_mount >> $seqres.full
 testdir=$SCRATCH_MNT/test-$seq
 blksz="$(_get_block_size $SCRATCH_MNT)"
 
-umount $SCRATCH_MNT
+_scratch_unmount
 
 echo "Format huge device"
 nr_blks=2100000	# 2^21 plus a little more
@@ -110,7 +109,6 @@ test $nr_rmaps -eq 1 || xfs_db -c 'agf 0' -c 'addr rmaproot' -c 'p' $DMHUGEDISK_
 echo "Check and fake-repair huge filesystem again" | tee -a $seqres.full
 $XFS_DB_PROG -c 'check' $DMHUGEDISK_DEV
 $XFS_REPAIR_PROG -n $DMHUGEDISK_DEV >> $seqres.full 2>&1
-_dmhugedisk_cleanup
 
 echo "Done"
 
-- 
2.13.6

