Received: from imap.thunk.org ([74.207.234.97]:35993 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbcBKF41 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Feb 2016 00:56:27 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 04/13] generic: remove the generic/125 test
Date: Thu, 11 Feb 2016 00:56:13 -0500
Message-Id: <1455170182-32587-5-git-send-email-tytso@mit.edu>
In-Reply-To: <1455170182-32587-1-git-send-email-tytso@mit.edu>
References: <1455170182-32587-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: hughd@google.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Dave Chinner has pointed out this test is largely pointless:

   Perhaps one should question whether generic/125 is actually testing
   anything useful in the first place.

   i.e. it's writing 16k, then truncating it back to 1000 bytes, then
   reading it with direct IO for 60s to see if it returns the correct
   data for that entire time.

   What, exactly, is going to cause that test to fail?

   Keep in mind this was ported from a CXFS test, where the metadata
   server did the truncation operation (including the data zeroing),
   but the reads are being done from the client.  i.e. it was designed
   to test whether a remote machine is doing a truncate correctly on a
   access shared disk.

   IMO, I think we just remove the test, src/trunc.c and src/ftrunc.c
   because it's 60s of testing that doesn't actually provide any value
   to us.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/generic/125   | 68 -----------------------------------------------------
 tests/generic/group |  1 -
 2 files changed, 69 deletions(-)
 delete mode 100755 tests/generic/125

diff --git a/tests/generic/125 b/tests/generic/125
deleted file mode 100755
index bcf9b3e..0000000
--- a/tests/generic/125
+++ /dev/null
@@ -1,68 +0,0 @@
-#! /bin/bash
-# FSQA Test No. 125
-#
-# ftruncate test, modified from CXFSQA tests cxfs_ftrunc and cxfs_trunc
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
-#
-
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "exit \$status" 0 1 2 3 15
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-
-# real QA test starts here
-_supported_fs generic
-_supported_os Linux
-
-_require_test
-_require_user
-
-TESTDIR=$TEST_DIR/ftrunc
-TESTFILE=$TESTDIR/ftrunc.tmp
-
-[ -d $TESTDIR ] && rm -r $TESTDIR
-mkdir $TESTDIR
-
-# ftrunc must be run as a mortal user.
-touch $TESTFILE
-
-chmod a+rw $TESTDIR
-chmod a+rw $TESTFILE
-
-su $qa_user -c "./src/ftrunc -f $TESTFILE"
-
-if [ "$?" != "0" ];  then
-    echo src/ftrunc returned non 0 status!
-fi
-
-src/trunc -f $TESTFILE
-if (test $? -eq 0 ) then
-    status=0
-fi
-
-exit
diff --git a/tests/generic/group b/tests/generic/group
index 860ff4a..24e5f9a 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -127,7 +127,6 @@
 122 auto quick clone dedupe
 123 perms auto quick
 124 pattern auto quick
-125 other auto
 126 perms auto quick
 127 rw auto
 128 perms auto quick
-- 
2.5.0

