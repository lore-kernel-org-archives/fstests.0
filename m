Return-Path: <fstests-owner@vger.kernel.org>
Received: from imap.thunk.org ([74.207.234.97]:52797 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbaI0WR7 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Sat, 27 Sep 2014 18:17:59 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/3] ext4: use mkfs.ext4 -F instead of piping in yes
Date: Sat, 27 Sep 2014 18:17:50 -0400
Message-Id: <1411856271-30789-2-git-send-email-tytso@mit.edu>
In-Reply-To: <1411856271-30789-1-git-send-email-tytso@mit.edu>
References: <20140927221234.GC11222@thunk.org>
 <1411856271-30789-1-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

Using "yes | mkfs.ext4 ..." results in the error message results in
the test failing, at least for some versions of e2fsprogs:

    +yes: standard output: Broken pipe
    +yes: write error

It better to use the -F option, which will eliminate the questions.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Eryu Guan <eguan@redhat.com>
Cc: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 tests/ext4/003 | 2 +-
 tests/ext4/306 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/003 b/tests/ext4/003
index fde0e9c..53875a9 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -43,7 +43,7 @@ _require_ext4_bigalloc
 
 rm -f $seqres.full
 
-yes | $MKFS_EXT4_PROG -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
+$MKFS_EXT4_PROG -F -O bigalloc -C 65536  -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
 _scratch_mount || _fail "couldn't mount fs"
 
diff --git a/tests/ext4/306 b/tests/ext4/306
index caffe0e..edc0204 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -48,7 +48,7 @@ _require_scratch
 rm -f $seqres.full
 
 # Make a small ext4 fs with extents disabled & mount it
-yes | $MKFS_EXT4_PROG -O ^extents,^64bit $SCRATCH_DEV 512m >> $seqres.full 2>&1
+$MKFS_EXT4_PROG -F -O ^extents,^64bit $SCRATCH_DEV 512m >> $seqres.full 2>&1
 _scratch_mount || _fail "couldn't mount fs"
 
 # Create a small non-extent-based file
-- 
2.1.0

