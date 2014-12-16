Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:58993 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbaLPP4a (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 16 Dec 2014 10:56:30 -0500
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] ext4/004: limit the amount of data written so test runs faster
Date: Tue, 16 Dec 2014 10:56:27 -0500
Message-Id: <1418745387-27930-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Previously this test was taking 6-7 minutes, and writing half a
gigabyte of data in the dump/restore test directory.  Change this to
be about 60 megs, and to take ~20 seconds.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/004 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/004 b/tests/ext4/004
index b24b627..68f02b6 100755
--- a/tests/ext4/004
+++ b/tests/ext4/004
@@ -49,7 +49,7 @@ restore_dir=$TEST_DIR/dump_restore_dir
 workout()
 {
 	echo "Run fsstress" >> $seqres.full
-	args=`_scale_fsstress_args -z -f creat=5 -f write=20 -f mkdir=5 -n 1000 -p 15 -d $dump_dir`
+	args=`_scale_fsstress_args -z -f creat=5 -f write=20 -f mkdir=5 -n 100 -p 15 -d $dump_dir`
 	echo "fsstress $args" >> $seqres.full
 
 	$FSSTRESS_PROG $args >> $seqres.full 2>&1
-- 
2.1.0

