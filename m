Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:53655 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932581AbaLLTnH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 12 Dec 2014 14:43:07 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] common: use mke2fs -F instead of piping in yes
Date: Fri, 12 Dec 2014 14:42:54 -0500
Message-Id: <1418413374-17380-1-git-send-email-tytso@mit.edu>
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

Using mke2fs's -F option instad of "yes | $MKFS_PROG" fixes this issue.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 692d45c..ec4440b 100644
--- a/common/rc
+++ b/common/rc
@@ -517,6 +517,9 @@ _test_mkfs()
     btrfs)
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
+    ext2|ext3|ext4)
+	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
@@ -535,6 +538,11 @@ _mkfs_dev()
     btrfs)
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* 2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
 	;;
+    ext2|ext3|ext4)
+	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* \
+		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
+	;;
+
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* \
 		2>$tmp_dir.mkfserr 1>$tmp_dir.mkfsstd
@@ -581,6 +589,9 @@ _scratch_mkfs()
     btrfs)
         $MKFS_BTRFS_PROG $MKFS_OPTIONS $* $SCRATCH_DEV > /dev/null
 	;;
+    ext2|ext3)
+	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $SCRATCH_DEV
+	;;
     ext4)
 	_scratch_mkfs_ext4 $*
 	;;
@@ -657,7 +668,7 @@ _scratch_mkfs_sized()
 	fi
 	;;
     ext2|ext3|ext4|ext4dev)
-	yes | ${MKFS_PROG}.$FSTYP $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
+	${MKFS_PROG}.$FSTYP -F $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
 	;;
     udf)
 	$MKFS_UDF_PROG $MKFS_OPTIONS -b $blocksize $SCRATCH_DEV $blocks
-- 
2.1.0

