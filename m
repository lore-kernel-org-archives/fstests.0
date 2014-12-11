Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:50491 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933514AbaLKCZ1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 10 Dec 2014 21:25:27 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] common: suppress "Broken pipe" errors
Date: Wed, 10 Dec 2014 21:25:18 -0500
Message-Id: <1418264718-31198-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

It's possible based on a race conditions (and possibly the version of
coreutils which supplies /usr/bin/yes) that commands of the form:

yes | $MKFS_PROG ...

will end up causing the following failure:

shared/298 16s ...	[23:49:03] [23:49:19] - output mismatch (see /results/results-4k/shared/298.out.bad)
    --- tests/shared/298.out	2014-10-31 10:13:04.000000000 -0400
    +++ /results/results-4k/shared/298.out.bad	2014-11-29 23:49:19.118138099 -0500
    @@ -1,4 +1,6 @@
     QA output created by 298
    +yes: standard output: Broken pipe
    +yes: write error
     Generating garbage on loop...done.
     Running fstrim...done.
     Detecting interesting holes in image...done.
    ...
    (Run 'diff -u tests/shared/298.out /results/results-4k/shared/298.out.bad'  to see the entire diff)

The simplest way to fix this is to redirect the stderr of the yes
command to /dev/null.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index d5e3aff..39a1432 100644
--- a/common/rc
+++ b/common/rc
@@ -518,7 +518,7 @@ _test_mkfs()
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
     *)
-	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
+	yes 2>/dev/null | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
     esac
 }
@@ -536,7 +536,7 @@ _mkfs_dev()
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	;;
     *)
-	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
+	yes 2>/dev/null | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
 		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	;;
     esac
@@ -586,7 +586,7 @@ _scratch_mkfs()
 	# do nothing for tmpfs
 	;;
     *)
-	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $SCRATCH_DEV
+	yes 2>/dev/null | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $SCRATCH_DEV
 	;;
     esac
 }
@@ -655,7 +655,8 @@ _scratch_mkfs_sized()
 	fi
 	;;
     ext2|ext3|ext4|ext4dev)
-	yes | ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+	yes 2>/dev/null | ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize \
+		$SCRATCH_DEV $blocks
 	;;
     udf)
 	$MKFS_UDF_PROG $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
-- 
2.1.0

