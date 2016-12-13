Received: from mail-pg0-f66.google.com ([74.125.83.66]:34837 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbcLMG6B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Dec 2016 01:58:01 -0500
Received: by mail-pg0-f66.google.com with SMTP id p66so3542389pga.2
        for <fstests@vger.kernel.org>; Mon, 12 Dec 2016 22:58:01 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] generic/062: don't assume same readdir order after re-creating directory
Date: Mon, 12 Dec 2016 22:57:01 -0800
Message-Id: <1481612221-65504-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

generic/062 uses getfattr to dump xattrs for a directory tree, then
deletes and recreates that directory tree, then dumps the xattrs again
and compares the dump to the original.  This was failing when run on
ext4 with encryption enabled because getfattr's output is in readdir
order, but ext4 encryption by design chooses unpredictable encrypted
filenames for each new directory, causing the readdir order to change
after backup and restore.  It is not really a valid assumption that the
readdir order will always be the same, so update the test to sort the
filenames, removing this assumption.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/generic/062 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/generic/062 b/tests/generic/062
index e4dc2cc..643f02c 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -178,8 +178,11 @@ echo; echo
 
 _backup()
 {
-	# NB: no filtering of scratch here... (need to restore too)
-	$GETFATTR_PROG --absolute-names -dh -R -m '.' $SCRATCH_MNT >$1
+	# Note: we don't filter scratch here since we need to restore too.  But
+	# we *do* sort the output by path, since it otherwise would depend on
+	# readdir order, which on some filesystems may change after re-creating
+	# the files.
+	$GETFATTR_PROG --absolute-names -dh -R -m '.' $SCRATCH_MNT | _sort_getfattr_output >$1
 	echo BACKUP $1 >>$seqres.full
 	cat $1 >> $seqres.full
 	[ ! -s $1 ] && echo "warning: $1 (backup file) is empty"
-- 
2.8.0.rc3.226.g39d4020

